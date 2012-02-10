From: Namhyung Kim <namhyung.kim@lge.com>
Subject: Re: [PATCH 2/2] ctype: implement islower/isupper macro
Date: Fri, 10 Feb 2012 14:04:53 +0900
Message-ID: <4F34A575.3000700@lge.com>
References: <1328840011-19028-1-git-send-email-namhyung.kim@lge.com> <1328840011-19028-2-git-send-email-namhyung.kim@lge.com> <7vwr7vsa8j.fsf@alter.siamese.dyndns.org> <4F3481CD.5010303@lge.com> <7vliobs5bh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 10 06:05:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvifR-0005TV-FB
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 06:05:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750882Ab2BJFE5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Feb 2012 00:04:57 -0500
Received: from LGEMRELSE6Q.lge.com ([156.147.1.121]:63907 "EHLO
	LGEMRELSE6Q.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750831Ab2BJFE4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2012 00:04:56 -0500
X-AuditID: 9c930179-b7cf1ae000000e40-72-4f34a5754374
Received: from [192.168.0.25] ( [10.177.201.156])
	by LGEMRELSE6Q.lge.com (Symantec Brightmail Gateway) with SMTP id 8E.3C.03648.575A43F4; Fri, 10 Feb 2012 14:04:54 +0900 (KST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
In-Reply-To: <7vliobs5bh.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190381>

2012-02-10 1:03 PM, Junio C Hamano wrote:
> =EA=B9=80=EB=82=A8=ED=98=95<namhyung.kim@lge.com>  writes:
>
>> 2012-02-10 11:17 AM, Junio C Hamano wrote:
>>> Namhyung Kim<namhyung.kim@lge.com>  writes:
>>>
>>>> The git-compat-util.h provides various ctype macros but lacks thos=
e two
>>>> (along with others). Add them.
>>>
>>> Isn't that because we do not use them ourselves? Uses in compat/ do=
 not
>>> count, and judging from the way it is used in compat/fnmatch/fnmatc=
h.c,
>>> the implementation of sane_iscase() might be overly protective.
>>>
>>> What problem are you trying to solve?
>>
>> There's no problem. In fact, these patches come from perf as it uses=
 a
>> copy of git code in this part.
>
> Kim-ssi, the above is something I would have like to see in your firs=
t
> message.
>
>> If you don't
>> think it's worth applying I'm fine with dropping it.
>
> I never said these patches are worthless.
>
> I just was wondering what the motivation behind them were.  If you ar=
e
> involved in maintaining Perf, and if it wants to keep its own forked =
copy
> as close as ours, that is a good enough justification, as long as the
> additions we do not use ourselves is still reasonably done.
>

Hamano-san, Thanks for your explanation. I'll try to write a better=20
description for the future.

Thanks,
Namhyung
