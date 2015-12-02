From: Mike Crowe <mac@mcrowe.com>
Subject: Re: [PATCH v3] push: add recurseSubmodules config option
Date: Wed, 2 Dec 2015 09:54:51 +0000
Message-ID: <20151202095451.GA22568@mcrowe.com>
References: <1448970583-14513-1-git-send-email-mac@mcrowe.com>
 <20151202004031.GA28197@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 02 10:55:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a447r-0006R8-4G
	for gcvg-git-2@plane.gmane.org; Wed, 02 Dec 2015 10:55:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757684AbbLBJy5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2015 04:54:57 -0500
Received: from avasout05.plus.net ([84.93.230.250]:55334 "EHLO
	avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756926AbbLBJyz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2015 04:54:55 -0500
Received: from deneb ([80.229.24.9])
	by avasout05 with smtp
	id oZur1r0030BmcFC01ZusVa; Wed, 02 Dec 2015 09:54:54 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=MryvkDue c=1 sm=1 tr=0
 a=E/9URZZQ5L3bK/voZ0g0HQ==:117 a=E/9URZZQ5L3bK/voZ0g0HQ==:17 a=0Bzu9jTXAAAA:8
 a=-An2I_7KAAAA:8 a=kj9zAlcOel0A:10 a=wUQvQvOEmiQA:10 a=hX2CisA4_K8kL02QDEoA:9
 a=CjuIK1q_8ugA:10
Received: from mac by deneb with local (Exim 4.84)
	(envelope-from <mac@mcrowe.com>)
	id 1a447f-00060l-87; Wed, 02 Dec 2015 09:54:51 +0000
Content-Disposition: inline
In-Reply-To: <20151202004031.GA28197@sigill.intra.peff.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281883>

On Tuesday 01 December 2015 at 19:40:32 -0500, Jeff King wrote:
> On Tue, Dec 01, 2015 at 11:49:43AM +0000, Mike Crowe wrote:
> 
> > The --recurse-submodules command line parameter has existed for some
> > time but it has no config file equivalent.
> > 
> > Following the style of the corresponding parameter for git fetch,
> > invent push.recurseSubmodules to provide a default for this parameter.
> > This also requires the addition of --recurse-submodules=no to allow
> > the configuration to be overridden on the command line when required.
> > 
> > The most straightforward way to implement this appears to be to make
> > push use code in submodule-config in a similar way to fetch.
> > 
> > Signed-off-by: Mike Crowe <mac@mcrowe.com>
> > ---
> > Changes in v3:
> 
> Hrm, I merged v2 of this to 'next' last week.

Thanks! Sorry I didn't spot that.

> The options at this point are either to revert that and re-start the
> topic, or just make the further changes a patch on top. Thoughts?

I don't mind which you choose to do. I'll reply to this message with the
incremental patch in case you decide you need it. Please let me know if
you'd like me to split it further since the patch modifies a test that is
otherwise unrelated to the rest of the change.

Mike.
