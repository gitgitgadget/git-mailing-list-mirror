From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: calculating a git packfile sha1 checksum in java
Date: Tue, 22 Mar 2011 17:10:26 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1103221708370.11889@xanadu.home>
References: <1300786044816-6195501.post@n2.nabble.com>
 <AANLkTimWt4P3qtR3b6YfRJ=Tx69EL+9+oXhD_2c9O6JX@mail.gmail.com>
 <AANLkTiniKOzzwZhJ5GN4nf8AWRTsT6bbMeK4s5XqvH42@mail.gmail.com>
 <1300827506173-6197923.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: madmarcos <fru574@my.utsa.edu>
X-From: git-owner@vger.kernel.org Tue Mar 22 22:10:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q28qX-0000HQ-B9
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 22:10:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288Ab1CVVK2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2011 17:10:28 -0400
Received: from relais.videotron.ca ([24.201.245.36]:58008 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932216Ab1CVVK1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2011 17:10:27 -0400
Received: from xanadu.home ([66.130.28.92]) by vl-mh-mrz21.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LIH00L0V9GLGRA0@vl-mh-mrz21.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 22 Mar 2011 17:09:57 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <1300827506173-6197923.post@n2.nabble.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169776>

On Tue, 22 Mar 2011, madmarcos wrote:

> Hi Shawn,
> Thanks for the response!
> I looked at the JGit API. will it allow me to read a packfile, alter its
> contents, and repack it?

Why would you want to do that?  Altering a pack file in place is not a 
trivial affair.  There is also the corresponding pack index which has to 
be rebuilt, etc.


Nicolas
