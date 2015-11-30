From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC PATCH 0/5] Submodule Groups
Date: Mon, 30 Nov 2015 15:54:54 -0800
Message-ID: <CAGZ79kZGydm=yYkc-Na2QqpGhLB-KEdh7XyxHPYZqZDzpi3F7w@mail.gmail.com>
References: <1448415139-23675-1-git-send-email-sbeller@google.com>
	<5655F166.9090601@web.de>
	<CAGZ79kbd2g9QSuGmyf6Ybp6dCqMfSBqj8WZgfTejXU8OdszaBw@mail.gmail.com>
	<5656096A.7010408@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Eric Sunshine <ericsunshine@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Dec 01 00:55:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a3YHb-0004sO-Qw
	for gcvg-git-2@plane.gmane.org; Tue, 01 Dec 2015 00:55:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755337AbbK3Xyz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2015 18:54:55 -0500
Received: from mail-yk0-f178.google.com ([209.85.160.178]:33602 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754543AbbK3Xyy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2015 18:54:54 -0500
Received: by ykdv3 with SMTP id v3so204959303ykd.0
        for <git@vger.kernel.org>; Mon, 30 Nov 2015 15:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Fy/GbtK2zzjz002yloW/yZciBe3LMcKxm0qqVtWuJcc=;
        b=RKtIuJ5raNUD0xdT6fNRg11olrSobnp6l99GJ9pJC+mxz1e7L7aXb3rE3F9IZxBKxM
         hire+ZY0LO9rVPJ1YOu3nuwv/OijgbD0ldEA4V0wqnG+ev8S0O9KVLYBML+9fuhIHmuP
         VRARm0TCpCQycebVlKL6YGGY5laevwADkczvoCtijuiI5xnkpKpLIWQlgVkmc2imw+ff
         kHQDvMhBOG4W5o+oujQF6y0PmqXyxueVuA+I1eHBvWSW4yy7hakrYvFjWc4L5t2+yg4M
         CaKVsnjqTtmxHNMgSjoD+Nq46pbIzg3cLsAkpRxph8RCLsXMeNJWAUJrqAU7yRKy0g6q
         cE8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Fy/GbtK2zzjz002yloW/yZciBe3LMcKxm0qqVtWuJcc=;
        b=iNOjEySbc7DA4XghlG6wy7n51m1nDycVGVQY2Ke0zP/wweqqp3nIsbYAn+3PbizOWt
         n1+MtTIb0AcWYxGqyOk3Hp5IfB0FDPvtkSxFTJCQTdavtVl21RAgI5O7wAz+4x6aRCpb
         mS5U7Yk8D7ThL3dUWPkaFsm+F/iDc2iU/RqSV07LPyZLl1YJqxXZCJGmxtGZjPsooVsR
         hhTJX55kz5SVmB3dBjTcRYiLbGcDbhmL+L44pJv+fXxF3C96m0jBDggmDfaSyUNjJxsa
         U//goDXuiS6m65Ntm6y9qCaXApM++rKZNYW2oDqulbhhUoXLuoXZdsKFVC4jh/5ap17y
         I5Xg==
X-Gm-Message-State: ALoCoQlmbzUfnEW45PJNcjoZBDkP4rMAx8e7bIWrqOAfmvFzn7MgDr4VUJJ7pxewd59zx3z48foN
X-Received: by 10.13.221.21 with SMTP id g21mr16531602ywe.320.1448927694287;
 Mon, 30 Nov 2015 15:54:54 -0800 (PST)
Received: by 10.37.215.16 with HTTP; Mon, 30 Nov 2015 15:54:54 -0800 (PST)
In-Reply-To: <5656096A.7010408@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281825>

On Wed, Nov 25, 2015 at 11:18 AM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>>>
>>> Hmm, I doubt it makes much sense to add the --group option to "git
>>> submodule init". I'd rather init all submodules and do the group
>>> handling only in the "git submodule update" command. That way
>>> upstream can change grouping later without having the user to
>>> fiddle with her configuration to make that work.
>>

Mind to elaborate a bit more here?
The way I understand you now is to pass not --groups to init,
but init initializes all submodules. But that is worse IMHO
(In the naive way of dealing with groups in the first patch series)
as then we open up two possibilities:
 * a submodule which happened to be part of the repository
   when cloning is added to a new group, which a user has
   configured, on pulling, this is no problem, we just checkout
   the desired version of the submodule.
 * a submodule which was not part of the repository at the time
   of cloning, is added to the superproject with a group the user
   is subscribed to. This would not be checked out as it is uninitialized
   on disk.

So when a change of the set of submodules as defined by groups
occurs, that is the point in time, when we want to init/fetch/checkout
these submodules, no?

>>
>> Well if upstream changes grouping later, you could just run
>>
>>      git submodule update --init --groups
>>
>> and get what you want?
>
>
> And make life harder than necessary for our users without having
> a reason for that?

So if upstream changes groups, ideally we want to follow without much
hassle for the user. So a plain git pull should /just work/. (I am repeating
myself here I'd guess), we would need to react to that. if we drop the
--groups call to init, we'd still tell the user to run

     git submodule update

We do not need --groups any more in a later patch as instead of
passing in --groups we can detect for `git config submodule.groups`
to be available or not.

--init should not be needed as when the groups are there we automatically
init new submodules in the group set?

> Except for the URL copying submodule settings
> on init is wrong, as it sets in stone what happened to be in the
> .gitmodules file when you ran init and doesn't allow upstream to
> easily change defaults later. We still do that with the update
> setting for historical reasons, but I avoided making the same
> mistake with all the options I added later. You can override
> these settings if you want or need to, but that shouldn't be
> necessary by default to make life easier for our users.
>
