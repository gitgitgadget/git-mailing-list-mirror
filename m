From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] Documentation/SubmittingPatches: Clarify Gmail section
Date: Thu, 8 Apr 2010 01:48:33 +0530
Message-ID: <y2gf3271551004071318zb4ed7ef6o93a6c98c6009d8df@mail.gmail.com>
References: <1270668793-2187-1-git-send-email-artagnon@gmail.com> 
	<1270668793-2187-2-git-send-email-artagnon@gmail.com> <7vwrwjav4h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	John Tapsell <johnflux@gmail.com>,
	Aaron Crane <git@aaroncrane.co.uk>,
	A Large Angry SCM <gitzilla@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jacob Helwig <jacob.helwig@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 07 22:19:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzbiF-0003Lg-SR
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 22:19:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751907Ab0DGUSy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Apr 2010 16:18:54 -0400
Received: from mail-yx0-f171.google.com ([209.85.210.171]:45289 "EHLO
	mail-yx0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750986Ab0DGUSy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Apr 2010 16:18:54 -0400
Received: by yxe1 with SMTP id 1so355326yxe.33
        for <git@vger.kernel.org>; Wed, 07 Apr 2010 13:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=USXZmPLfBYsWPfkFTn/pncgzTCHAZ715F2Fr5wlt/ZE=;
        b=u1CjBO5I83LtI/zdimTOw9LbMylU7tWfU8UVjRq45WPWJGLd2K1yu1nBtmLXcm1mNP
         oAxpBtWav5vZC56OHkavCTWsnQFiItinYumvzox6aJQmz/perBwDH8RJ7VlhdDAw6En1
         +ONUMDKZG+emyRETkBDV6mCUDLW0E3qMj15NU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=cAEo968/k6NeSiF9hu7UXKr6oaEt6BgLram+ZPGQGgG4RE9WGg7IHipvPC7PcHwMgH
         bBB0gGuAfhcYSHEyKCPPsJDW7Crd4/GgbVTBclfTInVLFFUrAmFZ/DXSSejpxVQGglEh
         PSmWCZgzpIYryzS3TkYxaUM34k/qW4P4/KrtQ=
Received: by 10.90.69.14 with HTTP; Wed, 7 Apr 2010 13:18:33 -0700 (PDT)
In-Reply-To: <7vwrwjav4h.fsf@alter.siamese.dyndns.org>
Received: by 10.90.2.23 with SMTP id 23mr3233305agb.103.1270671533190; Wed, 07 
	Apr 2010 13:18:53 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144282>

> Is the web interface the _only_ way to interact with IMAP drafts on Gmail?
> If that is the case, your patch (or Aaron's earlier attempt) to make the
> document not to talk about imap-send in the context of Gmail makes sense.

No. An email client can sync with the drafts folder in GMail over
IMAP. However, sending the final email has to be done over SMTP.
The effect of "git imap-send" can be replicated by copy-pasting text
into the email client's compose interface. So, using "git imap-send"
seems like a bit of a roundabout way to me. There are some usecases
though (like queuing up patches as drafts before sending): so I'll add
a paragraph about this in my next revision.

-- Ram
