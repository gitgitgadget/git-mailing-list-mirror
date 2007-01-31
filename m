From: Nicolas Pitre <nico@cam.org>
Subject: Re: newbie questions about git design and features (some wrt hg)
Date: Wed, 31 Jan 2007 10:03:27 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0701310959220.3021@xanadu.home>
References: <3c6c07c20701300820l42cfc8dbsb80393fc1469f667@mail.gmail.com>
 <7v8xfkz8oj.fsf@assigned-by-dhcp.cox.net>
 <3c6c07c20701301938u4d1503a2m3e0af51121b8e6db@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Mike Coleman <tutufan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 31 16:04:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCH04-0001x4-Iy
	for gcvg-git@gmane.org; Wed, 31 Jan 2007 16:03:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933326AbXAaPDk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Jan 2007 10:03:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933333AbXAaPDk
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 10:03:40 -0500
Received: from relais.videotron.ca ([24.201.245.36]:8328 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933326AbXAaPDj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jan 2007 10:03:39 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JCQ00ERUN5RQV40@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 31 Jan 2007 10:03:27 -0500 (EST)
In-reply-to: <3c6c07c20701301938u4d1503a2m3e0af51121b8e6db@mail.gmail.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38255>

On Tue, 30 Jan 2007, Mike Coleman wrote:

> As for performance, my thinking was that since hg is implemented
> apparently almost entirely in Python, and has (again apparently)
> generally acceptable performance, this suggested that much of the
> problem might be I/O-bound enough that language efficiency might not
> matter so much.

Matt Mackall said himself that some core portion of hg have been 
rewritten in C in order to improve performances.


Nicolas
