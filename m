From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] RFC: git lazy clone proof-of-concept
Date: Fri, 08 Feb 2008 13:03:49 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0802081250240.2732@xanadu.home>
References: <200802081828.43849.kendy@suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jan Holesovsky <kendy@suse.cz>
X-From: git-owner@vger.kernel.org Fri Feb 08 19:05:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNXbi-0004cQ-4S
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 19:05:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933019AbYBHSDz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 13:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965106AbYBHSDy
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 13:03:54 -0500
Received: from relais.videotron.ca ([24.201.245.36]:27471 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933968AbYBHSDw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 13:03:52 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JVX003RIM6EC3A0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 08 Feb 2008 13:03:51 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <200802081828.43849.kendy@suse.cz>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73119>

On Fri, 8 Feb 2008, Jan Holesovsky wrote:

> Currently we are evaluating the usage of git for OpenOffice.org as one of the
> candidates (SVN is the other one), see
> 
>   http://wiki.services.openoffice.org/wiki/SCM_Migration
> 
> I've provided a git import of OOo with the entire history; the problem is that
> the pack has 2.5G, so it's not too convenient to download for casual
> developers that just want to try it.  Shallow clone is not a possibility - we
> don't get patches through mailing lists, so we need the pull/push, and also
> thanks to the OOo development cycle, we have too many living heads which
> causes the shallow clone to download about 1.5G even with --depth 1.

How did you repack your repository?

We know that current defaults are not suitable for large projects.  For 
example, the gcc git repository shrinked from 1.5GB pack down to 230MB 
after some tuning.


Nicolas
