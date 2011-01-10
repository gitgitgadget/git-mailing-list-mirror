From: Martin Langhoff <martin@laptop.org>
Subject: Re: cvsimport still not working with cvsnt
Date: Mon, 10 Jan 2011 10:38:38 -0500
Message-ID: <AANLkTikreDJmUPfwNJ2ABivrafjvQNN6WrytNMAcse4A@mail.gmail.com>
References: <4D0ED5EC.9020402@burntmail.com>
	<20101220213654.GA24628@burratino>
	<4D112586.2060904@Freescale.com>
	<4D119015.6020207@burntmail.com>
	<4D2AB63D.7040803@burntmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Emil Medve <Emilian.Medve@freescale.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	git <git@vger.kernel.org>, Pascal Obry <pascal@obry.net>,
	Clemens Buchacher <drizzd@aon.at>
To: Guy Rouillier <guyr@burntmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 10 16:38:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PcJpY-0003Ey-Ak
	for gcvg-git-2@lo.gmane.org; Mon, 10 Jan 2011 16:38:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268Ab1AJPim convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Jan 2011 10:38:42 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:64156 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750982Ab1AJPil convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Jan 2011 10:38:41 -0500
Received: by ywl5 with SMTP id 5so7552246ywl.19
        for <git@vger.kernel.org>; Mon, 10 Jan 2011 07:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=JgzH7wj4bWsLKhFgEFBhp8PkOz7fFolRdpgmEcm+hsg=;
        b=gL8AUnnrcuulZ9jyXSo78cKBwPiZeE1NiVuFfXrcxB8/7IbJVnFQm1lJBHncmGQpDx
         hKP9YW8MOuvqA7oTYb6XjrAK0MnfNGQGC9A7/fUezcrlKBfOo39wfIyk1+Au9Z5IKzyD
         QWj5udcAbKH1cEN440LFNy/3THl72CjX0Xz4M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=Dw3ByeFZLy1bm+CJxFl07+KpDwFBFZNNyds9ry8RZwg5qw2F3Ce6ms0PyrF6PVHHDp
         DakLvqLixMPBsrO5LOi2Ossn0XIdZGvFOHs4bEAQh7E9jj+3bh0HZRog2Z7a1nAwOEjB
         e5sJsy6J7d9IRA+aLp/HKGrPCj7f3/55Age/w=
Received: by 10.90.73.5 with SMTP id v5mr6269837aga.0.1294673919549; Mon, 10
 Jan 2011 07:38:39 -0800 (PST)
Received: by 10.90.115.11 with HTTP; Mon, 10 Jan 2011 07:38:38 -0800 (PST)
In-Reply-To: <4D2AB63D.7040803@burntmail.com>
X-Google-Sender-Auth: qk_F-Ew3VStmQlEoch45TjNnPFg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164877>

On Mon, Jan 10, 2011 at 2:33 AM, Guy Rouillier <guyr@burntmail.com> wro=
te:
> Here is my patch for accomplishing the above. =A0As this is my first =
time
> submitting a patch, please let me know the correct procedure if
> submitting a diff here is not appropriate. =A0Thanks.

The concept of what the patch is doing is good, but I'd recommend

@cvspasslocations =3D ($ENV{'HOME'}."/cvspass", $ENV{'HOME'}."/.cvs/cvs=
pass")

foreach $cvspass (@cvspasslocations) {
   open(...

and forgo the "matching" test.

cheers,


m
--=20
=A0martin@laptop.org -- School Server Architect
=A0- ask interesting questions
=A0- don't get distracted with shiny stuff=A0 - working code first
=A0- http://wiki.laptop.org/go/User:Martinlanghoff
