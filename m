From: Caleb Cushing <xenoterracide@gmail.com>
Subject: Re: gmail screws up patches looking for workable workaround
Date: Fri, 13 Feb 2009 13:20:46 -0500
Message-ID: <81bfc67a0902131020w66e114b7ke642ab8308e530c3@mail.gmail.com>
References: <81bfc67a0902130909i154a7c2epeff98347985c3fb8@mail.gmail.com>
	 <8c9a060902130926j48b59785l624a3966254517e5@mail.gmail.com>
	 <81bfc67a0902131000n2d67e88epd743c7c39842fbc@mail.gmail.com>
	 <8c9a060902131011u5bc7d0dft4edc4adb1af1dad8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Dan Robbins <drobbins@funtoo.org>
To: Jacob Helwig <jacob.helwig@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 13 19:22:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LY2g4-0008Ab-Q5
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 19:22:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752350AbZBMSUt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 13:20:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752125AbZBMSUt
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 13:20:49 -0500
Received: from mail-qy0-f11.google.com ([209.85.221.11]:58138 "EHLO
	mail-qy0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775AbZBMSUs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 13:20:48 -0500
Received: by qyk4 with SMTP id 4so1793688qyk.13
        for <git@vger.kernel.org>; Fri, 13 Feb 2009 10:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=6PGjX0q3+d0Y2Dg5Z15fFP8IY/6stCfyPVH4dtPCqCc=;
        b=Ccb8mabCdPIUa5afxZx58VtTluPpfv16z+sX07LtMv3OcjUD7ZMuzRKALH5OHi9+RS
         v+qFKKgaKYRi7Zvy/flv1H6k0EHJy3XB7k/SIiCt03SB2sirJJNRcGjRTgtUoJGX+pKb
         SOqSkxMgxFZAebE8P53dhCFMFNUP4UUBppjOE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=DUeXANnb1nSONP9Sc2xkJSKPlqBj9bVuYsycStkgPfH1yeGCy5HzQ7j078Qo8qmeu0
         MRcYv+Y5eDv+rirUF9U8kZkZ7ee/EdHda+jPhd5hPs37T2L/lSJ1zReghXbh86NYEda9
         O16yUzg3ga7ujID3bsJxx7q4z2LsPDbBh5MJk=
Received: by 10.229.82.15 with SMTP id z15mr768377qck.32.1234549246817; Fri, 
	13 Feb 2009 10:20:46 -0800 (PST)
In-Reply-To: <8c9a060902131011u5bc7d0dft4edc4adb1af1dad8@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109770>

> "git imap-send" doesn't use the [sendmail] section of the .gitconfig.
> It uses the [imap] section.  The [sendmail] configuration is if you're
> using "git send-email".

yeah... I've both set up, and followed your sendmail instructions explicitly

> If you setup the smtp* options, you don't need a local MTA, since
> send-email will use the SMTP server you configured.

tell that to the postdrop (postfix) error that I saw on the screen.

> Are you still getting the corruption if you let format-patch generate
> the patch on disk (don't use the --stdout option), and give the patch
> filename(s) as the final arguments to send-email?  (Could you show the
> new sequence of commands you're using, and what the output is?)
>

no... no corruption locally. the problem is the mail never arrives. I
don't know where it disappears at, but it doesn't make it to the inbox
I send it to, and I really, really, really do not want to troubleshoot
any of the 1000 places it could have gone wrong

 git send-email 00*
0001-remove-mysql-community-5.1-beta.patch
Who should the emails appear to be from? [Caleb Cushing
<xenoterracide@gmail.com>]
Emails will be sent from: Caleb Cushing <xenoterracide@gmail.com>
Who should the emails be sent to? xenoterracide@gmail.com
Message-ID to be used as In-Reply-To for the first email?
xenoterracide@gmail.com
(mbox) Adding cc: Caleb Cushing <xenoterracide@gmail.com> from line
'From: Caleb Cushing <xenoterracide@gmail.com>'
(sob) Adding cc: Caleb Cushing <xenoterracide@gmail.com> from line
'Signed-off-by: Caleb Cushing <xenoterracide@gmail.com>'
postdrop: warning: unable to look up public/pickup: No such file or directory
OK. Log says:
Sendmail: /usr/sbin/sendmail -i xenoterracide@gmail.com
From: Caleb Cushing <xenoterracide@gmail.com>
To: xenoterracide@gmail.com
Subject: [PATCH] remove mysql-community-5.1*beta
Date: Fri, 13 Feb 2009 13:19:14 -0500
Message-Id: <1234549154-24500-1-git-send-email-xenoterracide@gmail.com>
X-Mailer: git-send-email 1.6.1.3
In-Reply-To: <xenoterracide@gmail.com>
References: <xenoterracide@gmail.com>

Result: OK

and yet no email ever arrives at my inbox. (or spam for that matter)
-- 
Caleb Cushing

http://xenoterracide.blogspot.com
