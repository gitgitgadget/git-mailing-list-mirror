From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Officially start moving to the term 'staging area'
Date: Thu, 29 Aug 2013 15:36:48 -0500
Message-ID: <CAMP44s3m_7UffHfie8=_izPt5tCw+9SXPa4sqoHuphuVyTHqcw@mail.gmail.com>
References: <20130829180129.GA4880@nysa>
	<vpqli3kqqkp.fsf@anie.imag.fr>
	<521f998d25eb4_174378fe7481879@nysa.mail>
	<521FA90A.9040903@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Miles Bader <miles@gnu.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Scott Chacon <schacon@gmail.com>
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Thu Aug 29 22:36:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF8xa-00076B-UA
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 22:36:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756080Ab3H2Ugu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Aug 2013 16:36:50 -0400
Received: from mail-lb0-f176.google.com ([209.85.217.176]:48817 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752731Ab3H2Ugt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Aug 2013 16:36:49 -0400
Received: by mail-lb0-f176.google.com with SMTP id y6so1166014lbh.35
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 13:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=r+DR1sXvcwdykwFvM9m9Tv6tbvb24ONRF6ZY4DzT0Y0=;
        b=KRKAGSvPV4FC1Wo7JG9Ab1ECC/R9dmIN0GHaVm1tgEQ9q50XoQVOHmd7FciVnmubcx
         VRXJaBu5pCq6SOqJoPvFbeTevClVkvxg23WOtIPXEcAPudchliglWvv07PoD6XdxGIuU
         hasaPSmwSyQRNROlBGn4lZg5bUq73BfgtVpOWNmENPuEGTxwU6E+Qozy/aAhO3KyoV2p
         r6fHCZjgUDc+WUEuXzLXrfUEBRnFI0TOO4bBUY5Q0lQtgWqjb0vgnpSbnYMO22MNwl6r
         MJ2HsGlS/++8nKDwFZtHVgm3sXJUXky5GmGahejIJosB69I+FWU0D0BBCljf2y5c+v1x
         Ggig==
X-Received: by 10.112.0.173 with SMTP id 13mr4669182lbf.8.1377808608352; Thu,
 29 Aug 2013 13:36:48 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Thu, 29 Aug 2013 13:36:48 -0700 (PDT)
In-Reply-To: <521FA90A.9040903@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233355>

On Thu, Aug 29, 2013 at 3:03 PM, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote=
:
> Am 29.08.2013 20:57, schrieb Felipe Contreras:
>>
>> Matthieu Moy wrote:
>>
>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>>
>>>> Moreover, the --stage and --work
>>>
>>>
>>> --work alone sounds weird. At least to me, it does not immediately =
imply
>>> "working tree". It is tempting to call the option --work-tree, but =
git
>>> already has a global option with that name (git --work-tree=3Dfoo b=
ar).
>>
>>
>> Yes, --work sounds weird, but so does --cherry. I thought about --wt=
, but
>> I
>> felt --work was more understandable, and --work-tree doesn't really =
give
>> much
>> more value, except more characters to type =3D/
>
>
> If you have a --work-tree option then parseopt accepts --work as well=
,
> unless it's ambiguous, i.e. another option starts with --work, too.  =
So you
> can have a descriptive, extra-long option and type just a few charact=
ers at
> the same time.

Right, but what do we use in the documentation? Writing --work-tree in
the 'git reset' table for example would be rather ugly. I'm fine with
--work-tree, but I think it would be weird to have short-hands in the
documentation, although not entirely bad.

--=20
=46elipe Contreras
