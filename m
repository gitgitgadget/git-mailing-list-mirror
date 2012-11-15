From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: What's cooking in git.git (Nov 2012, #03; Tue, 13)
Date: Thu, 15 Nov 2012 06:54:25 +0100
Message-ID: <50A48391.9090207@web.de>
References: <20121113175205.GA26960@sigill.intra.peff.net> <50A2B14C.9040608@web.de> <50A2F17D.4010907@gmail.com> <20121114190228.GA3860@sigill.intra.peff.net> <50A40978.2060504@web.de> <20121115001635.GA17370@sigill.intra.peff.net> <50A44A73.8020007@gmail.com> <20121115015608.GB19131@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Mark Levedahl <mlevedahl@gmail.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGE=?= =?UTF-8?B?dXNlbg==?= 
	<tboegi@web.de>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 15 06:55:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYsPj-00051t-NO
	for gcvg-git-2@plane.gmane.org; Thu, 15 Nov 2012 06:55:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144Ab2KOFy2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2012 00:54:28 -0500
Received: from mout.web.de ([212.227.17.11]:61140 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750801Ab2KOFy1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2012 00:54:27 -0500
Received: from birne.lan ([195.67.191.23]) by smtp.web.de (mrweb101) with
 ESMTPA (Nemesis) id 0Laky4-1Ssz5V2WTo-00krmP; Thu, 15 Nov 2012 06:54:26 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:16.0) Gecko/20121026 Thunderbird/16.0.2
In-Reply-To: <20121115015608.GB19131@sigill.intra.peff.net>
X-Provags-ID: V02:K0:WkdTsSmqzXg1ODHWeFv2fYQ0oB2Obcz8Ng5alFtVtQ4
 Ie8vpWB9DyWxvnBN7V6CZP6BVMEo49P9rsba/pDem9wrvvyZwj
 2tWUp+La+feoTYHIqcn4aVl+nRcjQPLHnc4Fes7FvXgyU9sfSI
 mp98e1Y9h1o97i64aGGQM3TRqpgOZts/W0ezeflImtJiDQRvge
 PCQwWvFAy6qcyIIuBFpDw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209798>

On 15.11.12 02:56, Jeff King wrote:
> On Wed, Nov 14, 2012 at 08:50:43PM -0500, Mark Levedahl wrote:
> 
>> Cygwin changed the win32api implementation, and the old is not just
>> no longer supported for the current release series, but virtually
>> impossible to even install (several new packages are now installed,
>> the old package is in the "obsolete" category, i.e., not available).
>> The older cygwin 1.5 dll + utilities can be installed afresh, so that
>> is why I set up to switch based upon dll version - the proposed
>> test(s) and configuration would be to have git maintain compatibility
>> with an unsupported Cygwin configuration. I just don't think this is
>> worth the maintenance burden, but of course I am not the maintainer,
>> just expressing my opinion.
> 
> OK. I don't have a strong opinion either, as I don't know what's normal
> in the Cygwin world, and that is probably the most important thing to
> follow for the default. I got the impression that "normal" is changing
> to the new way, but Torsten's message made me wonder if were there quite
> yet (if there was some issue with upgrades versus new fresh installs).
> 
> But I have no real cygwin knowledge, so I'll bow out and let you guys
> discuss.
> 

My understanding:
Either use people cygwin 1.5 or they use cygwin 1.7, and in this case
the installation is updated frequently.

Peff or Junio, please go ahead with the patch.

If it turns out that we want to support cygwin installations like 1.7.7
which could be upgraded, but are not upgraded since they are
"production machines we do not dare to touch" we can still improve
the autodetection.

Thanks for the responses.
/Torsten
