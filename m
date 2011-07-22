From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Git commit generation numbers
Date: Fri, 22 Jul 2011 09:09:54 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1107220907370.1762@xanadu.home>
References: <20110721202722.3765.qmail@science.horizon.com>
 <201107221418.52414.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: George Spelvin <linux@horizon.com>,
	Anthony Van de Gejuchte <anthonyvdgent@gmail.com>,
	David Lang <david@lang.hm>, git@vger.kernel.org,
	Phil Hord <hordp@cisco.com>,
	Shawn Pearce <spearce@spearce.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 22 15:10:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QkFUQ-0003Af-8z
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jul 2011 15:10:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754269Ab1GVNJ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jul 2011 09:09:56 -0400
Received: from relais.videotron.ca ([24.201.245.36]:25575 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754207Ab1GVNJz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2011 09:09:55 -0400
Received: from xanadu.home ([66.130.28.92]) by vl-mr-mrz22.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LOQ00AMCKKI7960@vl-mr-mrz22.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 22 Jul 2011 09:09:54 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <201107221418.52414.jnareb@gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177641>

On Fri, 22 Jul 2011, Jakub Narebski wrote:

> BTW. with storing generation number in commit header there is a problem
> what would old version of git, one which does not understand said header,
> do during rebase.  Would it strip unknown headers, or would it copy
> generation number verbatim - which means that it can be incorrect?

They would indeed be copied verbatim and become incorrect.


Nicolas
