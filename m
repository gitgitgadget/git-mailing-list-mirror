From: Nicolas Pitre <nico@cam.org>
Subject: Re: Sort of a feature proposal
Date: Wed, 07 May 2008 11:41:12 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0805071139010.23581@xanadu.home>
References: <86fxsutbke.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed May 07 17:43:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jtln4-000395-2L
	for gcvg-git-2@gmane.org; Wed, 07 May 2008 17:42:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762982AbYEGPlS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2008 11:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759362AbYEGPlR
	(ORCPT <rfc822;git-outgoing>); Wed, 7 May 2008 11:41:17 -0400
Received: from relais.videotron.ca ([24.201.245.36]:20490 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759465AbYEGPlP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2008 11:41:15 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K0I00BO88WOL9J0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 07 May 2008 11:41:13 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <86fxsutbke.fsf@lola.quinscape.zz>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81453>

On Wed, 7 May 2008, David Kastrup wrote:

> 
> Hi, I have some large git repositories on a USB drive (ext3 file
> system).  That means that when replugging the drive, the recorded st_dev
> data in the index is off, meaning that the whole repo directory
> structure gets reread as the stat data of all directories has changed.
> 
> That's a nuisance.  Can't we have some heuristic or configuration option
> where we, say, record the st_dev of the _index_ file, and if that has
> changed, we propagate that change to the st_dev of its contents?  I'd
> like to see something that works more efficiently than rescanning the
> whole disk every time I hibernate my computer.

Maybe simply ignoring st_dev is the solution?  I hardly can see what 
value it had to the other stat fields.


Nicolas
