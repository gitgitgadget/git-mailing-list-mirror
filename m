From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Huge pack file from small unpacked objects
Date: Tue, 22 Dec 2009 12:41:07 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0912221238180.28241@xanadu.home>
References: <404585ED79625A40AB5A9884ECA9A63B3E02083F@VMBX125.ihostexchange.net>
 <75B8C0BEE0AE2A44AA971D218D9FE99E6B06F030@VMBX125.ihostexchange.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_pGASyPz5AyKZ+dK2b8GijA)"
Cc: "'git@vger.kernel.org'" <git@vger.kernel.org>
To: Nick Triantos <nick@perceptivepixel.com>
X-From: git-owner@vger.kernel.org Tue Dec 22 18:41:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NN8jT-0001WV-Is
	for gcvg-git-2@lo.gmane.org; Tue, 22 Dec 2009 18:41:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754412AbZLVRlK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Dec 2009 12:41:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752926AbZLVRlK
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Dec 2009 12:41:10 -0500
Received: from relais.videotron.ca ([24.201.245.36]:26169 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752512AbZLVRlJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Dec 2009 12:41:09 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KV200G3LEGJ2W80@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 22 Dec 2009 12:41:07 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <75B8C0BEE0AE2A44AA971D218D9FE99E6B06F030@VMBX125.ihostexchange.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135586>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_pGASyPz5AyKZ+dK2b8GijA)
Content-type: TEXT/PLAIN; charset=iso-8859-1
Content-transfer-encoding: 8BIT

On Tue, 22 Dec 2009, Nick Triantos wrote:

> I recently created a repo from SVN via git-svn.  The bare repo was 
> about ~600MB.  I cloned it, and on the clone, I added 2 small files 
> (.gitignore and .gitattributes) to a branch, merged them to master, 
> and pushed that back to the origin.  The cloned repo remains at about 
> 600MB, while my origin repo (the one from svn) is now about 2.4GB.  I 
> found that it created a file in objects/pack which accounts for this 
> huge size.
> 
> I've tried running 'git repack -a -d' but that didn't shrink the size 
> of this pack file.

This is rather weird.

Any chance the original repository could be downloaded somewhere in 
order to attempt reproducing this issue?


Nicolas

--Boundary_(ID_pGASyPz5AyKZ+dK2b8GijA)--
