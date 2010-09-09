From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH 4/4] userdiff.c: add builtin fortran regex patterns
Date: Thu, 09 Sep 2010 14:41:47 -0500
Message-ID: <6F7MXe3ksgGGsKBKvAOQG_pNROYqzpzjQTM_YARyO5d1RK6OVY8oLg@cipher.nrlssc.navy.mil>
References: <rRj7JpFIk_D_n7-wGkkucFJE0330IabsqMoSzalswHpjT-Z1HCuOFaIgMsaPgIuQSp0KUMW97Wo@cipher.nrlssc.navy.mil> <rRj7JpFIk_D_n7-wGkkucKFVckLzqXnIAA17N9A643YqyUkXvOqBHrthWFrRRIbouApw4_WLoBE@cipher.nrlssc.navy.mil> <20100909192556.GE32508@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 09 21:41:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Otn0P-0001Yz-0C
	for gcvg-git-2@lo.gmane.org; Thu, 09 Sep 2010 21:41:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755493Ab0IITlv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Sep 2010 15:41:51 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:49985 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753505Ab0IITlu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Sep 2010 15:41:50 -0400
Received: by mail.nrlssc.navy.mil id o89JflDc005722; Thu, 9 Sep 2010 14:41:47 -0500
In-Reply-To: <20100909192556.GE32508@sigill.intra.peff.net>
X-OriginalArrivalTime: 09 Sep 2010 19:41:47.0632 (UTC) FILETIME=[0A5B3F00:01CB5057]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155895>

On 09/09/2010 02:25 PM, Jeff King wrote:
> On Thu, Sep 09, 2010 at 02:02:48PM -0500, Brandon Casey wrote:
> 
>> This adds fortran xfuncname and wordRegex patterns to the list of builtin
>> patterns.  The intention is for the patterns to be appropriate for all
>> versions of fortran including 77, 90, 95.  The patterns can be enabled by
>> adding the diff=fortran attribute to the .gitattributes file for the
>> desired file glob.
> 
> The rest of your series looks reasonable, modulo the comments I posted
> to individual patches. But I won't torture my eyes by trying to actually
> see how well this matches fortran code, and just assume this is a good
> change. :)

I can send you some. :)

>> This also adds a new macro named iPATTERN which is just like the PATTERNS
>> macro except it sets the REG_ICASE flag so that case will be ignored.
> 
> Style nit: please keep macros all uppercase.

Ah, yeah, I guess you're right.

  IPATTERN

Thanks,
-Brandon
