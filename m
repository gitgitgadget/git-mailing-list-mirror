From: Drew Northup <n1xim.email@gmail.com>
Subject: Re: Gitweb characters not encoded/decoded properly
Date: Tue, 18 Sep 2012 16:36:19 -0400
Message-ID: <CAM9Z-n=KpD2nPNN4wC1Mj4Jjx1S+yxC9piYaj_JxN4s4e8er9A@mail.gmail.com>
References: <CAMOg_eWBvkLFa7AB+cW-qTq8Z7_XmOsFWeB5KkwZHbF4d53ihg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Joseph Leong <josephcleong@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 18 22:36:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TE4X0-0001CK-94
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 22:36:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755107Ab2IRUgW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Sep 2012 16:36:22 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:35978 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755043Ab2IRUgU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Sep 2012 16:36:20 -0400
Received: by bkwj10 with SMTP id j10so151144bkw.19
        for <git@vger.kernel.org>; Tue, 18 Sep 2012 13:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=XuqfkO4TuDiGA4052FUw4/LppKMGwnl4a5F+58I3jnQ=;
        b=DiIYFiJTn7cuKE56od5rM5DyJozKKDIWQXBuo6Nu4iEKMRinXd4Y4Q50b8bb9Q8r+H
         40QFOcKk8u6IGKo8llZYy4wfv58km+9oHZjX0qePWCD2sLDMOuTgrI6VpDjrrR6S38Bo
         kDXtc69iFXZ2PuxCvkIP05hlLHetf11icvO8KeMEO85V2DXRr3xzxGfiVJZ4J6/IOpcL
         Bzr+jwN2sYjsC4y68HYYjQoD/CcbuNf91oP/HEtNaNNbdXqebYKdZF7gGeRrttewX7A9
         Rm07exZG/1nuOlwjeZoSEJMi/3axRmwG0y/lAhnYLF/TeJ/0dXhIw1Las+cXdhORsIZv
         M0+Q==
Received: by 10.204.154.74 with SMTP id n10mr582457bkw.60.1348000579442; Tue,
 18 Sep 2012 13:36:19 -0700 (PDT)
Received: by 10.204.10.87 with HTTP; Tue, 18 Sep 2012 13:36:19 -0700 (PDT)
In-Reply-To: <CAMOg_eWBvkLFa7AB+cW-qTq8Z7_XmOsFWeB5KkwZHbF4d53ihg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205868>

On Mon, Sep 10, 2012 at 1:57 PM, Joseph Leong <josephcleong@gmail.com> =
wrote:
> Hi Everyone,
>
> I've noticed an issue in gitweb where git projects are created with
> characters such as:
> =E2=82=AC=E9=85=AE=D8=AE=D8=AF=E3=90=81=E1=A0=A1=EA=80=88=E0=BC=91=E3=
=98=9A.git
>
> But in the gitweb page content, URL section,  a git project is
> rendered incorrectly?

> Example screenshot:
> http://i.imgur.com/06skV.png

Joseph,
What character set is that supposed to be in? In addition, if it is
UTF-(something), what code segment are you using?

--=20
-Drew Northup
--------------------------------------------------------------
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
