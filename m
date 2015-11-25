From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC PATCH 0/5] Submodule Groups
Date: Wed, 25 Nov 2015 10:00:28 -0800
Message-ID: <CAGZ79kbd2g9QSuGmyf6Ybp6dCqMfSBqj8WZgfTejXU8OdszaBw@mail.gmail.com>
References: <1448415139-23675-1-git-send-email-sbeller@google.com>
	<5655F166.9090601@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Eric Sunshine <ericsunshine@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Nov 25 19:00:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1eMq-0002OT-8K
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 19:00:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751834AbbKYSAb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2015 13:00:31 -0500
Received: from mail-yk0-f179.google.com ([209.85.160.179]:34650 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751566AbbKYSA3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2015 13:00:29 -0500
Received: by ykfs79 with SMTP id s79so64913962ykf.1
        for <git@vger.kernel.org>; Wed, 25 Nov 2015 10:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=iWOLV9cwtUonsSBQI0NI7KdK/qshJ5egDp7sVLjBDQ4=;
        b=ejdg4BfzeA+Z6aZ//6Br1z1Tf0lH9GlSsLqKcNGOTmWB4T2toql/kJfqnk+Ihx8UVO
         uvHxGBCrlm1OALj/3BNtj6qoHmSC1p9zuT/qNjY3/yPZpApkTegXU6BLYNNuak4hLTax
         MSj4OsXy3YmPUXmIcdaCS0aVzfMJKd6Ls/bhOdOhP63LvDjlO4viYL+LwEDkGYbeZ1Gq
         cbUKunh0bYsmz8X2txy4IBREmpHmgYZbNAm8JVpIWv1d3DvKUkTx5fZGqiyAl5lG/p1m
         /ERKJDUkNmu2ujxWYREM+uBBGBT1QIr7KW8wnKsrZ7tP53vrdK9VzND8OUQzrG2TBNal
         H6+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=iWOLV9cwtUonsSBQI0NI7KdK/qshJ5egDp7sVLjBDQ4=;
        b=dSKSdJ8gHWJDfMCsZiYCF5PZW19XsLFkSNq+tZr31RFguhVcJ+aIcHHzRwL+sIyg0H
         o1CenUkEe9oCbQn0sjbPxZ3mPeH+03YZyUZSsrB59sJcaKPC3hi9j6wXfzM4XAOYUij3
         R0asRQVaFykR4DEa57EbpOCpfJnHkpBF+Cxq7WCiqSpKEJjT64wmmbljLXeb8fMExYMB
         q0ac6r8hQUXSYbiZesOF1DxdFPBtuJfLsYLn1U1nGjEdv7IzPpNa02BLi67TcUOIxChv
         kHdf1NJuKLXhQgkpWy16zPVdpmpm7ofBM1b4Mgq/sgzdltK5KD0iE4j4T1GNNKtoIhR2
         0CDQ==
X-Gm-Message-State: ALoCoQmrR+3qqkU2kfF2cVEuvxhoeA2egTZfd/CJO0E0h7yb+F/tDQqApRh7vrAcfJAQi1wxQJto
X-Received: by 10.13.214.19 with SMTP id y19mr33757743ywd.63.1448474428796;
 Wed, 25 Nov 2015 10:00:28 -0800 (PST)
Received: by 10.37.196.70 with HTTP; Wed, 25 Nov 2015 10:00:28 -0800 (PST)
In-Reply-To: <5655F166.9090601@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281723>

--cc Johannes Sixt

On Wed, Nov 25, 2015 at 9:35 AM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>> [submodule "gcc"]
>>          path = gcc
>>          url = git://...
>>          groups = default,devel
>> [submodule "linux"]
>>          path = linux
>>          url = git://...
>>          groups = default
>> [submodule "nethack"]
>>          path = nethack
>>          url = git://...
>>          groups = optional,games
>
>
> Yup. Do you want the user to select only a single group or do you
> plan to support selecting multiple groups at the same time too?

Yes you should be able to select multiple groups, such as
default+devel or alternatively default+games.

The logical OR is supported in this patch series (all submodules which are
in at least one of the specified groups,i.e. A OR B OR C ...)

>
>> and by this series you can work on an arbitrary subgroup of these
>> submodules such
>> using these commands:
>>
>>      git clone --group default --group devel git://...
>>      # will clone the superproject and recursively
>>      # checkout any submodule being in at least one of the groups.
>
>
> Does this automatically configure the given group in .git/config, so
> that all future submodule related commands know about this choice?
> Me thinks that would make sense ...

It does. Internally it does

    git config submodule.groups A,B
    git submodule update --init --groups

whereas submodule update checks if the submodule.groups
value is set and if so operates on the groups only.

>
>>      git submodule add --group default --group devel git://... ..
>>      # will add a submodule, adding 2 submodule
>>      # groups to its entry in .gitmodule
>
>
> Maybe '--groups default,devel' is easier to grok? Dunno.

I guess that makes sense.

>
>>      # as support for clone we want to have:
>>      git config submodule.groups default
>>      git submodule init --groups
>
>
> Hmm, I doubt it makes much sense to add the --group option to "git
> submodule init". I'd rather init all submodules and do the group
> handling only in the "git submodule update" command. That way
> upstream can change grouping later without having the user to
> fiddle with her configuration to make that work.

Well if upstream changes grouping later, you could just run

    git submodule update --init --groups

and get what you want?

>
>>      # will init all submodules from the default group
>>
>>      # as support for clone we want to have:
>>      git config submodule.groups default
>>      git submodule update --groups
>>
>>      # will update all submodules from the default group
>>
>> Any feedback welcome, specially on the design level!
>> (Do we want to have it stored in the .gitmodules file? Do we want to have
>> the groups configured in .git/config as "submodule.groups", any other way
>> to make it future proof and extend the groups syntax?)
>
>
> Not sure what exactly you mean by "it" here ;-)
>
> Talking about what groups a submodule belongs to, an entry in the
> .gitmodules file makes the most sense to me. That way upstream can
> change submodule grouping or add new submodules with group assignments
> from commit to commit, and "git submodule update" will do the right
> thing for the superproject commit checked out.
>
> And I believe that the choice which group(s?) the user is interested
> should be recorded in .git/config, as that is his personal setting
> that shouldn't be influenced by upstream changes.

Right. I once discussed with Jonathan Nieder, who dreamed of a more
logical approach to the groups/sets of submodules. So more like set theory,
i.e. have a more complicated grammar: Get all submodules which are
in either A or B or (D AND E), but which are never in F.
So I'd imagine the groups are more like bit tags, and you can describe
a patterns you want.

I guess we want some more powerful eventually, so I asked this open ended
question there.
