From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Proposal: create meaningful aliases for git reset's hard/soft/mixed
Date: Fri, 2 Dec 2011 08:26:13 +0100
Message-ID: <201112020826.14114.trast@student.ethz.ch>
References: <CAGK7Mr4GZq5eXn4OB+B0ZborX-OVoXiWU8Lo1XM5LRZDuRe1YA@mail.gmail.com> <CAGK7Mr5nQoubAw11KDj4WKwQnXrfgteKbMj2=AR-HhsGKi52wQ@mail.gmail.com> <CABURp0rtCUbJXLHtXv_1g6GRKL3mX-T+3vN1=QO4CUibqXdEMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Philippe Vaucher <philippe.vaucher@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 02 08:26:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RWNVp-0003kg-SI
	for gcvg-git-2@lo.gmane.org; Fri, 02 Dec 2011 08:26:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752509Ab1LBH0U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Dec 2011 02:26:20 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:37772 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752422Ab1LBH0T (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Dec 2011 02:26:19 -0500
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Fri, 2 Dec
 2011 08:26:15 +0100
Received: from thomas.inf.ethz.ch (129.132.153.233) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.1.355.2; Fri, 2 Dec
 2011 08:26:17 +0100
User-Agent: KMail/1.13.7 (Linux/3.1.3-1-desktop; KDE/4.6.5; x86_64; ; )
In-Reply-To: <CABURp0rtCUbJXLHtXv_1g6GRKL3mX-T+3vN1=QO4CUibqXdEMg@mail.gmail.com>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186210>

Phil Hord wrote:
> 
> Think outside the "reset" command.  Like this:
> 
> From the "most popular" comment on http://progit.org/2011/07/11/reset.html:
> > I remember them as:
> > --soft      -> git uncommit
> > --mixed  -> git unadd
> > --hard     -> git undo
> 
> I don't particular like these names, but conceptually they are helpful.

I think all of these, but the last one in particular, are *very*
dangerous oversimplifications.  Doubly so if you then use "undo" with
a revision argument.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
