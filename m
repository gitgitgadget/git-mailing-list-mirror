From: Lars Vogel <lars.vogel@vogella.com>
Subject: Usage of staging area instead of index still the way to go?
Date: Tue, 2 Feb 2016 11:30:12 +0100
Message-ID: <CACA4a_Hmp-o2dDYRKd1tO0-nR5AebWOpgf5+VQ6vWV2Wcdd-NA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 02 11:31:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQYEt-0005QM-0e
	for gcvg-git-2@plane.gmane.org; Tue, 02 Feb 2016 11:31:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754317AbcBBKbJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Feb 2016 05:31:09 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:36768 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754604AbcBBKaO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Feb 2016 05:30:14 -0500
Received: by mail-wm0-f44.google.com with SMTP id p63so110713730wmp.1
        for <git@vger.kernel.org>; Tue, 02 Feb 2016 02:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vogella-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=0T0BaihDtsCM73deWGl7z+bYtQuwW3BhGFhDFgm6uog=;
        b=sSPtnDXPe+7NHeg0eIs2t3shniLXYzBx1CvINoC3o1K5S7VMhYsEYEFr8OOQ328pV7
         PRATusqUxzJBTuMNdo9nW9E4sXvQYDDL09LUdJIawzZpcHRmAHRImfMSReSEfF4SDGJp
         9vQgGE8xnA7CBAXc6m93/dKQslww6JLwWwd7oUHb5ohwxjr9OoH82jTNRJ8Nx+86mmrp
         rPCLpi6ZlEnZ3IWSxy1qsEZWgufeZbXQvVqTktoLRviBuAhNP1gzgnmoM03vg3h3ufpe
         wb+k4zU7G58WhtrttxTVZvKyXd7hvvJWegFlK5fRXa5c/LMBSEGphodY1WghnoKhfNno
         lG+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=0T0BaihDtsCM73deWGl7z+bYtQuwW3BhGFhDFgm6uog=;
        b=CNzZGm9FW93OsRQ9OaUvFpZ3h6+8Rk1HpRea58MgPCQ8wpflf8Iowj7tSLMwebk1bp
         AZlWX6LZ91cnfSVCC3th2CAr1Uod21wIdpNhWMFKDhKGVy33vPW5BK7yJjtbhMKuuZ0i
         em+pBjx+2aEr/4AyqbGzKY54u1cO0v9jtJ6qkofPe+JeQPOOKw1c63/FCfb1HQu+uAK2
         7nbh4AkBEdys8daqlTiwJjStSwC3Dr91zWku0Xcd8xE3+HcbTOrwq3fRYSVSZUgAuYjb
         nr0FrQM5TJXzSKG7vpeo17hcdu6xFHI70jVIcmd6+Tr5T9oS6Bd9mNlXLAsuhWQOsT5n
         hpNw==
X-Gm-Message-State: AG10YORxtgby0LKu3xHOy3/spdJd53p7eNbjDakp67F79fzhbBRHsMlFoDTiq2pLmrmN3R5DpiNJweRIkfV7SQ==
X-Received: by 10.194.242.67 with SMTP id wo3mr26894811wjc.180.1454409013025;
 Tue, 02 Feb 2016 02:30:13 -0800 (PST)
Received: by 10.28.216.73 with HTTP; Tue, 2 Feb 2016 02:30:12 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285248>

Hi,

I was about to send patches to the Eclipse Git project to replace the
usage of "Index" with "Staging area" based on this thread:
http://article.gmane.org/gmane.comp.version-control.git/233469/ which
Matthias Sohn (Project lead of EGit) send me a while ago.

But the Git help seem to use still heavily "index" instead of "staging
area". Is "staging area" still considered as the correct term or has
time proven that index is better?

Best regards,Lars

--=20
Eclipse Platform UI and e4 project co-lead
CEO vogella GmbH

Haindaalwisch 17a, 22395 Hamburg
Amtsgericht Hamburg: HRB 127058
Gesch=C3=A4ftsf=C3=BChrer: Lars Vogel, Jennifer Nerlich de Vogel
USt-IdNr.: DE284122352
=46ax (040) 5247 6322, Email: lars.vogel@vogella.com, Web: http://www.v=
ogella.com
