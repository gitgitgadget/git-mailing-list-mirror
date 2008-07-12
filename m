From: Stephan Hennig <mailing_list@arcor.de>
Subject: Re: git pull is slow
Date: Sat, 12 Jul 2008 14:32:02 +0200
Message-ID: <4878A442.6020405@arcor.de>
References: <g5570s$d5m$1@ger.gmane.org> <g57jkp$ekm$1@ger.gmane.org> <48776169.20705@op5.se> <alpine.DEB.1.00.0807111443280.8950@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andreas Ericsson <ae@op5.se>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 12 14:34:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHeJE-0005w6-5d
	for gcvg-git-2@gmane.org; Sat, 12 Jul 2008 14:34:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752704AbYGLMdm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jul 2008 08:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752645AbYGLMdm
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jul 2008 08:33:42 -0400
Received: from main.gmane.org ([80.91.229.2]:38094 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752573AbYGLMdl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jul 2008 08:33:41 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KHeIF-0004F8-OP
	for git@vger.kernel.org; Sat, 12 Jul 2008 12:33:39 +0000
Received: from dialin-145-254-068-189.pools.arcor-ip.net ([145.254.68.189])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 12 Jul 2008 12:33:39 +0000
Received: from mailing_list by dialin-145-254-068-189.pools.arcor-ip.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 12 Jul 2008 12:33:39 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: dialin-145-254-068-189.pools.arcor-ip.net
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12
In-Reply-To: <alpine.DEB.1.00.0807111443280.8950@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88237>

Hi,

Johannes Schindelin schrieb:
> On Fri, 11 Jul 2008, Andreas Ericsson wrote:
> 
>> Seems like you're being bitten by a bug we had some months back,
>> where the client requested full history for new tag objects.
> 
> I do not think so.  I think it is a problem with the pack.  The slowness 
> is already there in the clone, in the resolving phase.

Thanks for having a look at this!  What does "problem with the pack"
mean?  Do you think it is a Git problem (client or server side?) or just
a misconfiguration?

Best regards,
Stephan Hennig
