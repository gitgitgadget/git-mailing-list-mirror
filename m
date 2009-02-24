From: Nicolas Pitre <nico@cam.org>
Subject: Re: GSoC 2009 Prospective student
Date: Tue, 24 Feb 2009 16:17:16 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0902241612510.5511@xanadu.home>
References: <a149495b0902221158h16d499f7w8bd18abaf1321e46@mail.gmail.com>
 <200902241638.08300.jnareb@gmail.com> <20090224155539.GU22848@spearce.org>
 <200902242208.14199.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Rohan Dhruva <rohandhruva@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 22:18:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lc4g1-0004UQ-6k
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 22:18:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752074AbZBXVRZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 16:17:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751893AbZBXVRY
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 16:17:24 -0500
Received: from relais.videotron.ca ([24.201.245.36]:17497 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751540AbZBXVRY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 16:17:24 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KFL00BLZ9SSVF30@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 24 Feb 2009 16:17:16 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <200902242208.14199.jnareb@gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111342>

On Tue, 24 Feb 2009, Jakub Narebski wrote:

> Well, this is _cache_. OTOH having pack cache would make it easy to have
> resumable clone if you hit one of cached packfiles on resume...
> 
> On the other hand I wonder what improvements it would give, as generating
> packs with delta reuse is, I think, quite fast...

Object enumeration is still an issue.  A cache would allow skipping that 
part as well, making cached packs about the same as a simple file 
server.


Nicolas
