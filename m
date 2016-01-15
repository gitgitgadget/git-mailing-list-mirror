From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Announcing git-cinnabar 0.3.0
Date: Fri, 15 Jan 2016 10:25:14 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601151022050.2964@virtualbox>
References: <20160115085658.GA15539@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Fri Jan 15 10:25:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aK0dc-00010F-Pc
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 10:25:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756545AbcAOJZf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 04:25:35 -0500
Received: from mout.gmx.net ([212.227.17.21]:56161 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755961AbcAOJZa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 04:25:30 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MJmcS-1aL75r2TuG-0017ca; Fri, 15 Jan 2016 10:25:15
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <20160115085658.GA15539@glandium.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:wL1xFP0VIQQ/yLg7QedEw2kh4JOJDOxebYjQIW3VlP4nlQ+j8Hx
 9SuScZpxVZ+Wb6mvqblKAUQi2Nih3ZPMkvnlJE8xJQXDEpdJvTd6+9RkbT71/AFefXq4rGI
 xiPGWnRTdKj1RnXdiKyxZv/N8K9P3sQ27xMc950Fi4LONNPZQ3DnvA/ZAe5VTjdwhENw5yT
 hDpaV4cHQTAi7/qYMvXew==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PFy8J90xlBo=:9RKhIJLjgvIEeKs/N4qOxm
 h9kq3/OUIzp4fp7TSHj8U5JeTsl3jj7RhK4FanoT62qcw3mmZleJAKHjgB7BB17eEHwUyBrTi
 QtdUSvYKrUIdYziEFgPe5I3cmMaUcMfLce+boXA9cXYoX5CLWLYRrnaeGK+Le59Qam+56Sr1V
 NLkF6rP9CCbIWQLfiL75fxx8akrAGpuiXQdZDpRTszVGiS4YmiZDjwmePbHfz7PRY1h/LhqRi
 HPWPk/1iP1fAgivN+NqAynkmvBWaiSHEpvpdaiF/Roat4Z+HU7H7xtlZDuVlv+xWdXvfa9BY8
 Gmslglzs4W3ZbwqmuHUZb+NF6sqQ4s3CYA1vTBRquMFRS47fb4bNs3mcRBqraqYfnp1BRG0cQ
 5BwyqVgLK2ScBQ1w/iN3mQhWfYvDDaj/oluhYEhvKMWvxASKWe4gh6I0uV8vryC6Y5NR7Ibcm
 If1Y7uUws0ecziqTcg1No6oxkMOpAR2UxpoCxE4sqw6VdcY3YN0S2hoTnE3NPXfElb4XDN2Cp
 gW3N8VeZLkaD3SDZhV01uPy+BTik/NC41+LVbsXD3vCbznq93uQyRCyZXYpBRuIUGNVbOZGNJ
 BfE7EeSybGT3nkLJeBwdC2RCgwjUbbgIf9Ox+n7y1spGS5KOUOHW5Otk4YEEwEOzkgeN7hTpD
 LEQqo/Kcv9qBUD7q17s9bSIqWtKbz045bPYuYhqcAAX72sciRzMfJCGC0VWi0UoILoUjyH7uc
 uiAlZ7sEqPo29Xqo42Ng7NIr2U6PIQ4w+gKU66GKpZpEEBo+wnJxsdjH8RxDLRl3GpFMM9iQ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284153>

Hi Mike,

On Fri, 15 Jan 2016, Mike Hommey wrote:

> Git-cinnabar is a git remote helper to interact with mercurial
> repositories. It allows to clone, pull and push from/to mercurial remote
> repositories, using git.

Great news! I was really sad when Sverre's work on remote-hg was basically
ignored and replaced (and he went away after that), and then the
replacement was not maintained properly.

So I am personally very happy that there is a well-maintained alternative
now.

Hopefully I will get a chance to test this soon, but I already have one
comment: at
> 1. https://github.com/glandium/git-cinnabar/wiki/Windows-Support

... it is mentioned that...

	Git for Windows 32-bits is untested, but assumed to have the same
	issue as MSys2 32-bits

... but as is mentioned here:

	https://github.com/git-for-windows/git/wiki/32-bit-issues

Git for Windows executes the rebaseall step as part of the installation,
so it should not have the same issue as MSys2 32-bits ;-)

Ciao,
Dscho
