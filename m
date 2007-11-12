From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] status&commit: Teach them to show commits of modified
 submodules.
Date: Mon, 12 Nov 2007 09:51:43 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711120950370.4362@racer.site>
References: <1194722863-14741-1-git-send-email-pkufranky@gmail.com>
 <7vabpliz13.fsf@gitster.siamese.dyndns.org>
 <46dff0320711102218h259199e3g2b4a4d3b73202cdb@mail.gmail.com>
 <7vhcjscyhu.fsf@gitster.siamese.dyndns.org> <47380019.1000704@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Yin Ping <pkufranky@gmail.com>,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Nov 12 10:52:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrVxy-0002TN-Lb
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 10:52:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756120AbXKLJwL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 04:52:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756088AbXKLJwK
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 04:52:10 -0500
Received: from mail.gmx.net ([213.165.64.20]:37618 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756084AbXKLJwI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 04:52:08 -0500
Received: (qmail invoked by alias); 12 Nov 2007 09:52:04 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp049) with SMTP; 12 Nov 2007 10:52:04 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18SHvYe81ES9uh1RgdLxYbYtDgXITEt2hxtljN6A1
	joIhXjqc92ke6z
X-X-Sender: gene099@racer.site
In-Reply-To: <47380019.1000704@viscovery.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64585>

Hi,

On Mon, 12 Nov 2007, Johannes Sixt wrote:

> Junio C Hamano schrieb:
>
> > I am not saying that it is wrong to use submodule to track such groups 
> > of source trees whose versions are very closely tied together.  At 
> > least not yet.
> 
> In KDE, the supermodule will actually just be a container that binds the 
> submodules together. The essential development will happen in the 
> submodules, and the supermodule will receive a commit quite frequently. 
> In this case, there will often be only a few or a few dozen commits 
> listed, and I anticipate that the integrator who is going to make the 
> commit (to the supermodule) will probably like the summary. So I'm all 
> for it.

I like it, too.  And we can make the number of shown commits configurable, 
just like for the merge summary.  But I'd rather see the code in 
wt-status.c than in git-submodule.sh.

Ciao,
Dscho
