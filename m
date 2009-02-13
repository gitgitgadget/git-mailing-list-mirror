From: Jacob Helwig <jacob.helwig@gmail.com>
Subject: Re: gmail screws up patches looking for workable workaround
Date: Fri, 13 Feb 2009 11:35:47 -0800
Message-ID: <8c9a060902131135m2b8e89d3s25d3b4455dae0f32@mail.gmail.com>
References: <81bfc67a0902130909i154a7c2epeff98347985c3fb8@mail.gmail.com>
	 <8c9a060902130926j48b59785l624a3966254517e5@mail.gmail.com>
	 <81bfc67a0902131000n2d67e88epd743c7c39842fbc@mail.gmail.com>
	 <8c9a060902131011u5bc7d0dft4edc4adb1af1dad8@mail.gmail.com>
	 <81bfc67a0902131020w66e114b7ke642ab8308e530c3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Dan Robbins <drobbins@funtoo.org>
To: Caleb Cushing <xenoterracide@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 13 20:37:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LY3qr-0003gp-G5
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 20:37:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752182AbZBMTfz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 14:35:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752010AbZBMTfz
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 14:35:55 -0500
Received: from mail-qy0-f11.google.com ([209.85.221.11]:50591 "EHLO
	mail-qy0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751001AbZBMTfy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 14:35:54 -0500
Received: by qyk4 with SMTP id 4so1840838qyk.13
        for <git@vger.kernel.org>; Fri, 13 Feb 2009 11:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=FdGj1hQ+LrVei7DBX3g9UaRQ208hP0eTHl4Y7swEcmw=;
        b=azgPH1mfnXr2mDp40fGc/zmJleO6NIzv1rNuxb7EACdcYGxzO8YCj5Ad9GXI9nIxD8
         9OwuuPfypeN1XEmBZ5bAIgsijS0GApY0uRfIZ4TrLEfoSrSRlP4EzTiX4UZ476+vGGzr
         SC/9PlTrnlfca1zVK3Bqx1Gmr16pQ36rmOq9s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=dj+2qpwhxQE/zyDBN8x3tqIEHlG3FVcYmTeyeohHtbKtYm6MVm0B6v9t6VSJCDF2yT
         km39/Y694y3eaTuQq/EhDsiot7W55LAfJM7LOjgU1sAF6/ujYDIeCVaAZ0wkVe/838pQ
         7wdgJP5Mj4mChOYcNkd+So5fheZd6kyOR24gM=
Received: by 10.224.19.131 with SMTP id a3mr292558qab.199.1234553747592; Fri, 
	13 Feb 2009 11:35:47 -0800 (PST)
In-Reply-To: <81bfc67a0902131020w66e114b7ke642ab8308e530c3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109774>

On Fri, Feb 13, 2009 at 10:20, Caleb Cushing <xenoterracide@gmail.com> wrote:
>> "git imap-send" doesn't use the [sendmail] section of the .gitconfig.
>> It uses the [imap] section.  The [sendmail] configuration is if you're
>> using "git send-email".
>
> yeah... I've both set up, and followed your sendmail instructions explicitly
>
>> If you setup the smtp* options, you don't need a local MTA, since
>> send-email will use the SMTP server you configured.
>
> tell that to the postdrop (postfix) error that I saw on the screen.
>
>> Are you still getting the corruption if you let format-patch generate
>> the patch on disk (don't use the --stdout option), and give the patch
>> filename(s) as the final arguments to send-email?  (Could you show the
>> new sequence of commands you're using, and what the output is?)
>>
>
> no... no corruption locally. the problem is the mail never arrives. I
> don't know where it disappears at, but it doesn't make it to the inbox
> I send it to, and I really, really, really do not want to troubleshoot
> any of the 1000 places it could have gone wrong
>
>  git send-email 00*
> 0001-remove-mysql-community-5.1-beta.patch
> Who should the emails appear to be from? [Caleb Cushing
> <xenoterracide@gmail.com>]
> Emails will be sent from: Caleb Cushing <xenoterracide@gmail.com>
> Who should the emails be sent to? xenoterracide@gmail.com
> Message-ID to be used as In-Reply-To for the first email?
> xenoterracide@gmail.com
> (mbox) Adding cc: Caleb Cushing <xenoterracide@gmail.com> from line
> 'From: Caleb Cushing <xenoterracide@gmail.com>'
> (sob) Adding cc: Caleb Cushing <xenoterracide@gmail.com> from line
> 'Signed-off-by: Caleb Cushing <xenoterracide@gmail.com>'
> postdrop: warning: unable to look up public/pickup: No such file or directory
> OK. Log says:
> Sendmail: /usr/sbin/sendmail -i xenoterracide@gmail.com

I should have looked more closely, when you posted your config.  You
have "[sendmail]", instead of "[sendemail]".  You're missing the "e"
on "email".  What made me re-look is the line right after "OK. Log
says:".

You should have seen:
OK. Log says:
Server: smtp.gmail.com

Not:
OK. Log says:
Sendmail: /usr/sbin/sendmail -i xenoterracide@gmail.com
