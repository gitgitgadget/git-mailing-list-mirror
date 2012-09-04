From: Nazri Ramliy <ayiehere@gmail.com>
Subject: Re: Feature request: short cuts for git add /diff etc
Date: Tue, 4 Sep 2012 19:51:11 +0800
Message-ID: <CAEY4ZpOw2HUCf6QxUaAQTjCCVxi_TvttW1DFOgrsgbo6PQtfZw@mail.gmail.com>
References: <6110218480.20120904152542@reg.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?KOI8-R?B?68/O2MvP1yDl18fFzsnK?= <kes@reg.ru>
X-From: git-owner@vger.kernel.org Tue Sep 04 13:51:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8rf5-0005r1-Mf
	for gcvg-git-2@plane.gmane.org; Tue, 04 Sep 2012 13:51:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095Ab2IDLvN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Sep 2012 07:51:13 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:42001 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756773Ab2IDLvM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Sep 2012 07:51:12 -0400
Received: by vbbff1 with SMTP id ff1so6444728vbb.19
        for <git@vger.kernel.org>; Tue, 04 Sep 2012 04:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=eMzmgrQw0RGegGjPr2vCeA7IYVuZLkWXyQqxilqpJ7I=;
        b=p3gmVkKN13OUfC4KEg6DkEojR7PRqYeASsX1odDkC3mPr6xjz1VYgSXirvd8OUIRnZ
         BfQtx+YEu7WiFvKQCp/i+KomBDP+TiI8BY/6YrMn2K1wx2+mqAVaYSd6mp95XOgy49ch
         2kuSzllxHFaA7Z+xdGrrMLM5beCiameN1Q56XtHbx1F8xJTFcbWOV04RAQ39cRqS2RBc
         eIPQEd0arZrhGSedocoCiySoiIz/0vWNrYtA0480OGqbCzjfFCmlRwNVZIvG7EkSlqTz
         /gfq5QjmRGc4CyzAWpAchByC+/OhV53qQVSPo+H6x1BKGYIqqIouBX/Xv9Dk00k2RP1B
         lKew==
Received: by 10.52.99.2 with SMTP id em2mr4766975vdb.117.1346759471354; Tue,
 04 Sep 2012 04:51:11 -0700 (PDT)
Received: by 10.58.252.104 with HTTP; Tue, 4 Sep 2012 04:51:11 -0700 (PDT)
In-Reply-To: <6110218480.20120904152542@reg.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204739>

On Tue, Sep 4, 2012 at 7:25 PM, =EB=CF=CE=D8=CB=CF=D7 =E5=D7=C7=C5=CE=C9=
=CA <kes@reg.ru> wrote:
> sot this allow:
> git diff 1       same as        git diff a1.txt
> git diff 2       same as        git diff a2.txt
>
> git add 1        same as        git add a1.txt
> in case there are may be files with such names I may appply option -s=
,for example
> git add [ -s | --stage ] 1 . This will force to add file from list of
> 'git status' and do not use '1' as file name.
>
> git add 3        same as         git add new.txt
>
>
> This very handy and will keep developer from useless typing =3D)

Check out git-number[1] and scm_breeze[2]. Both provides similar
functionality to the above.

nazri
shameless disclaimer: I wrote git-number.

[1] https://github.com/holygeek/git-number
[2] https://github.com/ndbroadbent/scm_breeze
