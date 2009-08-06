From: Steffen Siebert <git@steffensiebert.de>
Subject: Re: Merging to and from non-current branches.
Date: Thu, 6 Aug 2009 11:54:30 +0000 (UTC)
Message-ID: <loom.20090806T115042-526@post.gmane.org>
References: <D5200130-C7D7-4010-BF62-3A3374F2E3B0@mgreg.com> <alpine.LNX.2.00.0908042236240.2147@iabervon.org> <518952FC-626C-43FB-BD53-98DE849C9751@mgreg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 06 14:15:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZ1sN-00048n-6B
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 14:15:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755194AbZHFMPF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 08:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754917AbZHFMPF
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 08:15:05 -0400
Received: from main.gmane.org ([80.91.229.2]:38210 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752836AbZHFMPE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 08:15:04 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1MZ1s6-0004R1-Ug
	for git@vger.kernel.org; Thu, 06 Aug 2009 12:15:02 +0000
Received: from 217.111.33.226 ([217.111.33.226])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 06 Aug 2009 12:15:02 +0000
Received: from git by 217.111.33.226 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 06 Aug 2009 12:15:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 217.111.33.226 (Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.0.13) Gecko/2009073022 Firefox/3.0.13 (.NET CLR 3.5.30729))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125064>

lists <at> mgreg.com <lists <at> mgreg.com> writes:

> a single command to intuitively handle it.  I've been doing a great  
> deal of incremental development lately and it becomes rather tedious  
> to have to checkout master, merge dev, re-checkout dev and proceed.   
> I'm not sure why this isn't currently possible with a single command.   
> I suppose I could write a shell script to do so, but that's a little  
> less "native" than I'd like.

Hi Michael,

I had a similar problem (we are doing rebases instead of merges) and found a way
to rebase and push my changes onto the master without the need of a "checkout
master".

You can find my question and the approved (green) answer that works for me on
stackoverflow.com:

http://stackoverflow.com/questions/945372/how-to-efficiently-rebase-and-push-a-local-git-branch

Maybe this works for you, too.

Ciao,
  Steffen
