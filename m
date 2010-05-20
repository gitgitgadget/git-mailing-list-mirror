From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Git, Mac OS X and German special characters
Date: Thu, 20 May 2010 16:29:24 +0200
Message-ID: <4BF54744.60602@drmicha.warpmail.net>
References: <4BF4E40B.30205@math.tu-dortmund.de> <AANLkTimYgkv6q6fTXqNOCq1ZbodxgCZ18Fum_NryyiO8@mail.gmail.com> <4BF4F7D7.60002@drmicha.warpmail.net> <4BF4FA89.2040904@gmail.com> <4BF4FDB4.2010409@drmicha.warpmail.net> <4BF5294E.7060206@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu May 20 16:29:41 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OF6km-0000f0-JG
	for gcvg-git-2@lo.gmane.org; Thu, 20 May 2010 16:29:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752751Ab0ETO3f convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 May 2010 10:29:35 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:41972 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751961Ab0ETO3e (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 May 2010 10:29:34 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 115C7F5A11;
	Thu, 20 May 2010 10:29:34 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Thu, 20 May 2010 10:29:34 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=R+PC0Q6rum7dnZPIQdybj5ISqR8=; b=j38JvM54MBd1DS749RZifOb6fyIgbTNNxukwWh619ZagxroUgQEQC7JQAwm5l89II8m4uQ0IYOHbKxIgSJCHJKgI/OY+dEWKMO06RpnmG+J2OL2KzEYT6GVJCMxHg6Ekd3xb+6UYEyo9kLY4lYvTXAx68aD1abka9cvBslBeJLA=
X-Sasl-enc: 81Y3PAo+GvCfxud/67YDBUovYfcrUylON7Kp/GG7ZaB/ 1274365773
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 40E284E0213;
	Thu, 20 May 2010 10:29:32 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100519 Lightning/1.0b2pre Lanikai/3.1pre
In-Reply-To: <4BF5294E.7060206@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147390>

Torsten B=C3=B6gershausen venit, vidit, dixit 20.05.2010 14:21:
> Hej Michael,
> Thanks for the reply.
>=20
>> You signed off, but is Markus Kuhn's code from UCS GPL2-licensed?
> Oh, I haven't added any code from Markus here.
> But if my sign off is a problem, we can remove it ;-)
> or move the code to another place. (And utf.c will still have code fr=
om UCS)

Your sign-off is fine if you can place the code under the terms of the
project.

In your patch there is a line

/* This code is originally from http://www.cl.cam.ac.uk/~mgk25/ucs/ */

but I missed the missing '+' in front - that comment was there before
your patch! Sorry for the confusion.

>=20
>> Also, a few tests would be nice.
> Yes, fully agreed.
> My feeling is, that at least
> "git add", "git mv", "git rm" should be tested.
> I will fix that.
> But as I become more familiar with the git testsuite,
> it becomes more and more clear, that testing the new feature will
> do the same tests as already existing tests.
>  From that point of view, it seems easier to re-use the existing test
> cases and run them twice, once with clean ascii, and second time with
> an internationalized form.
> As not all platforms support utf-8, the internationalized tests may b=
e
> either utf-8, 8859-1, or nothing at all.
>  =20
> I feel that at least 50% of the test cases should be "internationaliz=
ed",
> like "git merge", "git pull" etc.
> (And re-writing the tests is a big issue, at least for me as a beginn=
er)
> Anyway, I will make simple tests.

Simple tests are a good start. More importantly (compared to full
internationalisation), we need someone running them on Mac OS ;)

Michael
