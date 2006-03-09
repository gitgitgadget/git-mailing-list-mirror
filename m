From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add git-imap-send.
Date: Thu, 9 Mar 2006 14:47:00 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0603091445280.21440@wbgn013.biozentrum.uni-wuerzburg.de>
References: <440C3499.9080000@codeweavers.com> <7vacbz7vod.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0603091227560.20277@wbgn013.biozentrum.uni-wuerzburg.de>
 <4410140E.2000609@op5.se> <Pine.LNX.4.63.0603091243001.20908@wbgn013.biozentrum.uni-wuerzburg.de>
 <slrne10b8c.fr9.mdw@metalzone.distorted.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 09 14:47:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHLU4-0003Yv-0i
	for gcvg-git@gmane.org; Thu, 09 Mar 2006 14:47:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158AbWCINrF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Mar 2006 08:47:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932121AbWCINrF
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Mar 2006 08:47:05 -0500
Received: from wrzx35.rz.uni-wuerzburg.de ([132.187.3.35]:49871 "EHLO
	mailrelay.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932158AbWCINrE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Mar 2006 08:47:04 -0500
Received: from virusscan.mail (mail03.mail [172.25.1.102])
	by mailrelay.mail (Postfix) with ESMTP id CAB1A1284;
	Thu,  9 Mar 2006 14:47:00 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id BE3B4AFA;
	Thu,  9 Mar 2006 14:47:00 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id A24FDAE7;
	Thu,  9 Mar 2006 14:47:00 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Mark Wooding <mdw@distorted.org.uk>
In-Reply-To: <slrne10b8c.fr9.mdw@metalzone.distorted.org.uk>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17416>

Hi,

On Thu, 9 Mar 2006, Mark Wooding wrote:

> There are reasons for which it'd be desirable that memcmp really compare
> all the bytes, even if it can in theory stop early: in particular, there
> are cases where early exit can leak timing information which makes it
> possible to attack cryptographic protocols.

I would be astonished if memcmp has to be timing proof for *all* 
applications, just to keep crypto people happy. I don't *want* a slow-down 
in my super-duper 3d shooter.

> I'd have to recommend strncmp for this job.

Fully agree.

Ciao,
Dscho
