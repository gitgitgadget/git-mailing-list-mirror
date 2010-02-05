From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: How can I tell if a file has been updated upstream?
Date: Fri, 05 Feb 2010 12:39:18 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002051235000.1681@xanadu.home>
References: <ed82fe3e1002050823gec57827j184c9c4cff4f4a45@mail.gmail.com>
 <20100205164407.GA27498@spearce.org>
 <ed82fe3e1002050856v68d4d02bnbe18394bebac2f4d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git <git@vger.kernel.org>
To: Timur Tabi <timur@freescale.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 18:39:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdS9W-00015x-RL
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 18:39:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757167Ab0BERj0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 12:39:26 -0500
Received: from relais.videotron.ca ([24.201.245.36]:58693 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757100Ab0BERjY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 12:39:24 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KXD00BPFQDI6TQ0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 05 Feb 2010 12:39:19 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <ed82fe3e1002050856v68d4d02bnbe18394bebac2f4d@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139064>

On Fri, 5 Feb 2010, Timur Tabi wrote:

> So maybe you meant this:
> 
> $ git ls-remote ssh://git.am.freescale.net/git/timur/bin refs/heads/master
> 20fbe12069038057cbd0d66c5a673956f7792c7d	refs/heads/master
> 
> I can use this to compare with the local HEAD.  However, this only
> tells me that the repository as a whole has changed.  I was hoping
> there would be a way to see if just the one file has change.  I.e. how
> can I get the HEAD of a *file* in a remote repository.

You can't.

You must perform a fetch and then use whatever method to compare with 
origin/master:foobar.py which is the file you're looking for.

> Yeah, I'm not keen on performing an actual download, even if it's just a fetch.

Why?  It is not like if a fetch was terribly more costly than any method 
that could get the version of a file on the remote.


Nicolas
