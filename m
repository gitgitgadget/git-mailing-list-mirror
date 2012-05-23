From: Alexey Pelykh <alexey.pelykh@gmail.com>
Subject: Re: Question about submodules and absolute paths
Date: Wed, 23 May 2012 10:32:38 +0300
Message-ID: <CAOmKuSqUm+WoTA5U5ZSgqFS6Oc7q+y8wSR0sMxHW_EPKoz6fwQ@mail.gmail.com>
References: <CAOmKuSoYP9fYORDy5twLpFh7SQ7rc6x2A=F8XjfKMqo-ErCauQ@mail.gmail.com>
	<CAOmKuSpqFrC7G4DbZu=uYDwvU6QqrJUi2aNBnSjy7_PXMMJpjQ@mail.gmail.com>
	<7vk4043wc5.fsf@alter.siamese.dyndns.org>
	<CAOmKuSrmxnHKaip2X87Y0Cp=XtLAtpAwUp71QhZ5od3gbDF2sg@mail.gmail.com>
	<70952A932255A2489522275A628B97C31348C70D@xmb-sjc-233.amer.cisco.com>
	<CAOmKuSqRHMS+hvCXL4Ok6ReTPW-3xT9SunGeibjCCCgVk9SU6Q@mail.gmail.com>
	<70952A932255A2489522275A628B97C31348C71F@xmb-sjc-233.amer.cisco.com>
	<CAOmKuSoxf_mRJRyjXj99NQLoa+fD-HU_oUYPrJYPNTPmvhs46g@mail.gmail.com>
	<7vpq9w2ae2.fsf@alter.siamese.dyndns.org>
	<4FBC90C2.6050203@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	"Matt Seitz (matseitz)" <matseitz@cisco.com>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed May 23 09:32:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SX63o-000792-Hd
	for gcvg-git-2@plane.gmane.org; Wed, 23 May 2012 09:32:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755537Ab2EWHck convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 May 2012 03:32:40 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:62100 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753723Ab2EWHcj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 May 2012 03:32:39 -0400
Received: by obbtb18 with SMTP id tb18so10715853obb.19
        for <git@vger.kernel.org>; Wed, 23 May 2012 00:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=WFoB7+NdGT5wOa1XnsV2wHjKcEzhg2RZ2hDTdwkxSwI=;
        b=JneeN2uMyKOCOtKsGPgx0iRpLTkB5hX/v2vsei4WXeOdaAaF7/AkSu5Yn8Cy/VCLvx
         kSUX25gr4zUp7I9xVjVupcBZ52yvxIJ+4ZU16kPuJiD6Ff2Lax/3ch5gnfmSaxt5pII/
         Ldr4FTbRh/UW8AzDm60LOm5i0LLEY2hBSRwzc7iHOFStIcvnTBouQf7DD4VkhBstSJP4
         9cAc8u+66OvvcmMoRtY99dwFaxPUvrtDoKO4N9X516ChYvWp+qRuBVSsTP11YXWCVPjS
         pjyW0nd3dKmSuZpa951UvNTaMQOxvVz31LnrANE1HcGlM+4mzSrpwECut8jXHAdkXHHt
         64Qw==
Received: by 10.182.51.9 with SMTP id g9mr25262334obo.56.1337758358954; Wed,
 23 May 2012 00:32:38 -0700 (PDT)
Received: by 10.182.72.65 with HTTP; Wed, 23 May 2012 00:32:38 -0700 (PDT)
In-Reply-To: <4FBC90C2.6050203@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198275>

Great! I'll try git from sources then

On Wed, May 23, 2012 at 10:24 AM, Jens Lehmann <Jens.Lehmann@web.de> wr=
ote:
>
> Am 22.05.2012 23:06, schrieb Junio C Hamano:
> > Didn't the submodule folks worked on the related area recently, and
> > doesn't the result of their work already in v1.7.10?
> >
> > I am thinking specifically about the series around d75219b (submodu=
les:
> > always use a relative path from gitdir to work tree, 2012-03-04). =A0=
Jens?
>
> Yes, these changes should fix the problem described by Alexey.
