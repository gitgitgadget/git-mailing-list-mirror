From: Nicolas Pitre <nico@cam.org>
Subject: Re: Why repository grows after "git gc"? / Purpose of *.keep files?
Date: Mon, 12 May 2008 14:56:28 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0805121453250.23581@xanadu.home>
References: <20080512122900.GA13050@mithlond.arda.local>
 <20080512155243.GA3592@mithlond.arda.local>
 <alpine.DEB.1.00.0805121810501.30431@racer>
 <20080512184334.GB5160@mithlond.arda.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Mon May 12 20:57:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvdD6-0002X6-He
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 20:57:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753697AbYELS4b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 14:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753918AbYELS4b
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 14:56:31 -0400
Received: from relais.videotron.ca ([24.201.245.36]:43375 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753677AbYELS4a (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 14:56:30 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K0R008UOR9LONL0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 12 May 2008 14:56:11 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20080512184334.GB5160@mithlond.arda.local>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81906>

On Mon, 12 May 2008, Teemu Likonen wrote:

> Well, I don't really have any problems with the current behaviour; it
> just feels a bit strange that, for example, Linus's kernel repository
> grew about 90MB after just one update pull and gc.

That looks really odd.  Sure the repo might grow a bit, but 90MB seems 
really excessive.  How many time did pass between the initial clone and 
that subsequent pull?

> Also, dangling
> objects are kept forever in .keep packs (which are created with "git
> clone", for example).

A pack obtained via 'git clone' will never contain any dangling objects.


Nicolas
