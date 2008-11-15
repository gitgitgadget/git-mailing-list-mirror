From: Nicolas Pitre <nico@cam.org>
Subject: Re: git to libgit2 code relicensing
Date: Sat, 15 Nov 2008 03:04:29 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0811150256140.27509@xanadu.home>
References: <491DE6CC.6060201@op5.se>
 <alpine.LFD.2.00.0811141512480.3468@nehalem.linux-foundation.org>
 <20081114234658.GA2932@spearce.org> <20081115043051.GA21608@linode.davidb.org>
 <20081115050039.GC2932@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: David Brown <git@davidb.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andreas Ericsson <ae@op5.se>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Nov 15 09:07:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1GBv-0001eT-4z
	for gcvg-git-2@gmane.org; Sat, 15 Nov 2008 09:07:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753091AbYKOIEg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Nov 2008 03:04:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753135AbYKOIEg
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Nov 2008 03:04:36 -0500
Received: from relais.videotron.ca ([24.201.245.36]:59436 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753088AbYKOIEf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Nov 2008 03:04:35 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KAD0033Q7RHNJO0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 15 Nov 2008 03:04:29 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20081115050039.GC2932@spearce.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101053>

On Fri, 14 Nov 2008, Shawn O. Pearce wrote:

> David Brown <git@davidb.org> wrote:
> > On Fri, Nov 14, 2008 at 03:46:58PM -0800, Shawn O. Pearce wrote:
> >
> >> In addition to the permissions in the GNU General Public License,
> >> the authors give you unlimited permission to link the compiled
> >> version of this file into combinations with other programs,
> >> and to distribute those combinations without any restriction
> >> coming from the use of this file.  (The General Public License
> >> restrictions do apply in other respects; for example, they cover
> >> modification of the file, and distribution when not linked into
> >> a combined executable.)
> >
> > Is this license intended to allow static linking but forbid dynamic
> > linking into a non-GPL program?  It depends on how you interpret
> > "linked into a combined executable", but that sounds like it
> > intentionally excludes the dynamic case.
> 
> I don't know.  When I read it myself I assumed dynamic linking
> would also be OK.

libgcc is a dynamic library on most modern systems these days. Yet they 
routinely execute non-GPL programs. If that text intentionally excluded 
the dynamic case then every non-GPL applications on such systems would 
have been breaking the license for a long time.  So I don't think anyone 
could have substance for such a claim.


Nicolas
