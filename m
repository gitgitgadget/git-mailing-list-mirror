From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Add pack.depth option to git-pack-objects and change
 default depth to 50
Date: Tue, 08 May 2007 11:38:46 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0705081136050.24220@xanadu.home>
References: <7vr6ps3oyk.fsf@assigned-by-dhcp.cox.net>
 <11786309073709-git-send-email-tytso@mit.edu>
 <11786309072612-git-send-email-tytso@mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Tue May 08 17:49:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlRwY-0000Iz-OP
	for gcvg-git@gmane.org; Tue, 08 May 2007 17:49:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934590AbXEHPpx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 11:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755575AbXEHPpo
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 11:45:44 -0400
Received: from relais.videotron.ca ([24.201.245.36]:44702 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755034AbXEHPix (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 11:38:53 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JHQ0074GBGMFYE0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 08 May 2007 11:38:46 -0400 (EDT)
In-reply-to: <11786309072612-git-send-email-tytso@mit.edu>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46593>

On Tue, 8 May 2007, Theodore Ts'o wrote:

> Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>

I'd prefer if tests were performed on the performance impact before 
changing the default depth.  If done separately from this patch then the 
commit log could contain those results as well.


Nicolas
