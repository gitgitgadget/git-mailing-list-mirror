From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [ANNOUNCE] GIT 1.6.4.rc1
Date: Thu, 16 Jul 2009 02:45:39 -0400
Message-ID: <4A5ECC93.1050602@garzik.org>
References: <7vmy75bg2f.fsf@alter.siamese.dyndns.org> <4A5EA598.5050801@garzik.org> <7v3a8xb0lz.fsf@alter.siamese.dyndns.org> <4A5ECC09.3010405@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756904AbZGPGrX@vger.kernel.org Thu Jul 16 08:48:06 2009
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756904AbZGPGrX@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRKlB-0007wr-BK
	for glk-linux-kernel-3@gmane.org; Thu, 16 Jul 2009 08:48:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756904AbZGPGrX (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Thu, 16 Jul 2009 02:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752037AbZGPGrW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jul 2009 02:47:22 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:55187 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751932AbZGPGrW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jul 2009 02:47:22 -0400
Received: from cpe-069-134-158-197.nc.res.rr.com ([69.134.158.197] helo=bd.yyz.us)
	by mail.dvmed.net with esmtpsa (Exim 4.69 #1 (Red Hat Linux))
	id 1MRKkT-0006gJ-2n; Thu, 16 Jul 2009 06:47:21 +0000
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <4A5ECC09.3010405@garzik.org>
X-Spam-Score: -4.4 (----)
X-Spam-Report: SpamAssassin version 3.2.5 on srv5.dvmed.net summary:
	Content analysis details:   (-4.4 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123368>

Jeff Garzik wrote:
> I want to publish this tree to the world via a *.kernel.org-like system, 
> so my task is to
> 
>     scp -r /spare/repo/cld/.git remote.example.com:/pub/scm/cld.git
> 
> but if I do this with scp, then future pushes to 
> remote.example.com:/pub/scm/cld.git emit the warning about updating the 
> currently checked-out branch -- even though there are no checked-out 
> files.  The checked-out files were not copied in the scp.

IOW -- do I just edit the config for this case too, or is there some 
'git clone --bare' magic that can work across ssh, as shown above?

It is easy to clone -from- a remote, but not so easy to clone -to- a 
new, bare remote.

	Jeff
