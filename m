From: Scott Chacon <schacon@gmail.com>
Subject: Re: Best newbie / advanced / expert reference texts for Git?
Date: Fri, 19 Nov 2010 17:20:34 +0000
Message-ID: <AANLkTins84umA=o=HLCtrFS=om-c_7yEGQzcxDvYv7-D@mail.gmail.com>
References: <AANLkTikctrASqX0FLCOapyJCt1VqG6_cxs_oXJ6fExZC@mail.gmail.com>
	<AANLkTik5ZYC66NicUvbDxJMiR_0iK3vPRAf9dGAQu+qW@mail.gmail.com>
	<AANLkTin_kS_2d=ajuGo-V_OWsF91xSb=SeKmrX9Aghe8@mail.gmail.com>
	<AANLkTimckSDtkfoVqvEACNUhMHAKVvTKcCCmm=VdavJL@mail.gmail.com>
	<AANLkTinuuU+PqYQs=4XywUsrSyd3evFbRK+2_WxEAoZo@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Patrick Doyle <wpdster@gmail.com>, Git ML <git@vger.kernel.org>
To: Dun Peal <dunpealer@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 19 18:20:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJUdd-0001FT-2W
	for gcvg-git-2@lo.gmane.org; Fri, 19 Nov 2010 18:20:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755309Ab0KSRUg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Nov 2010 12:20:36 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:37598 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754143Ab0KSRUg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Nov 2010 12:20:36 -0500
Received: by eye27 with SMTP id 27so2843767eye.19
        for <git@vger.kernel.org>; Fri, 19 Nov 2010 09:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=p3WVPxQId3woUK211E3oooLVino2tYhTLfHqAqtUHKQ=;
        b=rnRa9R8VCdDJPUgueF3utkRYzJmFLeySNsobwla9kr/sA4s78Qm3gLxziUMfj9Bddq
         vdEwAKIG06nX7+c8OS5EyEafQRKfI9YDifT5w+KDzDT/WzqEIVRrHk5+gf/MiYbpib10
         Wh+4th+CQWpRsPss38lj5HP6cmPhByXEfGyn0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Ctxnbzq6TIFyXTirDC588nfnIssfSVHpbh/t44ANE+q+y2iEZaDfX0ktBDEUPWZg53
         HFerQT59cvLhFbZDeuZCVOy8rUf2R+mIC1U/O6DeftivtVHcCRLMCKgVkgputLXzGqAJ
         IQQyd28xmXGrikr4YZlnbv1uCnbkwiX70HCDI=
Received: by 10.14.37.7 with SMTP id x7mr1507862eea.48.1290187234732; Fri, 19
 Nov 2010 09:20:34 -0800 (PST)
Received: by 10.14.119.197 with HTTP; Fri, 19 Nov 2010 09:20:34 -0800 (PST)
In-Reply-To: <AANLkTinuuU+PqYQs=4XywUsrSyd3evFbRK+2_WxEAoZo@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161770>

Hey,

On Fri, Nov 19, 2010 at 5:08 PM, Dun Peal <dunpealer@gmail.com> wrote:
> Yeah there are definitely a lot of resources listed there; so many,
> that one can't readily decide which to use and for what purpose ;-)

Hm, perhaps I should simplify the page a bit then.

>>> P.S. I glanced at it briefly and it seemed a bit out of date, but
>>> perhaps my inspection was too cursory.
>>
>> Do you have any examples?
>
> I just glanced through a description of checking out branches and
> didn't see the feature that creates a remote-tracking branch foo when
> you `git checkout foo`, and foo isn't a local branch but does exist on
> the remote.

Well, that will never be included - I find it really confusing and try
to discourage people from using it in favor of 'git checkout -b foo
origin/foo' because i feel it's much more consistent.   I would like
to make the tracking branch section a bit better, but that's not
really an 'out of date' thing.

Thanks again,
Scott
