From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v8 10/10] ce_compare_data() did not respect conversion
Date: Sun, 1 May 2016 18:27:05 +0200
Message-ID: <a571e222-68db-3dc1-1a94-d6b47feaf84d@web.de>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
 <1461942126-16296-1-git-send-email-tboegi@web.de>
 <xmqqvb30w29z.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, tboegi@web.de
X-From: git-owner@vger.kernel.org Sun May 01 18:27:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awuDG-00057b-FW
	for gcvg-git-2@plane.gmane.org; Sun, 01 May 2016 18:27:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752043AbcEAQ1O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 May 2016 12:27:14 -0400
Received: from mout.web.de ([212.227.17.12]:60651 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751502AbcEAQ1O (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2016 12:27:14 -0400
Received: from macce.local ([195.252.60.88]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0LpO4v-1bZpWh2BUr-00f7GT; Sun, 01 May 2016 18:27:06
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:45.0)
 Gecko/20100101 Thunderbird/45.0
In-Reply-To: <xmqqvb30w29z.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:fA/dtFbfDYjLLAkoI59cIYLSKCcVBeE3E/su/IJiy5yM8tNm83l
 InGgDcukjQ+RVuHpqVLOg6lzD3LllVWQY6vUI8+//bjpNs1zqaeDszKIlO+5pfkWj3LAd1a
 81RPWyXRHohhKu8M7OSdGwtYdOkrP99ynmRTl0mZYqyIL4rG+3Tor804wA/tXHQFUnH3shO
 Aj7eIMesVOydxN/76bM5A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YPBFPl7tnAw=:TaWz/xBmlJRt6mUpL8lYgk
 D5/xRW7N5H0/NCiMHnJJ5P/WqicY8/263u/ISTD0eOXSL1FhyAn+qR9/JtIU+x1ZbqYYJENUH
 GycjuXECFAHu/f6YdUmc4yJI1yawnyF3ScaOCESn6/FUbfyfTJ3yd901RRfi3KRDN6cCfRzxS
 Yl8B7ibWZLmTWDmdAoZAjUmkMSY7GirDW7x7Et5QKILjPx/rQhBGm/WGkMxEx6uyHYsPjnXa5
 34EjioB4N3WwyFT9IfnoRQcyrVWvYbo9GJLm7yHPksxJB/7ROqH2O9WxkN6PPt55A5IlfmzKT
 k7m6vUC/TGE1DN82diTBMrmmAsfGtqNQFaP07eKdtfJwqmGvwfAZok5r/eKmEC2RU3hskLquK
 h7tHqsMnR9MCnOnWbHTFR/IRhYMZUkKIbJx28K2uS0WcAnqgmS7uuYIhW8m5YHwv1jNDIBBHC
 onzJZECik3lMvDDtuWpVdGG2mbuyz19t07bD5BD9kqsR4N4+phBxPRdaOf6xgXVzpkr+K6fRr
 B6s3ZwaBsrtLZkIRZBGhu/7ySKr+xkkjUIhlRxAcyJsqhP8NSkb9zst0I2vjiRcpdE2yQf5WZ
 YII614VEXSRwicOHn7gxOCysuB/0JaVRT2wd3jHobEqDq2iq7urwU06rs7MuyWx5NkfoSlkb3
 1l+cwnohRO0Jr4h0HUnZxueNnOH/4rtQDpuzrdAe/15iQjeGPw1bHqUIdVuTLfdPwLmOu1MfZ
 kBb8jPi4PFD6nA9/RLwoq/qaNZxMc+VwMEQgDv2SZPPLuuw95VD2nU2GLscDyeoiF3MWsxB4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293195>

On 29.04.16 23:09, Junio C Hamano wrote:

> Well, didn't I do exactly the above much earlier and discarded it
> because that breaks the definition of "diff"?  Or is this doing
> something differently?

Yes, and I try to sneak it in anyway ;-)

I spend some time debugging how to get t6038 passed, and need
some more time.

If 10/10 is a no-go (and it probably should be),
does it make sense to keep 1/10..4/10 and discard 5..10 for the moment ?
