From: Nicolas Pitre <nico@cam.org>
Subject: Re: [WIP] Shift rev-list enumeration from upload-pack to pack-objects
Date: Sun, 07 Jun 2009 20:50:24 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0906072043400.3906@xanadu.home>
References: <20090605054500.06A9D21C3F4@mail.utsl.gen.nz>
 <alpine.LFD.2.00.0906051224510.3906@xanadu.home>
 <c77435a80906070625i4daaa69bi134df765d7a77cdf@mail.gmail.com>
 <alpine.LFD.2.00.0906071225060.3906@xanadu.home>
 <c77435a80906070947u9bf8ce9m9d59f86e5a5f18ab@mail.gmail.com>
 <c77435a80906071155g5530ccdel286907b7c6022838@mail.gmail.com>
 <alpine.LFD.2.00.0906071637530.3906@xanadu.home>
 <c77435a80906071504u16a46e03w6dfde9a3e694a5ec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: sam@vilain.net, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>,
	Jeff King <peff@peff.net>
To: Nick Edelen <sirnot@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 02:51:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDT5H-0007Ja-Rm
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 02:51:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753323AbZFHAu3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jun 2009 20:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753317AbZFHAu2
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jun 2009 20:50:28 -0400
Received: from relais.videotron.ca ([24.201.245.36]:45408 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752968AbZFHAu2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jun 2009 20:50:28 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KKW00F5AAA1FZQ0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 07 Jun 2009 20:49:13 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <c77435a80906071504u16a46e03w6dfde9a3e694a5ec@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121026>

On Mon, 8 Jun 2009, Nick Edelen wrote:

> man I can sure be blind at times...  alright fixed the latter two
> comments.  I changed the test file because that particular test wanted
> upload-pack to fail through the revision walker, which it could only
> now do if shallow objects were involved.

OK.  However, since now we have 2 different paths for creating object 
list instead of only one (the existing one in upload-pack and the one in 
pack-objects), I'd prefer if you could add another test case to make 
sure the pack-objects path also fails appropriately.

The rest looks fine to me, and with the test issue fixed you could add 
my:

  Acked-by: Nicolas Pitre <nico@cam.org

to your next submission.  Oh and you might change the subject prefix to 
[PATCH] as well since I think this won't be WIP anymore.


Nicolas
