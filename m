From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: What's cooking in git.git (Sep 2012, #02; Fri, 7)
Date: Sat, 08 Sep 2012 07:47:22 +0200
Message-ID: <504ADBEA.1050606@web.de>
References: <7vy5klv6oj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 08 07:48:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TADtw-0008Vg-0E
	for gcvg-git-2@plane.gmane.org; Sat, 08 Sep 2012 07:48:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192Ab2IHFr0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Sep 2012 01:47:26 -0400
Received: from mout.web.de ([212.227.15.3]:59956 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750994Ab2IHFrZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Sep 2012 01:47:25 -0400
Received: from birne.lan ([195.67.191.22]) by smtp.web.de (mrweb001) with
 ESMTPA (Nemesis) id 0Lbrk4-1TtDjz0bP2-00k6dW; Sat, 08 Sep 2012 07:47:23 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:15.0) Gecko/20120824 Thunderbird/15.0
In-Reply-To: <7vy5klv6oj.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:hlqx/0aTJQHBcWcHna8nbWAZLm6xhZWPzNWE6xEwSjb
 O7REUGTafeGuT6m01hkpdanTdVgBKYPweHTie0M5Qu6yArkR5i
 ipJaSgziwIpb7VFZ4pdF2ocyght2lVD6mrk2UAeBy7TH1003j+
 YLf+g5YCw0fkmu/ZtxVygI6P272Fv6iMSHoyAEhhf4PheeFi+3
 GUSfBrFSoddzXIgq6p+LA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205008>

On 07.09.12 23:55, Junio C Hamano wrote:
> [Discarded]
> 
> * jc/sanitize-nkd-lazy-iconv-open (2012-07-31) 1 commit
>  . macos: lazily initialize iconv
> 
> Teach the code that works around NKD/NKC gotcha on MacOS to call
> iconv_open() only when it is necessary, in the hope of avoiding
> set-up overhead.  It turns out that there was no noticeable
> improvements.

My vote is not to discard the branch: 

Even if the improvements are not measurable, the lazy iconv_open
is a good coding style.

It might inspire people to use resources carefully, 
and only allocate them if they are really needed.
