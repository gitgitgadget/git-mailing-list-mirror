From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Gmail and unwanted line-wrapping
Date: Sat, 6 Feb 2010 21:47:39 +0100
Message-ID: <fabb9a1e1002061247k7a8fba5at4c687faac0dcabb8@mail.gmail.com>
References: <bc341e101002061229t7a1525c2w2d5a8e221124b3c2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Aaron Crane <git@aaroncrane.co.uk>
X-From: git-owner@vger.kernel.org Sat Feb 06 21:48:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdrZX-000500-69
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 21:48:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756035Ab0BFUsA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Feb 2010 15:48:00 -0500
Received: from mail-px0-f189.google.com ([209.85.216.189]:56024 "EHLO
	mail-px0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756018Ab0BFUr7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Feb 2010 15:47:59 -0500
Received: by pxi27 with SMTP id 27so2563899pxi.4
        for <git@vger.kernel.org>; Sat, 06 Feb 2010 12:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=xxEpIJNZWwafWXGOwxdzyZripZRDSlQVGUagYugW4nY=;
        b=dU/cXoGEhw5S4ZGmEc4LKUwhqHHfLeD1j760L+p7nVdlwpH1CarDMgaiv8xqUjS8Td
         VLYJOSzeuLFKrDIPhY14RGtfEvrlNdxOGR/a2Xa37+czcjCnQQZd9flGIn1HTNxYTdJ7
         y6beM+SbNVXB8/HHh8HdA4uFF5ehWWOnzzo7g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=xUi5fsoCEQTJ/4buhMuiCvL7AYp+xCiY2gg1C3BthWuCvUCC4+0fHIpsGqgl+xPO1Q
         N22Kl6DWjV+xgq9qwEpKBg8OIJouxTJDTeytpZKCriyRAuyBAdHyj6iFpO0lPGDweQw8
         z/Yl02f5omNbmMdK22CiLEvAFcKhKSKtnB8+M=
Received: by 10.142.152.14 with SMTP id z14mr220471wfd.252.1265489279067; Sat, 
	06 Feb 2010 12:47:59 -0800 (PST)
In-Reply-To: <bc341e101002061229t7a1525c2w2d5a8e221124b3c2@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139191>

Heya,

On Sat, Feb 6, 2010 at 21:29, Aaron Crane <git@aaroncrane.co.uk> wrote:
> Can anyone think of anything I might have done wrong here? =A0If not,
> I'm inclined to suggest dropping all of that advice. =A0That's not
> ideal, because it leaves Gmail users with no obvious way to submit
> well-formatted patches to the list; but it's better than suggesting
> something which apparently doesn't work.

I'm using git send-email with this configuration:
[sendemail]
  smtencryption =3D tls
  smtpserver =3D smtp.gmai.com
  smtpuser =3D srabbelier@gmail.com
  smptserverport =3D 587

It'll ask you for your password when you're sending the emails. Like so=
:

$ git format-patch --no-color -C -M origin/master..topic-branch -o outg=
oing/
$ git send-email --compose outgoing/00*

Of course you should substitute specific things as appropriate, I
doubt you'll want to be sending your patches pretending to be me :P.

--=20
Cheers,

Sverre Rabbelier
