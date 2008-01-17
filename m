From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] Do not show "diff --git" metainfo with --no-prefix
Date: Thu, 17 Jan 2008 01:48:54 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801170147350.17650@racer.site>
References: <c0f2d4110801150559x155ffabaj6bea52715522a070@mail.gmail.com> <alpine.DEB.1.00.0801151444180.5289@eeepc-johanness> <c0f2d4110801150758t68714570y83e1e74acbb67325@mail.gmail.com> <alpine.LNX.1.00.0801151728120.13593@iabervon.org>
 <7vhched3kw.fsf@gitster.siamese.dyndns.org> <7v4pded1rk.fsf_-_@gitster.siamese.dyndns.org> <7v7iiabjyh.fsf_-_@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0801151902080.2806@woody.linux-foundation.org> <alpine.LFD.1.00.0801151919440.2806@woody.linux-foundation.org>
 <alpine.LNX.1.00.0801152256480.13593@iabervon.org> <alpine.LFD.1.00.0801152017490.2806@woody.linux-foundation.org> <7v1w8hploy.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0801161524390.13593@iabervon.org> <7vprw1mfpr.fsf@gitster.siamese.dyndns.org>
 <alpine.LSU.1.00.0801170108440.17650@racer.site> <7vabn5mdz7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Chris Ortman <chrisortman@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 17 02:49:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFJsm-0008Qt-JL
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 02:49:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbYAQBtA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 20:49:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbYAQBtA
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 20:49:00 -0500
Received: from mail.gmx.net ([213.165.64.20]:51470 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750861AbYAQBs7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 20:48:59 -0500
Received: (qmail invoked by alias); 17 Jan 2008 01:48:57 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp053) with SMTP; 17 Jan 2008 02:48:57 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+FjzUpPA6Fcw6K2MnsdpbWGKnHufgxYUYcaZ1gML
	Z9wc/PbXKbQzgH
X-X-Sender: gene099@racer.site
In-Reply-To: <7vabn5mdz7.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70807>

Hi,

On Wed, 16 Jan 2008, Junio C Hamano wrote:

> While we are discussing about diff, there is one thing that has been 
> bugging me occasionally, but the annoyance factor has not motivated me 
> enough to look into it myself, because I do not use it often: 
> --color-words.  It appears that it shows lines that do not have any word 
> differences in bold (whatever diff.color.meta is configured) and I think 
> it should use plain color instead.
> 
> Was this intentional, or just a simple plain bug?

Plain bug.  I even meant to implement your suggestion of having a variable 
set of non-word characters, but never came around to work on it.  
Hopefully this weekend...

Ciao,
Dscho
