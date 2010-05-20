From: Stefan Naewe <stefan.naewe@atlas-elektronik.com>
Subject: Re: git-status and git-diff now very slow in project with a submodule
Date: Thu, 20 May 2010 12:10:26 +0200
Organization: ATLAS Elektronik GmbH
Message-ID: <4BF50A92.3060209@atlas-elektronik.com>
References: <ht3194$1vc$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 20 12:30:15 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OF313-0008BV-9c
	for gcvg-git-2@lo.gmane.org; Thu, 20 May 2010 12:30:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754434Ab0ETKaH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 May 2010 06:30:07 -0400
Received: from lxsrv96.atlas.de ([194.156.172.86]:51237 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751470Ab0ETKaF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 May 2010 06:30:05 -0400
X-Greylist: delayed 1091 seconds by postgrey-1.27 at vger.kernel.org; Thu, 20 May 2010 06:30:05 EDT
Received: from VSSRV01.atlas.de (vssrv01.atlas.de [10.200.101.18])
	by mail96.atlas.de (Postfix) with ESMTP id 1EAA9138B9
	for <git@vger.kernel.org>; Thu, 20 May 2010 12:11:51 +0200 (CEST)
X-AuditID: 0ac86512-00000e98000005bc-68-4bf50ae75cac
Received: from mgsrv01.atlas.de ([10.200.101.16]) by VSSRV01.atlas.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 20 May 2010 12:11:51 +0200
Received: from mgsrv01.atlas.de (localhost [127.0.0.1])
	by mail01-int.atlas.de (Postfix) with ESMTP id B6A262716A;
	Thu, 20 May 2010 12:11:50 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on mgsrv01.atlas.de
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=5.0 tests=ALL_TRUSTED,BAYES_50
	autolearn=disabled version=3.2.5
Received: from [141.200.42.243] (as106913.atlas.de [141.200.42.243])
	by mail01.atlas.de (Postfix) with ESMTP id A94B727169;
	Thu, 20 May 2010 12:11:50 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.8.1.14) Gecko/20080421 Lightning/0.8 Thunderbird/2.0.0.14 Mnenhy/0.7.5.0
In-Reply-To: <ht3194$1vc$1@dough.gmane.org>
X-Enigmail-Version: 1.0.1
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147378>

On 5/20/2010 12:01 PM, Andy Parkins wrote:
> Hello,
> 
> I've just upgraded from 1.6.something to 1.7.1.  All very nice.
> 
> The new submodule reporting is nice too; but I'd like to be able to turn it 
> off :-)
> 
> The problem is that I have a (relatively) small project as the supermodule, 
> and a linux kernel clone as a submodule and an ffmpeg clone as a submodule.  
> Now I used to be able to do git-status or git-diff and it would be instant, 
> it now takes a number of seconds to report.  I guess (but don't know), that 
> it is the detection of "dirty" status in the submodule's that is slowing 
> down the supermodule processing.
> 
> I wouldn't like to see the feature go, because in almost all circumstances 
> it is exactly right; however, I'd like to be able to turn off dirty 
> detection in submodules.  Is this already possible, and I've just missed the 
> configuration option?

Maybe:

   git config status.submodulesummary false

> One additional small point: why do untracked files in a submodule make the 
> module dirty?  I've often got a few "temp.ps" or "debug.log" or 
> "backtrace.log" files lying around -- inappropriate to add to an ignore 
> file, but they don't make my working directory dirty.  "Dirty" in a working 
> directory means uncommitted changes to tracked files, why does it mean 
> something different in a submodule?

That's IMHO a good point. I'd like to get an answer for that, too.

Regards,
  Stefan
-- 
----------------------------------------------------------------
/dev/random says: ... Clinton excuse #15: Hey - I just do what the wife says
