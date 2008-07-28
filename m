From: David Brown <git@davidb.org>
Subject: Re: [PATCH] Make use of stat.ctime configurable
Date: Mon, 28 Jul 2008 09:04:46 -0700
Message-ID: <20080728160446.GA16351@old.davidb.org>
References: <7vr69lihkt.fsf@gitster.siamese.dyndns.org> <20080723164614.GB5283@blimp.local> <alpine.DEB.1.00.0807231757550.8986@racer> <20080723191647.GF5283@blimp.local> <alpine.LFD.1.10.0807241854580.5249@nehalem.linux-foundation.org> <20080725055547.GA3699@blimp.local> <alpine.DEB.1.00.0807260256030.11976@eeepc-johanness> <20080726153802.GA16868@blimp.local> <7v1w1f155p.fsf@gitster.siamese.dyndns.org> <20080728063128.GA4234@blimp.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 28 18:06:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNVEv-0003jP-A8
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 18:06:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752368AbYG1QFZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 12:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752214AbYG1QFZ
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 12:05:25 -0400
Received: from mail.davidb.org ([66.93.32.219]:57165 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752051AbYG1QFY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 12:05:24 -0400
Received: from davidb by mail.davidb.org with local (Exim 4.69 #1 (Debian))
	id 1KNVDK-0004Pu-71; Mon, 28 Jul 2008 09:04:46 -0700
Content-Disposition: inline
In-Reply-To: <20080728063128.GA4234@blimp.local>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90468>

On Mon, Jul 28, 2008 at 08:31:28AM +0200, Alex Riesen wrote:

>because there are situations where it produces too much false
>positives. Like when file system crawlers keep changing it when
>scanning and using the ctime for marking scanned files.

That's interesting, since most backup software uses the ctime to determine
file changes.

David
