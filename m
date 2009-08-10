From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v4 0/5] Re: {checkout,reset,stash} --patch
Date: Mon, 10 Aug 2009 11:36:33 +0200
Message-ID: <200908101136.34660.trast@student.ethz.ch>
References: <200907271210.40001.trast@student.ethz.ch> <200908092342.31733.trast@student.ethz.ch> <20090809222658.GB12932@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Mon Aug 10 11:39:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaRKt-0003rI-80
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 11:38:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753326AbZHJJh0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2009 05:37:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753308AbZHJJhZ
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 05:37:25 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:37137 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753187AbZHJJhG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2009 05:37:06 -0400
Received: from CAS02.d.ethz.ch (129.132.178.236) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.1.375.2; Mon, 10 Aug
 2009 11:37:05 +0200
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.1.375.2; Mon, 10 Aug
 2009 11:36:48 +0200
User-Agent: KMail/1.12.0 (Linux/2.6.27.25-0.1-default; KDE/4.3.0; x86_64; ; )
In-Reply-To: <20090809222658.GB12932@vidovic>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125426>

Nicolas Sebrecht wrote:
> 
> Ok. All of what you say above makes sense and I'm actually fine with
> your whole answer. That said,
> 
>   % git checkout -p HEAD
> 
> and
> 
>   % git checkout -p HEAD -- file
> 
> behave differently here in my test above.

Oh.  Sorry, that's indeed a bug, I'll fix this.  (The -- file form
loses the HEAD when invoking add--interactive.)

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
