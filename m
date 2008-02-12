From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 2/2] pack-objects: Default to zero threads,
 meaning auto-assign to #cpus
Date: Mon, 11 Feb 2008 23:57:52 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0802112352380.2732@xanadu.home>
References: <47B01FE7.8010207@op5.se>
 <1202784078-23700-1-git-send-email-casey@nrlssc.navy.mil>
 <47B10B7D.2030702@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: ae@op5.se, Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue Feb 12 05:58:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOnEF-0002jc-G0
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 05:58:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbYBLE5y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 23:57:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbYBLE5y
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 23:57:54 -0500
Received: from relais.videotron.ca ([24.201.245.36]:32876 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751135AbYBLE5x (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 23:57:53 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JW4009YG0GG2QE0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 11 Feb 2008 23:57:53 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <47B10B7D.2030702@nrlssc.navy.mil>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73626>

On Mon, 11 Feb 2008, Brandon Casey wrote:

> Additionally, update some tests for which the multi-threaded result
> differs from the single-threaded result and the single-threaded
> result is expected.
> 
> Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>

I think the first patch is OK, but having the _default_ be 
multi-threaded is going a bit too far.  IMHO you should document the 
meaning of the value 0, and compile with thread support whenever Posix 
threads are available, but activating threads should be done explicitly.


Nicolas
