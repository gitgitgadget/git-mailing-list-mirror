From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] provide advance warning of some future pack default changes
Date: Fri, 14 Dec 2007 08:38:51 -0500 (EST)
Message-ID: <alpine.LFD.0.999999.0712140836140.8467@xanadu.home>
References: <7vk5nwu51x.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.0.99999.0712031258460.9605@xanadu.home>
 <7vsl2jh3rb.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.0.999999.0712132227090.8467@xanadu.home>
 <m3fxy5qwbq.fsf@roke.D-201>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 14 14:39:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3Al0-0008Er-A6
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 14:39:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227AbXLNNiw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2007 08:38:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750886AbXLNNiw
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 08:38:52 -0500
Received: from relais.videotron.ca ([24.201.245.36]:12033 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750804AbXLNNiw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 08:38:52 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JT1002NKKKRZG60@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 14 Dec 2007 08:38:51 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <m3fxy5qwbq.fsf@roke.D-201>
User-Agent: Alpine 0.999999 (LFD 847 2007-12-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68303>

On Fri, 14 Dec 2007, Jakub Narebski wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > + * From v1.5.5, the repack.usedeltabaseoffset config option will default
> > +   to true, which will give denser packfile (i.e. more efficient storage).
> > +   The downside is that git older than version 1.4.4 will not be able
> > +   to directly use a repository packed using this setting.
> > +
> > + * From v1.5.5, the pack.indexversion config option will default to 2,
> > +   which is slightly more efficient, and makes repacking more immune to
> > +   data corruptions.  Git older than version 1.5.2 may revert to version 1
> > +   of the pack index with a manual "git index-pack" to be able to directly
> > +   access corresponding pack files.
> 
> Which means what? Local clone with shortcut (hardlinking and remotes)?
> Dumb protocols (http, ftp, rsync)?

Right, or simply shared repo over NFS or the like.

The 1.5.5 release notes will contain a note reminding people to set the 
corresponding config variables if they wish to retain the legacy 
behaviors.


Nicolas
