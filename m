From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Challenge with Git-Bash
Date: Sat, 17 Jul 2010 12:13:03 -0500
Message-ID: <20100717171303.GB10730@burratino>
References: <001d01cb25cb$eb176980$c1463c80$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Rainer Lauer <lauerr@gmx.net>
X-From: git-owner@vger.kernel.org Sat Jul 17 19:14:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OaAxw-0004Kw-8l
	for gcvg-git-2@lo.gmane.org; Sat, 17 Jul 2010 19:14:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760066Ab0GQROD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Jul 2010 13:14:03 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:37792 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756171Ab0GQROC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jul 2010 13:14:02 -0400
Received: by iwn7 with SMTP id 7so3180390iwn.19
        for <git@vger.kernel.org>; Sat, 17 Jul 2010 10:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=WsAmw5ubgeLoSBWJdDSxLejcU303c2763zS7kaVEGfc=;
        b=s9cCaz+ExRmB7+Ahs/ZdgABl/6rm7BYlnx5EFcY9a38dJYKWulIwtFtFQ13OBWa6aN
         sCExhg2945D6TpG20x9Fs0n/C/reRFVyTjirYKBWrWxRkNKh9o1eiia6k2Udahh4DwJU
         6G+HkaYk22SumOHd1jPm3BH/jdvmxWRcGNp9A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=RAhZDLaPI11PNqKZGK/vuQQ94S2X1iOYezhiz7HNHo05/z5k707Bn24XSj10U1Ebao
         G9N4HRPO73kqph/h7a3DarHmwQZBV+aym9k82vF680xz/gHYUCjTzF7zPZDyyA2ethfY
         c6x9tbWM4bD3sQQX9kj3jvMFRkZD2mbHJ3pdw=
Received: by 10.231.36.72 with SMTP id s8mr2756915ibd.49.1279386838887;
        Sat, 17 Jul 2010 10:13:58 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id h8sm15591616ibk.21.2010.07.17.10.13.57
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 17 Jul 2010 10:13:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <001d01cb25cb$eb176980$c1463c80$@net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151198>

(+cc: msysgit)

Hi Rainer,

Rainer Lauer wrote:

> with my Windows 7 Git-Installation I get following challenge:
>
> 1)	Set GIT_EDITOR to editor of your choice
>
> 2)	With Windows7 let this editor run in admin-mode
> 	Goto .exe-file -> right mouse-click -> compatibility -> run program
>	as admin (I'm running a German version maybe English names are slight=
ly
>	different)
>
> 3)	Make a git action like git add file
>	                       git commit
> 	from the git bash.
>
> 4)	Now following message appears:  sh.exe: ./"editor of your choice":
> Bad file number
>
> Everything is fine without Admin-Mode set for editor.

Apparently =E2=80=9CBad file number=E2=80=9D can mean =E2=80=9CPermissi=
on denied=E2=80=9D among other
things on Windows.  I do not have any better suggestion than to try
running git bash as administrator too, sorry.

Regards,
Jonathan
