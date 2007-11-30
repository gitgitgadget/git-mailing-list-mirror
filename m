From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Move all dashed form git commands to libexecdir
Date: Thu, 29 Nov 2007 20:01:16 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0711291959510.9605@xanadu.home>
References: <20071127160423.GA22807@laptop>
 <Pine.LNX.4.64.0711271617350.27959@racer.site>
 <20071128000731.GD9174@efreet.light.src>
 <7v8x4jb295.fsf@gitster.siamese.dyndns.org>
 <fcaeb9bf0711280036p33583824ge59af93bbe3f0a78@mail.gmail.com>
 <7vfxyq2c9b.fsf@gitster.siamese.dyndns.org>
 <20071129150849.GA32296@coredump.intra.peff.net>
 <fcaeb9bf0711291205h125dadbbp8e8ae392e9b5b751@mail.gmail.com>
 <20071129211409.GA16625@sigill.intra.peff.net>
 <Pine.LNX.4.64.0711292218240.27959@racer.site>
 <20071129231444.GA9616@coredump.intra.peff.net>
 <alpine.LFD.0.9999.0711291527090.8458@woody.linux-foundation.org>
 <7veje8twt2.fsf@gitster.siamese.dyndns.org> <474F5E90.9040505@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jan Hudec <bulb@ucw.cz>, git@vger.kernel.org
To: A Large Angry SCM <gitzilla@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 30 02:02:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxuGC-0001Ch-4W
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 02:01:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934333AbXK3BBS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 20:01:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934324AbXK3BBS
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 20:01:18 -0500
Received: from relais.videotron.ca ([24.201.245.36]:34015 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934322AbXK3BBR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2007 20:01:17 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JSA00BZ2O648I60@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 29 Nov 2007 20:01:16 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <474F5E90.9040505@gmail.com>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66589>

On Thu, 29 Nov 2007, A Large Angry SCM wrote:

> Again, there needs to remain support in the Makefile to install the "dashed"
> versions of the commands for those that want it; and be able to set
> gitexecdir=$(binder) without editing the Makefile.

Well, if you want a "non standard" installation, maybe you just can edit 
a line or two in the Makefile?


Nicolas
