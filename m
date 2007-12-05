From: Federico Mena Quintero <federico@novell.com>
Subject: Re: Some git performance measurements..
Date: Tue, 04 Dec 2007 19:04:48 -0600
Message-ID: <1196816688.23870.2.camel@cacharro.xalalinux.org>
References: <alpine.LFD.0.9999.0711281747450.8458@woody.linux-foundation.org>
	 <alpine.LFD.0.9999.0711281852160.8458@woody.linux-foundation.org>
	 <alpine.LFD.0.99999.0711282244190.9605@xanadu.home>
	 <alpine.LFD.0.9999.0711282022470.8458@woody.linux-foundation.org>
	 <alpine.LFD.0.99999.0711291208060.9605@xanadu.home>
	 <finmvm$da8$1@ger.gmane.org>
	 <alpine.LFD.0.9999.0711291812530.8458@woody.linux-foundation.org>
	 <alpine.LFD.0.9999.0711291836230.8458@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, Nicolas Pitre <nico@cam.org>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Dec 05 02:30:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Izj5y-0005Z6-6U
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 02:30:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751055AbXLEBaR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Dec 2007 20:30:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750979AbXLEBaR
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Dec 2007 20:30:17 -0500
Received: from jericho.provo.novell.com ([137.65.248.124]:36628 "EHLO
	jericho.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750764AbXLEBaQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2007 20:30:16 -0500
X-Greylist: delayed 1219 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Dec 2007 20:30:15 EST
Received: from [164.99.195.6] ([164.99.195.6])
	by jericho.provo.novell.com with ESMTP; Tue, 04 Dec 2007 18:09:36 -0700
In-Reply-To: <alpine.LFD.0.9999.0711291836230.8458@woody.linux-foundation.org>
X-Mailer: Evolution 2.11.5 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67099>

On Thu, 2007-11-29 at 18:54 -0800, Linus Torvalds wrote:

> Jakub pointed out, the cold-cache numbers do fluctuate a lot, and while 

You may want to try iogrind:

http://live.gnome.org/iogrind

It's a valgrind skin to record I/O operations (including "implicit" ones
like touching mmap()ed pages), plus a graphical tool to visualize the
logs, similar to kcachegrind.

  Federico
