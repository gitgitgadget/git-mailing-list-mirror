From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: More on git over HTTP POST
Date: Sat, 2 Aug 2008 23:00:41 +0200 (CEST)
Message-ID: <alpine.LRH.1.10.0808022257470.25900@yvahk3.pbagnpgbe.fr>
References: <48938539.9060003@zytor.com> <20080802205702.GA24723@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Aug 02 23:04:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPOH0-0008IF-AW
	for gcvg-git-2@gmane.org; Sat, 02 Aug 2008 23:04:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751496AbYHBVDW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Aug 2008 17:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751494AbYHBVDV
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Aug 2008 17:03:21 -0400
Received: from kluster1.contactor.se ([91.191.140.11]:35139 "EHLO
	kluster1.contactor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751476AbYHBVDV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Aug 2008 17:03:21 -0400
Received: from linux3.contactor.se (linux3.contactor.se [91.191.140.23])
	by kluster1.contactor.se (8.13.8/8.13.8/Debian-3) with ESMTP id m72L3GpU011994;
	Sat, 2 Aug 2008 23:03:16 +0200
X-X-Sender: dast@linux3.contactor.se
In-Reply-To: <20080802205702.GA24723@spearce.org>
User-Agent: Alpine 1.10 (LRH 962 2008-03-14)
X-fromdanielhimself: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91179>

On Sat, 2 Aug 2008, Shawn O. Pearce wrote:

> Well, over git:// (or any protocol that wraps git:// like ssh) we assume a 
> full-duplex channel.  Some proxy systems are able to do such a channel. 
> HTTP however does not offer it.

Yes it does. The CONNECT method is used to get a full-duplex channel to a 
remote site through a HTTP proxy. The downside with that is of course that 
most proxies are setup to disallow CONNECT to other ports than 443 (the https 
default port).

-- 

  / daniel.haxx.se
