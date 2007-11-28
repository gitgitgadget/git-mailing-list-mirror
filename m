From: Jonathan del Strother <maillist@steelskies.com>
Subject: Re: [PATCH v2] Teach 'git pull' about --rebase
Date: Wed, 28 Nov 2007 13:15:10 +0000
Message-ID: <D7B369D7-B690-4F5B-852F-4EC4B03CEB45@steelskies.com>
References: <Pine.LNX.4.64.0710252351130.4362@racer.site> <alpine.LFD.0.999.0710251602160.30120@woody.linux-foundation.org> <Pine.LNX.4.64.0710260007450.4362@racer.site> <7v3avy21il.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0710261047450.4362@racer.site> <7v3aurcjpq.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711281307420.27959@racer.site>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 28 14:15:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxMlM-0000IK-JU
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 14:15:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756627AbXK1NPR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 08:15:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755190AbXK1NPR
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 08:15:17 -0500
Received: from juliet.asmallorange.com ([207.210.105.70]:34048 "EHLO
	juliet.asmallorange.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756627AbXK1NPP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 08:15:15 -0500
Received: from [89.105.122.147] (port=55128 helo=gir.office.bestbefore.tv)
	by juliet.asmallorange.com with esmtpa (Exim 4.68)
	(envelope-from <maillist@steelskies.com>)
	id 1IxMl0-0007ew-DK; Wed, 28 Nov 2007 08:15:15 -0500
In-Reply-To: <Pine.LNX.4.64.0711281307420.27959@racer.site>
X-Mailer: Apple Mail (2.915)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - juliet.asmallorange.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - steelskies.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66321>

On 28 Nov 2007, at 13:11, Johannes Schindelin wrote:

> When calling 'git pull' with the '--rebase' option, it performs a
> fetch + rebase instead of a fetch + pull.
>
> This behavior is more desirable than fetch + pull when a topic branch
> is ready to be submitted and needs to be update.

Don't you mean fetch + merge ?
