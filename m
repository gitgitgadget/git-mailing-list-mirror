From: Nicolas Pitre <nico@cam.org>
Subject: Re: Curious about details of optimization of object database...
Date: Fri, 09 Jan 2009 13:34:03 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0901091330010.9524@xanadu.home>
References: <20090109174623.GC12552@seberino.org>
 <vpqzli01hzl.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: chris@seberino.org, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Jan 09 19:35:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLMCi-0006ny-0p
	for gcvg-git-2@gmane.org; Fri, 09 Jan 2009 19:35:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753077AbZAISeM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2009 13:34:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753018AbZAISeL
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 13:34:11 -0500
Received: from relais.videotron.ca ([24.201.245.36]:11226 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751939AbZAISeK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2009 13:34:10 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KD7001V5VKR3J80@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 09 Jan 2009 13:34:03 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <vpqzli01hzl.fsf@bauges.imag.fr>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105027>

On Fri, 9 Jan 2009, Matthieu Moy wrote:

> chris@seberino.org writes:
> 
> > I'm told a commit is *not* a patch (diff), but, rather a copy of the entire
> > tree.
> 
> Conceptually, yes. But obviously, the storage format (pack) does what
> people usually call "delta-compression", which is basically storing
> only the diff against another, similar object.

Also, since objects representing files and directories are named after 
their actual content, having two commits with identical files and 
directories will of course share the same blob and tree objects for 
those identical parts.


Nicolas
