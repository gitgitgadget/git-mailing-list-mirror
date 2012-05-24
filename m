From: Alexey Pelykh <alexey.pelykh@gmail.com>
Subject: Re: Question about submodules and absolute paths
Date: Thu, 24 May 2012 08:08:16 +0300
Message-ID: <CAOmKuSoM=qP-Mpysfwpx7QDFx-hSwcBaRULfiS3b+VEhnXvVxw@mail.gmail.com>
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
	<CAOmKuSqUm+WoTA5U5ZSgqFS6Oc7q+y8wSR0sMxHW_EPKoz6fwQ@mail.gmail.com>
	<4FBD4BB7.9070704@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	"Matt Seitz (matseitz)" <matseitz@cisco.com>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu May 24 07:08:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXQHf-0001lG-3O
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 07:08:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293Ab2EXFIS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 May 2012 01:08:18 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:53248 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751285Ab2EXFIR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 May 2012 01:08:17 -0400
Received: by obbtb18 with SMTP id tb18so12035391obb.19
        for <git@vger.kernel.org>; Wed, 23 May 2012 22:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=b2ipgQLJLfIAeeOJYIesRKv+8WwN6k37G0JM2nDC6lQ=;
        b=z+67B0JVChr4MmPkGsEj7p2Rcwl+vl0cmBz1PX3GwFlAkT6iPf3sIg76SxNkdm5m+T
         zO9Cpzd2o2M3tP2zxLTh0fMJ2CdzeNzkR9HJWX9zogCkC66YMGdVmnr3JmAPbLQl7VHv
         768GU/xgG5biB9rKtRALtbif38jBNFVWWL1E3pNxy+X/Gi95Sn3TpegcMqVHO2CHyYeQ
         wAg9SbXyOavbe6dXPvSeMg7//9T/o+HIIcmZUHGbebRl9NJNoefLxb5iEFO4t3hFBzKf
         RRkwvfuUTA4qtAKG2a6/7NZfKTF/s5jJp1fX/wnSPNpJuea6oWYP+jejwqN7I0XKog9l
         yLgQ==
Received: by 10.182.141.9 with SMTP id rk9mr28996201obb.50.1337836096820; Wed,
 23 May 2012 22:08:16 -0700 (PDT)
Received: by 10.182.72.65 with HTTP; Wed, 23 May 2012 22:08:16 -0700 (PDT)
In-Reply-To: <4FBD4BB7.9070704@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198351>

Thanks for pointing that out

On Wed, May 23, 2012 at 11:42 PM, Jens Lehmann <Jens.Lehmann@web.de> wr=
ote:
> [please do not top-post]
>
> Am 23.05.2012 09:32, schrieb Alexey Pelykh:
>> On Wed, May 23, 2012 at 10:24 AM, Jens Lehmann <Jens.Lehmann@web.de>
>> wrote:
>>>
>>> Am 22.05.2012 23:06, schrieb Junio C Hamano:
>>>> Didn't the submodule folks worked on the related area recently, an=
d
>>>> doesn't the result of their work already in v1.7.10?
>>>>
>>>> I am thinking specifically about the series around d75219b (submod=
ules:
>>>> always use a relative path from gitdir to work tree, 2012-03-04).
>>>> =A0Jens?
>>>
>>> Yes, these changes should fix the problem described by Alexey.
>>
>> Great! I'll try git from sources then
>
> But don't forget to re-clone the submodules, the paths won't be updat=
ed
> for existing submodules.
