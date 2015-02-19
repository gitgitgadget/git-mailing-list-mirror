From: Stefan Beller <sbeller@google.com>
Subject: Re: [Discuss] soften warning message after cloning "void"
Date: Wed, 18 Feb 2015 21:12:06 -0800
Message-ID: <CAGZ79kZAtnhKYQgoA=d-UfQ8LfH4qTxaAFpJRJPSYApD7dwtzg@mail.gmail.com>
References: <xmqqh9ui2481.fsf@gitster.dls.corp.google.com>
	<CAGZ79kYu1k=iKRWTxVD9Q=C9F5J0d653czeR0NCy04wGobB=Vw@mail.gmail.com>
	<CAPc5daUzdiS0HkVbqZvQvSm_49FhQj++hicmDTb717Cd7hg8hA@mail.gmail.com>
	<CAJo=hJt4qVd_dybSn9Wy2UPpvm1+Kg0pE=vyB_fr0eHqQEXdVg@mail.gmail.com>
	<CAPc5daVoHCxg8-xEVxJK-G0HKKHApbwCzTd0q6jab5jfyHcarQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Shawn Pearce <spearce@spearce.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 06:12:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOJPL-0001Mb-KZ
	for gcvg-git-2@plane.gmane.org; Thu, 19 Feb 2015 06:12:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750856AbbBSFMJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2015 00:12:09 -0500
Received: from mail-ie0-f173.google.com ([209.85.223.173]:45328 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750715AbbBSFMH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2015 00:12:07 -0500
Received: by iecat20 with SMTP id at20so6869987iec.12
        for <git@vger.kernel.org>; Wed, 18 Feb 2015 21:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=gIosjBTvMjE1PFrQRBCf9dU56Q9Rc2N4DJBxbGXvYbI=;
        b=kwSvoz4rsXgN3WH5DFGx/qckJZrtFQ9d72XsMrDHTNXh/ULce1JdbbzYwQ9Q36DYi0
         6TlovKtHGZfn+ueIIXrcRi7ghWtk52V0IZF9CS14d5na9IWHA0P5sZ7CUp9A3JWJamFt
         VqadYkCgRoSPQc8ORVZOAkyRcsm4iF7ZK2XQjnS6FLO5EN7kgpwsJBVZ50FISn2nDV78
         GHqXB1Il8CmZqrSI3K2+uVgCg5XFDzG1UdFQ6k5fsi5iHMTQweVgN0LDttXD5SfCA+Lf
         ELPl47YS34zUvKrePrq9hj+OMzoBTz0y6lDkVG3BMT20m70VAeAEmDegdByBFKQeY99E
         /cvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=gIosjBTvMjE1PFrQRBCf9dU56Q9Rc2N4DJBxbGXvYbI=;
        b=PJ19Jq5IWHQco/sN2JAtl7in/lLzuIbRgOy0W52dNsB8cLZbIL0od55tBNtsyeHaJa
         rGHzWezy9h6G1GIxbv4y14y/FCmfMwt5uZIbXyCAyXsa0eOr6g14Mv0SvOA5oINT50bH
         RMkJEZfxMyyuWpVl2qG4ZC0Cxf7/88sFkWrvE8P7kocn+uu8ONneyIYJMVXMvRJefHcz
         v8yoqEgiMMfvzx+B2Gvtf7ZzH7KbeAvton+gYM4XmEQtkPqcBKjFS1OJIano2emjKKBK
         olWwC4/VZECG33pH6KsRyUdZ3PpsyCrGNc7LeWL8HJleM5+aI4DHfuvi8qCFWHMmNR4A
         8zww==
X-Gm-Message-State: ALoCoQnbQjAluhwfpgHOUnie18csnkEaJI5CB/txsM6yZL2/9DP48mY5e2MWGy3nL2nBL110PS+O
X-Received: by 10.42.159.129 with SMTP id l1mr4044184icx.15.1424322727028;
 Wed, 18 Feb 2015 21:12:07 -0800 (PST)
Received: by 10.50.26.42 with HTTP; Wed, 18 Feb 2015 21:12:06 -0800 (PST)
In-Reply-To: <CAPc5daVoHCxg8-xEVxJK-G0HKKHApbwCzTd0q6jab5jfyHcarQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264082>

On Wed, Feb 18, 2015 at 6:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
> On Wed, Feb 18, 2015 at 4:43 PM, Shawn Pearce <spearce@spearce.org> wrote:
>>
>> This fails from a JGit server because the ref advertisement for an
>> empty repository differs and disagrees with the format used by
>> git-core. The result is a confused client spewing an odd checkout
>> message.
>
> That is exactly why the rephrasing was brought up, wasn't it?
>
> As the Subject: line says, this thread is for people who want to
> help those users with un-odd message, so discuss away
> and come up with a final applicable patch ;-).

"warning: remote HEAD does not exist, not checking out any branch."

would then be the correct answer. Are we able to detect between the
two cases of a HEAD pointing to refs/heads/void and HEAD just not
existing?
