From: Nicolas Pitre <nico@cam.org>
Subject: Re: push to backup repo periodically fails with "not fast forward"
Date: Mon, 22 Dec 2008 13:27:32 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0812221326490.30035@xanadu.home>
References: <19016122-e19d-4885-8b0f-dec7b686c6ea@o4g2000pra.googlegroups.com>
 <94a0d4530812220911l37b825edj55178658f24755c1@mail.gmail.com>
 <f95d47890812220915h5286d2bdv7c8412ecf77be999@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: David Copeland <davetron5000@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 22 19:29:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEpWh-0001PI-Bs
	for gcvg-git-2@gmane.org; Mon, 22 Dec 2008 19:29:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbYLVS1x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2008 13:27:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751515AbYLVS1w
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Dec 2008 13:27:52 -0500
Received: from relais.videotron.ca ([24.201.245.36]:60259 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051AbYLVS1w (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2008 13:27:52 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KCA00DRFJ9WIJF0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 22 Dec 2008 13:27:32 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <f95d47890812220915h5286d2bdv7c8412ecf77be999@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103763>

On Mon, 22 Dec 2008, David Copeland wrote:

> the original gets rebased from a git svn rebase on occasion; so I
> guess that is causing things to not be fast-forward.
> 
> I guess all I really want to do is keep a duplicate copy of my repo
> somewhere else.  Should I just use --force in my hook, or abandon git
> as the mechanism and use rsync?

Using --force is definitively better than rsync.


Nicolas
