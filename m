From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH] Documentation/SubmittingPatches: Clarify Gmail section
Date: Thu, 8 Apr 2010 08:23:22 +1000
Message-ID: <k2m2cfc40321004071523z8c036cccs12302a70f25bb413@mail.gmail.com>
References: <1270668793-2187-1-git-send-email-artagnon@gmail.com>
	 <1270668793-2187-2-git-send-email-artagnon@gmail.com>
	 <7vwrwjav4h.fsf@alter.siamese.dyndns.org>
	 <y2gf3271551004071318zb4ed7ef6o93a6c98c6009d8df@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	John Tapsell <johnflux@gmail.com>,
	Aaron Crane <git@aaroncrane.co.uk>,
	A Large Angry SCM <gitzilla@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jacob Helwig <jacob.helwig@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 08 00:23:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nzdej-0002DX-24
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 00:23:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753669Ab0DGWXY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Apr 2010 18:23:24 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:33809 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752271Ab0DGWXX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Apr 2010 18:23:23 -0400
Received: by pwj9 with SMTP id 9so1462081pwj.19
        for <git@vger.kernel.org>; Wed, 07 Apr 2010 15:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type;
        bh=uLQuMFi9k3okja8PAVzzWGFpTH5d1wTIBzm6B+cdO1c=;
        b=PckR6k0UA8KUlv6FPBnTww0taw8yEywu7GlCZv46JDhTiu/Fqcc5qLtV8qAxnbFJvL
         gjQx2O5tVnAOFMyg38I+D5o1YYBMRQqbwO8VZUT7FJXm4tUVJDEtbDWGFiG7N/x2qTQW
         sJ1h39FL+nEXHe1oBoNFGLsC5B7HXGMTwk+ck=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=p/uneOYb/WHP14JG+0dLdmNweTFHWx3L9Rs8fNl+vG4b5cv+Ekrbp2b6nWiycyRDK4
         FVDIdu3w3V2/bgteb5JewT0bh4GeedfSwdKFr91YuXjhSXFT5HbPBn6+tb0Ib22uGIod
         /k2B8Yuf93/Cd17x7IrVFgD26EuCxYGhKbvSI=
Received: by 10.114.112.15 with HTTP; Wed, 7 Apr 2010 15:23:22 -0700 (PDT)
In-Reply-To: <y2gf3271551004071318zb4ed7ef6o93a6c98c6009d8df@mail.gmail.com>
Received: by 10.114.188.31 with SMTP id l31mr1784532waf.32.1270679003010; Wed, 
	07 Apr 2010 15:23:23 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144292>

On Thu, Apr 8, 2010 at 6:18 AM, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
>> Is the web interface the _only_ way to interact with IMAP drafts on Gmail?
>> If that is the case, your patch (or Aaron's earlier attempt) to make the
>> document not to talk about imap-send in the context of Gmail makes sense.
>
> No. An email client can sync with the drafts folder in GMail over
> IMAP. However, sending the final email has to be done over SMTP.
> The effect of "git imap-send" can be replicated by copy-pasting text
> into the email client's compose interface. So, using "git imap-send"
> seems like a bit of a roundabout way to me. There are some usecases
> though (like queuing up patches as drafts before sending): so I'll add
> a paragraph about this in my next revision.
>
> -- Ram
> --

git imap-send has far less manual steps than cut and pasting into an
e-mail client, so it is certainly preferable to cut-and-paste which
seems particularly error prone.

Perhaps the words could be changed to something like:

If you do want to use the imap-send option with Gmail you MUST use an
IMAP client that does not line wrap to do any final polishing of the
patch e-mails prior to submitting them to the list. If you use the
gmail web interface to edit the draft  messages in any way, line
wrapping WILL occur.

jon.
