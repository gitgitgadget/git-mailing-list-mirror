From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached HEAD
 was
Date: Fri, 16 Oct 2009 11:44:10 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0910161137540.20122@xanadu.home>
References: <alpine.LFD.2.00.0910141616530.20122@xanadu.home>
 <7v7huxbtbk.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.0910141647390.20122@xanadu.home>
 <7vws2xa9lu.fsf@alter.siamese.dyndns.org>
 <20091014230934.GC29664@coredump.intra.peff.net>
 <885649360910150036o72c3bd97ofad85d5316dc5b35@mail.gmail.com>
 <alpine.LFD.2.00.0910151436180.20122@xanadu.home>
 <7v1vl45t9k.fsf@alter.siamese.dyndns.org>
 <20091015212632.GA13180@coredump.intra.peff.net>
 <7v1vl42uid.fsf@alter.siamese.dyndns.org>
 <20091016042955.GA9233@atjola.homenet>
 <alpine.LNX.2.00.0910160128400.32515@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: =?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, James Pickens <jepicken@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Oct 16 17:53:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Myp6c-0006zS-Vz
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 17:52:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761738AbZJPPox (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2009 11:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761348AbZJPPox
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 11:44:53 -0400
Received: from relais.videotron.ca ([24.201.245.36]:36943 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758631AbZJPPow (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2009 11:44:52 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KRM000496DMBO60@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 16 Oct 2009 11:44:11 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.LNX.2.00.0910160128400.32515@iabervon.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130505>

On Fri, 16 Oct 2009, Daniel Barkalow wrote:

> What's the state before the "git checkout HEAD~2"?

It is HEAD@{1}.

> I know I often find my git.git repos on "* (no branch)", and I don't 
> remember if I checked that out as origin/master or origin/next.

Just have a look at the output of "git reflog".  Pretty unambiguous IMHO.


Nicolas
