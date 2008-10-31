From: david@lang.hm
Subject: Re: libgit2 - a true git library
Date: Fri, 31 Oct 2008 13:29:40 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0810311325490.5851@asgard.lang.hm>
References: <20081031170704.GU14786@spearce.org> <20081031174745.GA4058@artemis.corp> <alpine.LFD.2.00.0810311558540.13034@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Pierre Habouzit <madcoder@debian.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Oct 31 21:31:12 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kw0e0-0000nB-OJ
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 21:30:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752340AbYJaU3N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 16:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752298AbYJaU3L
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 16:29:11 -0400
Received: from mail.lang.hm ([64.81.33.126]:46467 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752277AbYJaU3K (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 16:29:10 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id m9VKT0F9028707;
	Fri, 31 Oct 2008 12:29:00 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <alpine.LFD.2.00.0810311558540.13034@xanadu.home>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99638>

On Fri, 31 Oct 2008, Nicolas Pitre wrote:

> On Fri, 31 Oct 2008, Pierre Habouzit wrote:
>
>> Last but not least, I believe parts of git-core are currently easy to
>> just take. For example, any code *I* wrote, I hereby give permission to
>> relicense it in any of the following licenses: BSD-like, MIT-like,
>> WTFPL.
>
> First........... is there really a need to re-license it?
> If so then the choice of license is IMHO rather important.

at the very least you should go from GPLv2 to LGPLv2 for the library.

while it can be argued that this really shouldn't be nessasary, the water 
is muddy enough that it would be a very good thing to do this.

I don't see any need to switch to a BSD/MIT/etc license for a library, the 
LGPL lets it get linked with those licenses anyway.

> My favorite license for a library is the GPL with the gcc exception,
> i.e. what libraries coming with gcc are using.  They're GPL but with an
> exception allowing them to be linked with anything.  And because
> everything on a Linux system, including proprietary applications, is
> likely linked against those gcc libs, then there is nothing that would
> prevent libgit to be linked against anything as well.  But the library
> code itself has GPL protection.
>
> For reference, here's the exception text:
>
>   In addition to the permissions in the GNU General Public License, the
>   Free Software Foundation gives you unlimited permission to link the
>   compiled version of this file into combinations with other programs,
>   and to distribute those combinations without any restriction coming
>   from the use of this file.  (The General Public License restrictions
>   do apply in other respects; for example, they cover modification of
>   the file, and distribution when not linked into a combine
>   executable.)

<shrug>, I don't see why this is needed with the LGPL, but I'm not a 
lawyer.

David Lang
