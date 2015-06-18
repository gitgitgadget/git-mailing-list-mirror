From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/2] t3404: demonstrate =?UTF-8?Q?CHERRY=5FPICK=5FHEAD?=
 =?UTF-8?Q?=20bug?=
Date: Thu, 18 Jun 2015 18:16:19 +0200
Organization: gmx
Message-ID: <0f55232f453ab3a75bafe17db2744552@www.dscho.org>
References: <20150616140612.Horde.a1irZQmh2o42SqDfxAytHg1@webmail.informatik.kit.edu>
 <cover.1434528725.git.johannes.schindelin@gmx.de>
 <f76ca5d0b6687a4d2ee4f587d8ba75a643a33c04.1434528725.git.johannes.schindelin@gmx.de>
 <xmqqtwu66xzg.fsf@gitster.dls.corp.google.com>
 <c2b427850cc6f298bee017123639c4df@www.dscho.org>
 <xmqqoakdf1lu.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, szeder@ira.uka.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 18 18:16:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5cUQ-0006cT-0m
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 18:16:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932522AbbFRQQ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 12:16:26 -0400
Received: from mout.gmx.net ([212.227.17.22]:60658 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932482AbbFRQQY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 12:16:24 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LwW8p-1Z40Tr08WV-018GIy; Thu, 18 Jun 2015 18:16:20
 +0200
In-Reply-To: <xmqqoakdf1lu.fsf@gitster.dls.corp.google.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:AW8g4YLhDDQhHlzwlor7khtweUml1Zp04AtSQ3k7qdd8Q3Fy1yO
 jdRsrDbzCjjK2n33fhJ3j5n3/B4hxSvdR+fp3P7jvByXBdC/5I9yIAjSewZ3i5MIMLZG/IX
 ewGzjFUg/+yqRThZkcM2+udmtQ/OZuhmqPEAQClAcM7eLS/2YIVs+CpXCNp+gYKEXrmBy0e
 VUNFbO2VgE0DHZFriKSIg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2V1/cj6EIIA=:Hm4M01O2OA1G4Grwyr6b9D
 IT5yH0l87CPdKX7KSFQQO6g4vK++ayQKMknkmIGaAcyD7a/7PuNRyw6KHFCtOF7q0wByGRrxt
 iEQMzF2Iqt84mVVDn/ml6QlK8ceA8n6Qbn/ZBnL2c1B8c0rnYJbV3Krd4QH/kSyRW72dnoafY
 g0j9hbbzO4VTS93wSPzt4sJnrASKX7h6ltvo/qTEa1dRqVckK+uuxaDnttimU6ZIZmxDXLk3i
 PnTRdO08Ssrl5CaEM9VvCkKZc1b9pBOXssK/nHThJkoVqRTATbQRbTc0KzCUGslVTzytVBKv1
 OI0PgGlPjBLEXSUECHFspdc9IxEfTQ9X0FQmCtJ4fPcKE1P+78q/rwlmwzp5QPaUNIGq/TSz1
 SNIdY0wyfmfNnHpqmk1B7otGo90oObv/8NIYe0zVRDiUC28FtN5mUhYFy2xYYxFsm7+UYKyRE
 abjmj4Ok/VJx/o10O6S6JFjolMHBgT8THh4FK36if67rfGHrDOtbwmp+H6BYiAjVbXqJ3GZoo
 hkac4twZDVnJiEVW1/yvkusMgDCDLIvUpMM7oTcPO0N0w5yxMTFG906Ay6TtCqE4SIhfXTkxH
 gCE9/Z0NtEMuE9qzX1oFLyV/NdbwEh2Wob0h2gIdT84y1xZ/4AdBaGLpk+yOXJ5c//tcspa9x
 YG/euB8U/tMyAKPs80Yvbn0iMliiN9sesFKkfRcJK2cpL5FTLozLapg2hJDC4L8vsUbU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272022>

Hi Junio,

On 2015-06-18 18:00, Junio C Hamano wrote:
> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
>>>> +	git diff seq-onto &&
>>>
>>> I am puzzled with this "diff"; what is this about?  Is it a remnant
>>> from an earlier debugging session, or is it making sure seq-onto is
>>> a valid tree-ish?
>>
>> The idea is to verify that we end up with the same tree even if we
>> exchanged the latest two patches. I can remove it if you want as it is
>> not strictly necessary, but I would like to keep it just to make sure
>> that we did not end up with an incomplete rebase.
> 
> I agree that such a verification is a very good thing to have here.
> But you would need to ask "git diff" to signal that it found no
> differences with --exit-code or --quiet, I would think.
> 
> Thanks.

Whoops! Of course... You want me to re-roll?

Ciao,
Dscho
