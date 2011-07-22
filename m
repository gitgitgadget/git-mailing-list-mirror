From: david@lang.hm
Subject: Re: Git commit generation numbers
Date: Fri, 22 Jul 2011 11:02:35 -0700 (PDT)
Message-ID: <alpine.DEB.2.02.1107221102180.6496@asgard.lang.hm>
References: <20110721202722.3765.qmail@science.horizon.com> <201107221418.52414.jnareb@gmail.com> <alpine.LFD.2.00.1107220907370.1762@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Jakub Narebski <jnareb@gmail.com>,
	George Spelvin <linux@horizon.com>,
	Anthony Van de Gejuchte <anthonyvdgent@gmail.com>,
	git@vger.kernel.org, Phil Hord <hordp@cisco.com>,
	Shawn Pearce <spearce@spearce.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri Jul 22 20:03:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QkK4C-0002aV-Cr
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jul 2011 20:03:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753504Ab1GVSDK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jul 2011 14:03:10 -0400
Received: from mail.lang.hm ([64.81.33.126]:54245 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753368Ab1GVSDJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2011 14:03:09 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id p6MI2ZJM008848;
	Fri, 22 Jul 2011 11:02:35 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <alpine.LFD.2.00.1107220907370.1762@xanadu.home>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177653>

On Fri, 22 Jul 2011, Nicolas Pitre wrote:

> On Fri, 22 Jul 2011, Jakub Narebski wrote:
>
>> BTW. with storing generation number in commit header there is a problem
>> what would old version of git, one which does not understand said header,
>> do during rebase.  Would it strip unknown headers, or would it copy
>> generation number verbatim - which means that it can be incorrect?
>
> They would indeed be copied verbatim and become incorrect.

how would they become incorrect?

David Lang
