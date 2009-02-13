From: Caleb Cushing <xenoterracide@gmail.com>
Subject: Re: gmail screws up patches looking for workable workaround
Date: Fri, 13 Feb 2009 13:00:32 -0500
Message-ID: <81bfc67a0902131000n2d67e88epd743c7c39842fbc@mail.gmail.com>
References: <81bfc67a0902130909i154a7c2epeff98347985c3fb8@mail.gmail.com>
	 <8c9a060902130926j48b59785l624a3966254517e5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Dan Robbins <drobbins@funtoo.org>
To: Jacob Helwig <jacob.helwig@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 13 19:02:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LY2Mp-0000Ll-V3
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 19:02:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752634AbZBMSAg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 13:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752283AbZBMSAg
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 13:00:36 -0500
Received: from mail-qy0-f11.google.com ([209.85.221.11]:47504 "EHLO
	mail-qy0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752182AbZBMSAf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 13:00:35 -0500
Received: by qyk4 with SMTP id 4so1779963qyk.13
        for <git@vger.kernel.org>; Fri, 13 Feb 2009 10:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=g60fLAaGJwl5ZNIkn89BMiFl5zUJWLrBy0/Q3r7kz8k=;
        b=ZBxmnJNYTF75+w3G16IQ2WWf3B87sVU5lUDuKkEsL9sqFbfcR78KUQA9u5JaPVuQ7A
         KdNhpUk6MRW3kq8zscIY+UbvOCnpv4pK4/oK+n3tZZK9R+Fn7EEdVxFZam4m4R4M0caS
         v7vmd3TR8MxeF7ujgzJ/aUR9ux+vZ5qTpszO4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=T963BLWzh0LJC8oAyXGMSAhCaVjFffdU1gt+VxLo/DC38XPdOoKziml56Ft0e+Noce
         ZC9NDZ8ifQncQQI6Bg58kVAzCmNzwv/UeHTtA2y0wBKUp/uMBenfTsCLVSwT5RDcKpAE
         F25Cwk45wmL2UvtgO2MC7LvcW8STPPyUXDBBw=
Received: by 10.229.109.194 with SMTP id k2mr746457qcp.6.1234548032897; Fri, 
	13 Feb 2009 10:00:32 -0800 (PST)
In-Reply-To: <8c9a060902130926j48b59785l624a3966254517e5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109767>

> ~/.gitconfig
> [sendemail]
>    smtpserver = smtp.gmail.com
>    smtpserverport = 587
>    smtpuser = your.email@gmail.com
>    smtppass = yourPassword
>    smtpencryption = tls
>
> $ git format-patch <options>
> # add comments to 00*.patch files.
> $ git send-email 00*
> I've never seen any mangling using send-email, and the gmail SMTP
> server.  I've never actually tried using imap-send.  Not quite the
> answer to your question, but hopefully, it's another option.
>

[sendmail]
    smtpserver = smtp.gmail.com
    smtpserverport = 587
    smtpuser = xenoterracide@gmail.com
    smtppass = YeahITypedThisRight
    smtpencryption = tls

everything look good here? because mail isn't actually reaching it's
destination. I have a feeling that's because the MTA isn't set up. I
/could/ set that up... but I don't think that's something that anyone
should have to do to send email patches.

also according to someone else the reason git can't handle the
attachments is because they are still base64 encoded.
-- 
Caleb Cushing

http://xenoterracide.blogspot.com
