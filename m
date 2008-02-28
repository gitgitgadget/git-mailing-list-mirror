From: Jeff Garzik <jeff@garzik.org>
Subject: Re: 'git gc' always run, on old kernel repo?
Date: Thu, 28 Feb 2008 15:45:25 -0500
Message-ID: <47C71D65.7020308@garzik.org>
References: <47C71233.4050705@garzik.org> <47C715EB.3060303@garzik.org> <alpine.LFD.1.00.0802281533190.4911@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1763829AbYB1Upm@vger.kernel.org Thu Feb 28 21:46:30 2008
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1763829AbYB1Upm@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUpdx-0000Yz-FS
	for glk-linux-kernel-3@gmane.org; Thu, 28 Feb 2008 21:46:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763829AbYB1Upm (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Thu, 28 Feb 2008 15:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760729AbYB1Up2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Feb 2008 15:45:28 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:50858 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760097AbYB1Up1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Feb 2008 15:45:27 -0500
Received: from cpe-069-134-071-233.nc.res.rr.com ([69.134.71.233] helo=core.yyz.us)
	by mail.dvmed.net with esmtpsa (Exim 4.66 #1 (Red Hat Linux))
	id 1JUpd8-0007HS-CV; Thu, 28 Feb 2008 20:45:26 +0000
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <alpine.LFD.1.00.0802281533190.4911@xanadu.home>
X-Spam-Score: -4.4 (----)
X-Spam-Report: SpamAssassin version 3.2.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.4 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75450>

Nicolas Pitre wrote:
> On Thu, 28 Feb 2008, Jeff Garzik wrote:
> 
>>> warning: There are too many unreachable loose objects; run 'git prune' to
>>> remove them.
>> Will the 'git gc' never end???
> 
> What happens if you try to run "git prune"?

Same behavior.

FWIW I run "git prune" immediately prior to "git push", _every_ time I 
push to master.kernel.org (git.kernel.org).

	Jeff
