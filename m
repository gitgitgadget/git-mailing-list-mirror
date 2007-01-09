From: Paul Jackson <pj@sgi.com>
Subject: Re: How git affects kernel.org performance
Date: Mon, 8 Jan 2007 17:09:34 -0800
Organization: SGI
Message-ID: <20070108170934.dafc5b81.pj@sgi.com>
References: <1166297434.26330.34.camel@localhost.localdomain>
	<1166304080.13548.8.camel@nigel.suspend2.net>
	<459152B1.9040106@zytor.com>
	<1168140954.2153.1.camel@nigel.suspend2.net>
	<45A08269.4050504@zytor.com>
	<45A083F2.5000000@zytor.com>
	<Pine.LNX.4.64.0701062130260.3661@woody.osdl.org>
	<20070107085526.GR24090@1wt.eu>
	<20070107011542.3496bc76.akpm@osdl.org>
	<20070108030555.GA7289@in.ibm.com>
	<20070108125819.GA32756@thunk.org>
	<45A24A65.1070706@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: tytso@mit.edu, suparna@in.ibm.com, akpm@osdl.org, w@1wt.eu,
	torvalds@osdl.org, hpa@zytor.com, git@vger.kernel.org,
	nigel@nigel.suspend2.net, warthog9@kernel.org,
	randy.dunlap@oracle.com, pavel@ucw.cz,
	linux-kernel@vger.kernel.org, webmaster@kernel.org,
	linux-ext4@vger.kernel.org
X-From: linux-ext4-owner@vger.kernel.org Tue Jan 09 02:11:56 2007
Return-path: <linux-ext4-owner@vger.kernel.org>
Envelope-to: gcfe-linux-ext4@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H45Ws-00046N-W9
	for gcfe-linux-ext4@gmane.org; Tue, 09 Jan 2007 02:11:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750866AbXAIBLx (ORCPT <rfc822;gcfe-linux-ext4@m.gmane.org>);
	Mon, 8 Jan 2007 20:11:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750861AbXAIBLx
	(ORCPT <rfc822;linux-ext4-outgoing>); Mon, 8 Jan 2007 20:11:53 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:48068 "EHLO omx1.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750857AbXAIBLw (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
	Mon, 8 Jan 2007 20:11:52 -0500
Received: from imr2.americas.sgi.com (imr2.americas.sgi.com [198.149.16.18])
	by omx1.sgi.com (8.12.10/8.12.9/linux-outbound_gateway-1.1) with ESMTP id l0919bDW012143;
	Mon, 8 Jan 2007 19:09:37 -0600
Received: from v0 (mtv-vpn-hw-masa-1.corp.sgi.com [134.15.25.210])
	by imr2.americas.sgi.com (8.12.9/8.12.10/SGI_generic_relay-1.2) with SMTP id l090hknc76600547;
	Mon, 8 Jan 2007 16:43:46 -0800 (PST)
To: Jeff Garzik <jeff@garzik.org>
In-Reply-To: <45A24A65.1070706@garzik.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36293>

Jeff wrote:
> Something I just thought of:  ATA and SCSI hard disks do their own
> read-ahead.

Probably this is wishful thinking on my part, but I would have hoped
that most of the read-ahead they did was for stuff that happened to be
on the cylinder they were reading anyway.  So long as their read-ahead
doesn't cause much extra or delayed disk head motion, what does it
matter?

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
