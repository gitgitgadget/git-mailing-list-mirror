From: =?UTF-8?B?6rmA64Ko7ZiV?= <namhyung.kim@lge.com>
Subject: Re: [PATCH 2/2] ctype: implement islower/isupper macro
Date: Fri, 10 Feb 2012 11:32:45 +0900
Message-ID: <4F3481CD.5010303@lge.com>
References: <1328840011-19028-1-git-send-email-namhyung.kim@lge.com> <1328840011-19028-2-git-send-email-namhyung.kim@lge.com> <7vwr7vsa8j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 10 03:32:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvgI8-0001TM-WC
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 03:32:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758193Ab2BJCcs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Feb 2012 21:32:48 -0500
Received: from LGEMRELSE6Q.lge.com ([156.147.1.121]:59470 "EHLO
	LGEMRELSE6Q.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758134Ab2BJCcr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2012 21:32:47 -0500
X-AuditID: 9c930179-b7cf1ae000000e40-b9-4f3481cd6e3a
Received: from [192.168.0.5] ( [10.177.201.156])
	by LGEMRELSE6Q.lge.com (Symantec Brightmail Gateway) with SMTP id 1F.87.03648.DC1843F4; Fri, 10 Feb 2012 11:32:45 +0900 (KST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
In-Reply-To: <7vwr7vsa8j.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190371>

Hello,

2012-02-10 11:17 AM, Junio C Hamano wrote:
> Namhyung Kim <namhyung.kim@lge.com> writes:
>
>> The git-compat-util.h provides various ctype macros but lacks those two
>> (along with others). Add them.
>
> Isn't that because we do not use them ourselves? Uses in compat/ do not
> count, and judging from the way it is used in compat/fnmatch/fnmatch.c,
> the implementation of sane_iscase() might be overly protective.
>
> What problem are you trying to solve?
>

There's no problem. In fact, these patches come from perf as it uses a copy of 
git code in this part. So I didn't check it's really needed for git too, but 
just hoped it'd be helpful someday. If you don't think it's worth applying I'm 
fine with dropping it.

Thanks,
Namhyung
