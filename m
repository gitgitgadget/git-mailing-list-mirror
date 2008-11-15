From: David Brown <git@davidb.org>
Subject: Re: git to libgit2 code relicensing
Date: Sat, 15 Nov 2008 10:49:25 -0800
Message-ID: <20081115184925.GB22714@linode.davidb.org>
References: <491DE6CC.6060201@op5.se> <alpine.LFD.2.00.0811141512480.3468@nehalem.linux-foundation.org> <20081114234658.GA2932@spearce.org> <20081115123916.GN24201@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andreas Ericsson <ae@op5.se>,
	Git Mailing List <git@vger.kernel.org>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sat Nov 15 19:50:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1QEI-0000r3-RI
	for gcvg-git-2@gmane.org; Sat, 15 Nov 2008 19:50:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751756AbYKOStc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Nov 2008 13:49:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751877AbYKOStc
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Nov 2008 13:49:32 -0500
Received: from linode.davidb.org ([72.14.176.16]:38288 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751734AbYKOStb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Nov 2008 13:49:31 -0500
Received: from davidb by mail.davidb.org with local (Exim 4.69 #1 (Debian))
	id 1L1QCz-00061P-QU; Sat, 15 Nov 2008 10:49:25 -0800
Content-Disposition: inline
In-Reply-To: <20081115123916.GN24201@genesis.frugalware.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101084>

On Sat, Nov 15, 2008 at 01:39:16PM +0100, Miklos Vajna wrote:
>On Fri, Nov 14, 2008 at 03:46:58PM -0800, "Shawn O. Pearce" <spearce@spearce.org> wrote:
>>  Note that the only valid version of the GPL as far as this project
>>  is concerned is _this_ particular version of the license (ie v2, not
>>  v2.2 or v3.x or whatever), unless explicitly otherwise stated.
>> 
>>  In addition to the permissions in the GNU General Public License,
>>  the authors give you unlimited permission to link the compiled
>>  version of this file into combinations with other programs,
>>  and to distribute those combinations without any restriction
>>  coming from the use of this file.  (The General Public License
>>  restrictions do apply in other respects; for example, they cover
>>  modification of the file, and distribution when not linked into
>>  a combined executable.)
>
>IANAL - what is the difference between this and the LGPL?

This clause allows static linking, and distribution of only the final
binary.  The LGPL always requires source to be made available to the
libaray.  This clause does not require that source to be distributed.

In other words, it allows libgit2 to be linked into a proprietary
program and the distributor of that program to _not_ include the
source of libgit2.  It is not clear if they have to provide source to
modifications that they have made, or if making those modifications
under the exception is even allowed.

There are numerous other versions of this exception, some of which
might be better worded than this.

David
