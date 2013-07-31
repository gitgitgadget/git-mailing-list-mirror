From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH 2/2] Don't close pack fd when free'ing pack windows
Date: Wed, 31 Jul 2013 14:23:43 -0700
Message-ID: <CA+sFfMe935imbvt=XvaU2jZhf=KSf0xZdnrBDgYfUop0CtyWrA@mail.gmail.com>
References: <CA+sFfMe1GTDqtgGs3NXoB0OBYTtyHxLDYgy0TmOe+3r=tMXS0A@mail.gmail.com>
	<1375300297-6744-1-git-send-email-bcasey@nvidia.com>
	<1375300297-6744-2-git-send-email-bcasey@nvidia.com>
	<CALWbr2wR2cN8dcOtW2bV3p7FC3ymdXgfp61A4pNKvOWhP6WU_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Brandon Casey <bcasey@nvidia.com>, git <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 31 23:23:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4ds6-0003yL-7v
	for gcvg-git-2@plane.gmane.org; Wed, 31 Jul 2013 23:23:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753126Ab3GaVXq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Jul 2013 17:23:46 -0400
Received: from mail-we0-f173.google.com ([74.125.82.173]:39384 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751418Ab3GaVXp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jul 2013 17:23:45 -0400
Received: by mail-we0-f173.google.com with SMTP id x55so1063817wes.4
        for <git@vger.kernel.org>; Wed, 31 Jul 2013 14:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Nm9CTtxCnODRmplQKqPrtM9CzUi9ocvT0Hq8EJRF+14=;
        b=xg+fMQDJ/+Kyf5c1mh2HXBLBX0X7+tsTNzkzAU5RlU4vFQmMKpdRFjRIeH3hz1OaLk
         +mtbAE7arHQbZ6OW9g26Izsrrc/yy4YRngnMJCJEzDjMLl2IwoOIvs0I6vktphX/PaJa
         dgxbSuQHxVwZenzvZ/JR9Ft9orXqX4K+1+0QfrVzLdA/SlbX8L1c56mjegpFKeHBm8ut
         kjJyXoDUxQif2vjrorGt4q23Muz4AxUjDGP0JRSU+sB7PIykkbz/5waTR/5yxGRtct1D
         KL00TrkJji/WprfMmyLl2XQVmglL2g9mbJrHxcwfTIYCiIdyteo7EeMFu2WdvB3rumUu
         4Nkw==
X-Received: by 10.180.92.1 with SMTP id ci1mr5626624wib.14.1375305823866; Wed,
 31 Jul 2013 14:23:43 -0700 (PDT)
Received: by 10.194.81.102 with HTTP; Wed, 31 Jul 2013 14:23:43 -0700 (PDT)
In-Reply-To: <CALWbr2wR2cN8dcOtW2bV3p7FC3ymdXgfp61A4pNKvOWhP6WU_Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231464>

On Wed, Jul 31, 2013 at 2:08 PM, Antoine Pelisse <apelisse@gmail.com> wrote:
> On Wed, Jul 31, 2013 at 9:51 PM, Brandon Casey <bcasey@nvidia.com> wrote:
>> -----------------------------------------------------------------------------------
>> This email message is for the sole use of the intended recipient(s) and may contain
>> confidential information.  Any unauthorized review, use, disclosure or distribution
>> is prohibited.  If you are not the intended recipient, please contact the sender by
>> reply email and destroy all copies of the original message.
>> -----------------------------------------------------------------------------------
>
> I'm certainly not a lawyer, and I'm sorry for not reviewing the
> content of the patch instead, but is that not a problem from a legal
> point of view ?
> I remember a video of Greg Kroah-Hartman where he talked about that
> (the video was posted by Junio on G+).

Me either thank God.  Are those footers even enforceable?  I mean,
really, if someone mistakenly sends me their corporate financial
numbers am I supposed to be under some legal obligation not to share
it?  I always assumed it was a scare tactic that lawyers like to use.

To address the text of the footer, I'd say the "intended recipient(s)"
are those on the "to" line which includes git@vger.kernel.org and the
implicit use is for inclusion and distribution in the git source code.

Anyway, I doubt I would have any influence on getting the footer
removed.  If Junio would rather me not submit patches with that
footer, then I'd try to find a workaround.

-Brandon
