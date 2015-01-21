From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 18/18] fsck: git receive-pack: support excluding
 objects  from fsck'ing
Date: Wed, 21 Jan 2015 19:17:06 +0100
Organization: gmx
Message-ID: <1c7e63ae18eb0a164081cc3601c3058e@www.dscho.org>
References: <xmqqr3w7gxr4.fsf@gitster.dls.corp.google.com>
 <cover.1421682369.git.johannes.schindelin@gmx.de>
 <dd54b4dc097f18bb3427ec6408e71ad65efd08a1.1421682369.git.johannes.schindelin@gmx.de>
 <xmqq8ugwy094.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 21 19:17:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDzq9-0005Py-K0
	for gcvg-git-2@plane.gmane.org; Wed, 21 Jan 2015 19:17:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752070AbbAUSRO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2015 13:17:14 -0500
Received: from mout.gmx.net ([212.227.15.19]:59643 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750868AbbAUSRM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2015 13:17:12 -0500
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MMCFR-1Y61ct2tcT-0084ki; Wed, 21 Jan 2015 19:17:06
 +0100
In-Reply-To: <xmqq8ugwy094.fsf@gitster.dls.corp.google.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1-git
X-Provags-ID: V03:K0:Ls7BRR8EQwj+OL/p1p7VDBXts2zFYocOpyQrFz+5jwHwkHkzoIH
 WpkgWxXHHFZ4Y5POSMr7zCmMbI5PnTrqYSHB369r5a/IO+VLB9f8zzd/fRe2rapKrNEmt+O
 RRGXx1nzJxtRslGVGZ0StjgX4PdgsEkLh5NzYpu0K7OaAE2ALx2ASHZkvC+0a1pzFOnCEnH
 DHpTUAX1fQamWZJPmWlFQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262738>

Hi Junio,

On 2015-01-21 10:02, Junio C Hamano wrote:
> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
>> The optional new config option `receive.fsck.skiplist` specifies the path
>> to a file listing the names, i.e. SHA-1s, one per line, of objects that
>> are to be ignored by `git receive-pack` when `receive.fsckObjects = true`.
> 
> Makes sense, but I wonder if it makes sense to have a similar "ok to
> be broken" list for "git fsck" (or perhaps they could even use the
> same list) for exactly the same reason why this option makes sense.

Sure! The most pressing use case for the skiplist feature is a Git server, hence this patch. I will implement the corresponding `git fsck` patch before re-submitting.

Ciao,
Dscho
