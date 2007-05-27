From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 1/3] Lazily open pack index files on demand
Date: Sun, 27 May 2007 11:29:17 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0705271127110.3366@xanadu.home>
References: <20070526052419.GA11957@spearce.org>
 <7vabvsm1h8.fsf@assigned-by-dhcp.cox.net>
 <56b7f5510705261031o311b89bapd730374cbc063931@mail.gmail.com>
 <20070527033429.GY28023@spearce.org>
 <56b7f5510705262140rea5e1e5r49bdd5e99c466daa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 27 17:29:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsKgU-0001Jm-0Y
	for gcvg-git@gmane.org; Sun, 27 May 2007 17:29:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753992AbXE0P3Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 May 2007 11:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754093AbXE0P3Y
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 11:29:24 -0400
Received: from relais.videotron.ca ([24.201.245.36]:19960 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753992AbXE0P3Y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2007 11:29:24 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JIP007AUHOTWHA0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 27 May 2007 11:29:17 -0400 (EDT)
In-reply-to: <56b7f5510705262140rea5e1e5r49bdd5e99c466daa@mail.gmail.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48561>

On Sat, 26 May 2007, Dana How wrote:

> On 5/26/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> > In pack v4 we're likely to move the SHA-1 table from the .idx file
> > into the front of the .pack file.  This makes the .idx file hold
> > only the offsets and the CRC checkums of each object.  If we start
> > making a super index, we have to duplicate the SHA-1 table twice
> > (once in the .pack, again in the super index).
> Hmm, hopefully the SHA-1 table can go at the _end_
> since with split packs that's the only time we know the number
> of objects in the pack... ;-)

Hmmm good point to consider.


Nicolas
