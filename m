From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: How to unpack recent objects?
Date: Thu, 16 Dec 2010 16:19:01 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1012161616170.10437@xanadu.home>
References: <4D0A77A7.9080702@cfl.rr.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Phillip Susi <psusi@cfl.rr.com>
X-From: git-owner@vger.kernel.org Thu Dec 16 22:19:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTLEE-0006YL-Ax
	for gcvg-git-2@lo.gmane.org; Thu, 16 Dec 2010 22:19:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757019Ab0LPVTF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Dec 2010 16:19:05 -0500
Received: from relais.videotron.ca ([24.201.245.36]:60137 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754895Ab0LPVTC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Dec 2010 16:19:02 -0500
Received: from xanadu.home ([66.130.28.92]) by vl-mh-mrz25.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LDJ00GM4HUP19A0@vl-mh-mrz25.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 16 Dec 2010 16:18:25 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <4D0A77A7.9080702@cfl.rr.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163814>

On Thu, 16 Dec 2010, Phillip Susi wrote:

> It looks like you can use git-unpack-objects to unpack ALL objects, but
> how can you unpack only recent ones that you are likely to use while
> leaving the ancient stuff packed?  Ideally I want to unpack all file
> objects from the current commit, and a reasonable number of commit
> objects going back into the history so accessing them with checkout,
> diff, log, etc will be fast.

What makes you think that unpacking them will actually make the access 
to them faster?  Instead, you should consider _repacking_ them, 
ultimately using the --aggressive parameter with the gc command, if you 
want faster accesses.


Nicolas
