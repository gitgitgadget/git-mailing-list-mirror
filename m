From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [PATCH v4] Introduce %<branch> as shortcut to the tracked
 branch
Date: Fri, 20 Mar 2009 23:41:04 +0000 (GMT)
Message-ID: <alpine.LNX.2.00.0903202324170.13726@reaper.quantumfyre.co.uk>
References: <200903181448.50706.agruen@suse.de> <alpine.DEB.1.00.0903182343580.10279@pacific.mpi-cbg.de>  <alpine.DEB.1.00.0903200121330.10279@pacific.mpi-cbg.de> <alpine.DEB.1.00.0903200137230.10279@pacific.mpi-cbg.de>  <20090320004029.GX23521@spearce.org>
 <20090320004450.GY23521@spearce.org>  <alpine.DEB.1.00.0903201027450.10279@pacific.mpi-cbg.de> <alpine.DEB.1.00.0903201714020.10279@pacific.mpi-cbg.de>  <7v7i2ki0sw.fsf@gitster.siamese.dyndns.org> <alpine.LNX.2.00.0903202300330.13726@reaper.quantumfyre.co.uk>
 <fabb9a1e0903201620l456bfc39n2422dcb1e738eb37@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Petr Baudis <pasky@suse.cz>,
	Andreas Gruenbacher <agruen@suse.de>, B.Steinbrink@gmx.de,
	git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 21 00:45:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkoPS-0004l2-Gl
	for gcvg-git-2@gmane.org; Sat, 21 Mar 2009 00:45:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760401AbZCTXms (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 19:42:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753762AbZCTXmr
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 19:42:47 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:53459 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760973AbZCTXmq (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Mar 2009 19:42:46 -0400
Received: from neutron.quantumfyre.co.uk (neutron.quantumfyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 474147812F4
	for <git@vger.kernel.org>; Fri, 20 Mar 2009 23:42:43 +0000 (GMT)
Received: (qmail 27003 invoked by uid 103); 20 Mar 2009 23:41:04 +0000
Received: from darkphoton.datavampyre.co.uk by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-2.05st 
 (clamdscan: 0.94.2/9142. spamassassin: 3.2.1. perlscan: 2.05st.  
 Clear:RC:1(212.159.54.234):. 
 Processed in 0.03412 secs); 20 Mar 2009 23:41:04 -0000
Received: from darkphoton.datavampyre.co.uk (212.159.54.234)
  by neutron.quantumfyre.co.uk with SMTP; 20 Mar 2009 23:41:04 +0000
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <fabb9a1e0903201620l456bfc39n2422dcb1e738eb37@mail.gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114017>

On Sat, 21 Mar 2009, Sverre Rabbelier wrote:

> Heya,
>
> On Sat, Mar 21, 2009 at 00:08, Julian Phillips <julian@quantumfyre.co.uk> wrote:
>>  git branch -m "'%master" percent-master
>
> Which kinda defeats the purpose of having a short-and-easy-to-write
> refname, no? "'%master" is not that easy to type, I at least get my
> fingers mixed up in the "'% sequence. Perhaps we should reserve these
> special characters now, and deprecate their use? Junio seemed to be
> open to that (quoted below)...

But it's not supposed to be easy to type ...

To use the new syntax you type %master only.  What I was proposing was a 
way to get at the branch that you had before the wizzy new feature was 
added.  Something you only do once to rename it - why waste an easy to 
type sequence on that?

I agree that adding some more reserved characters is a reasonable way 
forward - but I think a way should be provided for people who are 
_already_ using those characters to rename their branches to something that 
avoids those characters in a simple (but not necessarily easy to type) 
way.

-- 
Julian

  ---
panic("%s: CORRUPTED BTREE OR SOMETHING", __FUNCTION__);
         linux-2.6.6/fs/xfs/xfs_bmap.c
