From: Nicolas Pitre <nico@cam.org>
Subject: Re: libgit2 - a true git library
Date: Fri, 31 Oct 2008 16:24:14 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0810311558540.13034@xanadu.home>
References: <20081031170704.GU14786@spearce.org>
 <20081031174745.GA4058@artemis.corp>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Fri Oct 31 21:25:39 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kw0Yp-0007WD-5j
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 21:25:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433AbYJaUYV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 16:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbYJaUYV
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 16:24:21 -0400
Received: from relais.videotron.ca ([24.201.245.36]:39858 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174AbYJaUYU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 16:24:20 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K9M00FMKE0E4D50@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 31 Oct 2008 16:24:14 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20081031174745.GA4058@artemis.corp>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99635>

On Fri, 31 Oct 2008, Pierre Habouzit wrote:

> Last but not least, I believe parts of git-core are currently easy to
> just take. For example, any code *I* wrote, I hereby give permission to
> relicense it in any of the following licenses: BSD-like, MIT-like,
> WTFPL.

First........... is there really a need to re-license it?
If so then the choice of license is IMHO rather important.

> Nicolas already said I think that he was okay with relicensing his 
> work too e.g.

Depends.  Sure, I gave permission to copy some of my code for JGIT 
because 1) JGIT is Java code in which I have little interest, 2) the 
different license was justified by the nature of the JGIT project, and 
3) although no license convey this I asked for the C version of git to 
remain the authoritative reference and that any improvements done to JGIT 
first be usable in the C version under the GPL.

Of course a library might need a different license than the GPL to be 
widely useful from a linkage stand point, but the code within that 
library does not need to be miles away from the GPL.  What I personally 
care about is for improvements to my code to always be contributed back, 
which pretty much discards BSD-like licenses.

My favorite license for a library is the GPL with the gcc exception, 
i.e. what libraries coming with gcc are using.  They're GPL but with an 
exception allowing them to be linked with anything.  And because 
everything on a Linux system, including proprietary applications, is 
likely linked against those gcc libs, then there is nothing that would 
prevent libgit to be linked against anything as well.  But the library 
code itself has GPL protection.

For reference, here's the exception text:

   In addition to the permissions in the GNU General Public License, the
   Free Software Foundation gives you unlimited permission to link the
   compiled version of this file into combinations with other programs,
   and to distribute those combinations without any restriction coming
   from the use of this file.  (The General Public License restrictions
   do apply in other respects; for example, they cover modification of
   the file, and distribution when not linked into a combine
   executable.)


Nicolas
