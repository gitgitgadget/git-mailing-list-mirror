From: Nicolas Pitre <nico@cam.org>
Subject: Re: Why repository grows after "git gc"? / Purpose of *.keep files?
Date: Mon, 12 May 2008 17:06:08 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0805121704140.23581@xanadu.home>
References: <20080512122900.GA13050@mithlond.arda.local>
 <20080512155243.GA3592@mithlond.arda.local>
 <alpine.DEB.1.00.0805121810501.30431@racer>
 <20080512184334.GB5160@mithlond.arda.local>
 <alpine.LFD.1.10.0805121453250.23581@xanadu.home>
 <20080512190946.GC5160@mithlond.arda.local>
 <alpine.LFD.1.10.0805121527550.23581@xanadu.home>
 <5d46db230805121310q5a0c6037p769ea091c26284d0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Teemu Likonen <tlikonen@iki.fi>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Govind Salinas <govind@sophiasuchtig.com>
X-From: git-owner@vger.kernel.org Mon May 12 23:07:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvfEc-0001uT-Jg
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 23:07:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755379AbYELVGM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 17:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753916AbYELVGM
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 17:06:12 -0400
Received: from relais.videotron.ca ([24.201.245.36]:8237 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753224AbYELVGM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 17:06:12 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K0R002JTX9QRB80@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 12 May 2008 17:05:52 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <5d46db230805121310q5a0c6037p769ea091c26284d0@mail.gmail.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81950>

On Mon, 12 May 2008, Govind Salinas wrote:

> On Mon, May 12, 2008 at 2:36 PM, Nicolas Pitre <nico@cam.org> wrote:
> >  Sure.  But to decide to track only one branch and exclude the others
> >  require some higher level of git knowledge already.  At that point if
> >  you really care about top packing performances you certainly can deal
> >  with the .keep file as well.
> 
> I have had some similar problems with .keep files.  I cloned a repo I
> created that had a branch that I wasn't interested in.  I deleted the
> branch and then I could never get rid of the (large) number of objects
> in that pack until I deleted the .keep and repacked.

But as soon as you just "git pull" you'll get the deleted branch back.


Nicolas
