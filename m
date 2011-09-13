From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: What's cooking in git.git (Sep 2011, #04; Mon, 12)
Date: Tue, 13 Sep 2011 11:22:17 -0500
Message-ID: <5XXEFw0WjtXKd9dpXSxpkskCcgVyG9Db1_zzVSEBNey-kpXSBbmQfYaxZ2Szg6Pbck6hZZTQ5hHzBwG4rhKYXshrd-mveEFLPZ9W0V8P_lw@cipher.nrlssc.navy.mil>
References: <7v4o0h7byd.fsf@alter.siamese.dyndns.org> <7vk49d5t8u.fsf@alter.siamese.dyndns.org> <4E6E928A.6080003@sunshineco.com> <7vwrdd1gyc.fsf@alter.siamese.dyndns.org> <20110912233348.GE28994@sigill.intra.peff.net> <E1YOVd7kYi7-W-xz9qnSY9Zotnh_bHUcGRF8i2SkwEZq6IOV__IIMQ@cipher.nrlssc.navy.mil> <20110913160520.GA28634@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
	Boaz Harrosh <bharrosh@panasas.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Alexey Shumkin <zapped@mail.ru>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 13 18:23:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3Vld-000189-NP
	for gcvg-git-2@lo.gmane.org; Tue, 13 Sep 2011 18:23:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755393Ab1IMQXV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Sep 2011 12:23:21 -0400
Received: from mail3.nrlssc.navy.mil ([128.160.11.249]:44416 "EHLO
	mail3.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755230Ab1IMQXU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Sep 2011 12:23:20 -0400
Received: by mail3.nrlssc.navy.mil id p8DGMIWf010912; Tue, 13 Sep 2011 11:22:18 -0500
In-Reply-To: <20110913160520.GA28634@sigill.intra.peff.net>
X-OriginalArrivalTime: 13 Sep 2011 16:22:17.0677 (UTC) FILETIME=[4E22CFD0:01CC7231]
X-Virus-Scanned: clamav-milter 0.97.2 at mail3
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181289>

On 09/13/2011 11:05 AM, Jeff King wrote:
> On Tue, Sep 13, 2011 at 10:15:15AM -0500, Brandon Casey wrote:
> 
>> ...and I see there is already an fnmatch_icase() in dir.c which adds
>> FNM_CASEFOLD when the global var ignore_case is set.  So, maybe it's as
>> easy as:
>> [...]
>> -               return (fnmatch(pattern, basename, 0) == 0);
>> +               return (fnmatch_icase(pattern, basename, 0) == 0);
> 
> OK, wow. That's exactly the level of easy I was hoping for. Do you want
> to roll that up into a patch with some tests?

I haven't even tested that it runs. :)  No, I was hoping someone 
who was more interested would finish it, and maybe even test on
an affected system.

-Brandon
