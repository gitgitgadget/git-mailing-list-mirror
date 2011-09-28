From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: =?UTF-8?Q?Re=3A_Annotated_branch_=E2=89=88_annotated_tag=3F?=
Date: Wed, 28 Sep 2011 17:12:13 +1000
Message-ID: <CAH5451nT2Z6mBPkK4B2EgJAoMpf32bcc=7UqhTDnsw4-_hJwJw@mail.gmail.com>
References: <7vy5xi4y3m.fsf@alter.siamese.dyndns.org> <1316729362-7714-1-git-send-email-gitster@pobox.com>
 <4E7C49CF.60508@drmicha.warpmail.net> <20110923201824.GA27999@sigill.intra.peff.net>
 <4E7DEC4A.3050900@drmicha.warpmail.net> <20110927215843.GE5176@sigill.intra.peff.net>
 <4E82A13B.2080509@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Sep 28 09:12:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8oJs-0004yT-2H
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 09:12:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753192Ab1I1HMf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Sep 2011 03:12:35 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:61608 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751546Ab1I1HMe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Sep 2011 03:12:34 -0400
Received: by fxe4 with SMTP id 4so275421fxe.19
        for <git@vger.kernel.org>; Wed, 28 Sep 2011 00:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=0cko/dnOKeXPBdPxw9RJvAqvoIKFRgwTnX/Iqso/mfA=;
        b=I/nuLsW3dFuVPiSKR9zHRIjJX6av2I0jJ7KcXbPYmxlMGJ6QIKXerPI8PLikz6i36j
         BP9mSRkOLUQwrko0RUp4ayzynp86qTcn8H/joiy4ALh9qou29ZXpLAw2brbQxHofo/Dd
         hGFKYGP60dZge+io2STXv3xH3PaxRwJGKr5rM=
Received: by 10.223.6.77 with SMTP id 13mr13837400fay.135.1317193953348; Wed,
 28 Sep 2011 00:12:33 -0700 (PDT)
Received: by 10.152.37.66 with HTTP; Wed, 28 Sep 2011 00:12:13 -0700 (PDT)
In-Reply-To: <4E82A13B.2080509@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182295>

On 28 September 2011 14:23, Michael Haggerty <mhagger@alum.mit.edu> wro=
te:
[snip]
>
> [1] If the retention of annotation history were considered a
> requirement, the annotation object could record as a "parent" the obj=
ect
> name of the annotation object that it is succeeding. =C2=A0But I don'=
t think
> that this is a good idea; it would make branches too heavyweight and
> every branch update would be recorded permanently, both of which are
> contrary to the git philosophy.

If this was required, a better way would be to update the parent object=
 only
if the description changed. You would then have a nice little DAG that
records changes to the description and could be used in 3-way merges et=
c.
You would of course get lots of 'dead' annotation objects pointing to t=
he
previous change, however that shouldn't be too much of an issue.

At this point, however, I ask how is an annotation object any different=
 to
placing an annotation file in our repository. Perhaps there is no diffe=
rence,
except that one is a convention and the other is provided.

Regards,
Andrew
