From: Nicolas Pitre <nico@cam.org>
Subject: Re: recent change in git.git/master broke my repos
Date: Thu, 25 Oct 2007 13:46:04 -0400 (EDT)
Message-ID: <alpine.LFD.0.9999.0710251344220.22100@xanadu.home>
References: <86oden6z97.fsf@blue.stonehenge.com>
 <20071025150107.GB31196@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_cJ7ONRU/Mx3Uu12/5iyPTA)"
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
To: =?ISO-8859-15?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu Oct 25 19:46:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Il6nJ-0002x7-Ma
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 19:46:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751878AbXJYRqH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 13:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751935AbXJYRqG
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 13:46:06 -0400
Received: from relais.videotron.ca ([24.201.245.36]:32695 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751564AbXJYRqG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 13:46:06 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JQH00GQ7AOS94V0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 25 Oct 2007 13:46:04 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20071025150107.GB31196@diana.vm.bytemark.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62338>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_cJ7ONRU/Mx3Uu12/5iyPTA)
Content-type: TEXT/PLAIN; charset=iso-8859-1
Content-transfer-encoding: 8BIT

On Thu, 25 Oct 2007, Karl Hasselström wrote:

> On 2007-10-25 07:32:36 -0700, Randal L. Schwartz wrote:
> 
> > And when are we gonna get "fast forward only" for git-merge?
> 
> I'd like that too. For cases when I know I don't have to do a merge,
> and want git to yell at me if I'm mistaken. For example, in a
> repository that tracks an upstream so I can build the latest version,
> but where I don't normally do any development.

Isn't that called a remote branch that gets updated with "git fetch' ?
You can even trick Git into not using the refs/remotes/ namespace for 
them if you wish.


Nicolas

--Boundary_(ID_cJ7ONRU/Mx3Uu12/5iyPTA)--
