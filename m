From: Nicolas Pitre <nico@cam.org>
Subject: Re: [RFE] allow git bisect to figure out in which revision a bug was
 fixed
Date: Tue, 21 Jul 2009 21:20:24 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0907212118550.30629@xanadu.home>
References: <x49ocrdokp9.fsf@segfault.boston.devel.redhat.com>
 <7vfxcpdbsh.fsf@alter.siamese.dyndns.org>
 <20090721202848.GA3453@localhost.localdomain>
 <7vprbtbwhu.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.0907212030180.30629@xanadu.home>
 <7v4ot5zfqe.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Josef Bacik <josef@redhat.com>, Jeff Moyer <jmoyer@redhat.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 22 03:20:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTQVr-0005S6-N7
	for gcvg-git-2@gmane.org; Wed, 22 Jul 2009 03:20:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752802AbZGVBUs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2009 21:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752455AbZGVBUr
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jul 2009 21:20:47 -0400
Received: from relais.videotron.ca ([24.201.245.36]:42085 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002AbZGVBUr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2009 21:20:47 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KN500A6WT20ANF0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 21 Jul 2009 21:20:24 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <7v4ot5zfqe.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123729>

On Tue, 21 Jul 2009, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > Why not simply automatically inverting the meaning of good and
> > bad based on which commit is the ancestor of the other initially?
> 
> Because neither may be an ancestor of the other?

In most cases it has to be, no?


Nicolas
