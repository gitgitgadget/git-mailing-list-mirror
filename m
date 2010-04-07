From: Jacob Helwig <jacob.helwig@gmail.com>
Subject: Re: [PATCH] Documentation/SubmittingPatches: Clarify Gmail section
Date: Wed, 7 Apr 2010 13:06:42 -0700
Message-ID: <x2m8c9a061004071306n807b8010i12983bb2d6a144f9@mail.gmail.com>
References: <1270668793-2187-1-git-send-email-artagnon@gmail.com> 
	<1270668793-2187-2-git-send-email-artagnon@gmail.com> <7vwrwjav4h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	John Tapsell <johnflux@gmail.com>,
	Aaron Crane <git@aaroncrane.co.uk>,
	A Large Angry SCM <gitzilla@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 07 22:07:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzbWr-0006xP-Bg
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 22:07:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750966Ab0DGUHI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Apr 2010 16:07:08 -0400
Received: from mail-qy0-f179.google.com ([209.85.221.179]:62774 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717Ab0DGUHG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Apr 2010 16:07:06 -0400
Received: by qyk9 with SMTP id 9so1610931qyk.1
        for <git@vger.kernel.org>; Wed, 07 Apr 2010 13:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=NnL2hTUzziuwFAm8cMaRR8LGDHu5A6xkNDFb0/ALCQc=;
        b=Np0u8sutNTCpxCIZxo3FNaSJQTcEQVtKHDWg+wcc495/0jNV1468DVxj6HgdP1RLC+
         UjtaepftAin5nZOCMUVGEUkfljchOBRzVh1i61ud9yMME05OYqdaNgsOb9E0Pzhsivt4
         JvAOsM/NZXUt+04lH4Nl8WP9n9bBiAaJn4GIk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=CAhQIBem1TohZSEnWM58Cv98GNjUsBXlapfwTAUCp3YQca8ovVbUSBKsK8OfZoe8M+
         UUxL/qgyX6a4eLdmF0GXhDNgBB1+OVII6TmOpapZbY+k2J58EMg91JdOf8+sCsZ2NG0t
         BmQsif/AnVfQ3n3Ppc6xvQBljwZ6/FvcnVvls=
Received: by 10.229.215.2 with HTTP; Wed, 7 Apr 2010 13:06:42 -0700 (PDT)
In-Reply-To: <7vwrwjav4h.fsf@alter.siamese.dyndns.org>
Received: by 10.229.241.82 with SMTP id ld18mr1323517qcb.60.1270670823911; 
	Wed, 07 Apr 2010 13:07:03 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144281>

On Wed, Apr 7, 2010 at 13:02, Junio C Hamano <gitster@pobox.com> wrote:
> My impression has been that people are using MUAs that do not corrupt
> patches and are capable of using IMAP drafts folders with Gmail, without
> ever touching their patch-breaking web interface, and the description you
> removed was meant for them.
>
> Is the web interface the _only_ way to interact with IMAP drafts on Gmail?
> If that is the case, your patch (or Aaron's earlier attempt) to make the
> document not to talk about imap-send in the context of Gmail makes sense.
>

The web interface isn't the only way.  I use the IMAP drafs all the
time with mutt, and most mutt + gmail instructions I've seen online
setup this behavior.

> Even if it were not the case, as long as only very few people use IMAP
> drafts on Gmail via MUAs not their web interface, I am fine with your
> change to add send-email recipe to help Gmail users.
>
