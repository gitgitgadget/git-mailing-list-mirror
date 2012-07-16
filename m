From: Jose Nobile <jose.nobile@gmail.com>
Subject: Re: Bug Report - Binary Files as plain files, line endings conversions
Date: Sun, 15 Jul 2012 23:57:03 -0500
Message-ID: <CAJ69RUT_Lnt5qe+dVnBRAE5-5PR6w2VOLe=Vc6Pt5yv_PC=w3w@mail.gmail.com>
References: <CAJ69RUS7d75FN-TicyXY=g4HkM2AVxMx=tWjJnX1VNpQ5XDa6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 16 06:57:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SqdMu-0007Dd-Lw
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jul 2012 06:57:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750863Ab2GPE5G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Jul 2012 00:57:06 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:48707 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716Ab2GPE5E convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jul 2012 00:57:04 -0400
Received: by yhmm54 with SMTP id m54so4961712yhm.19
        for <git@vger.kernel.org>; Sun, 15 Jul 2012 21:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=R/AlOe4Ho0qoMorxX1o9WuUp58QeTF/rxuVoKArj2JQ=;
        b=SI6vYE+8HhoLwxyD9Asf/XoGu+jusxa6hT/eMtx6c0XBa59zbPCJpSsBP+uRMTW+Ny
         T+1ODQ2Lop6hHPERN3Jbyv4pnxGQv/UlzZbR/aqSMZMTKgw5Fdxc5FkF4tW+Tz2DLsPx
         Q9LsDb4yf/XlcfeAFzGFlCfxRrKhgXxWxhcKCaHv6W/m7Wq9RvtY5T68prZwPEMadqC3
         KRaCaGiG0UNnei7i16uj+FcLJjFOisyJf5N6ftkJkSYj2lnarES40JFD/MR7jNqpsS+N
         WNwdqzeAvEutKIOUUbjojQR506VBn3RoBN2/Qgt6eMUEmi2+C3zAJFi9qkXHjvHZVI/l
         o5gw==
Received: by 10.42.19.131 with SMTP id c3mr5107909icb.36.1342414623955; Sun,
 15 Jul 2012 21:57:03 -0700 (PDT)
Received: by 10.231.222.137 with HTTP; Sun, 15 Jul 2012 21:57:03 -0700 (PDT)
In-Reply-To: <CAJ69RUS7d75FN-TicyXY=g4HkM2AVxMx=tWjJnX1VNpQ5XDa6Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201493>

 Hi,

 $ git add .
 warning: LF will be replaced by CRLF in web/images/logo_twitter.png.
 The file will have its original line endings in your working directory=
=2E

 JOSE@COMPAQ /d/wamp/www/internationalstudies.co (master)
 $ git --version
 git version 1.7.11.msysgit.0

 JOSE@COMPAQ /d/wamp/www/internationalstudies.co (master)
 $ cat .gitattributes
 # Auto detect text files and perform LF normalization
 * eol=3Dcrlf

 JOSE@COMPAQ /d/wamp/www/internationalstudies.co (master)


 Binary files as an image not may perform any line ending operations,
many binary files will be corrupt when are restoring from repository,

 Saludos,
 Jos=C3=A9 Nobile
