From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] bash completion: remove deprecated --prune from git-gc
Date: Mon, 15 Dec 2008 12:06:17 -0600
Message-ID: <FVglwe6MZJA2-0F8smd8RgHUYqc_tvsZE8KdwKzxQK3gqGN8-pvvhQ@cipher.nrlssc.navy.mil>
References: <200812132008.08543.markus.heidelberg@web.de> <alpine.DEB.1.00.0812141137350.2014@eeepc-johanness> <20081214111213.GA6499@coredump.intra.peff.net> <alpine.DEB.1.00.0812141216120.2014@eeepc-johanness> <20081214111939.GC6499@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Markus Heidelberg <markus.heidelberg@web.de>,
	gitster@pobox.com, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 15 19:08:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCHrX-0004LB-DV
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 19:08:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754898AbYLOSGw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 13:06:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754134AbYLOSGw
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 13:06:52 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:46792 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753856AbYLOSGw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 13:06:52 -0500
Received: by mail.nrlssc.navy.mil id mBFI6HLi027162; Mon, 15 Dec 2008 12:06:17 -0600
In-Reply-To: <20081214111939.GC6499@coredump.intra.peff.net>
X-OriginalArrivalTime: 15 Dec 2008 18:06:17.0571 (UTC) FILETIME=[D37D9330:01C95EDF]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103193>

Jeff King wrote:
> On Sun, Dec 14, 2008 at 12:17:07PM +0100, Johannes Schindelin wrote:
> 
>>> Which annoyingly has no discussion about _why_ it no longer has an
>>> effect. But I suspect it has something to do with 25ee973 (gc: call
>>> "prune --expire 2.weeks.ago" by default, 2008-03-12) by you.
>> Oops.
>>
>> But I thought that git gc --prune does expire _all_ dangling loose 
>> objects _now_, not with --expire 2.weeks.ago.
> 
> Nope, see 25ee973. You explicitly wrote:
> 
>       Note that this new behaviour makes "--prune" be a no-op.
> 
> That being said, I think that is perhaps a reasonable thing for --prune
> to do (and I don't think there is any conflict with the name, because
> that is what it _used_ to do before becoming a no-op). But nobody has
> actually implemented it.

Maybe --mrproper would be a more appropriate name.

-brandon
