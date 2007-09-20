From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/3] the return of the strbuf
Date: Thu, 20 Sep 2007 12:49:30 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709201248400.28395@racer.site>
References: <20070917125211.GA18176@artemis.corp> <20070917133522.GD18176@artemis.corp>
 <20070918035721.GL3099@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Sep 20 13:50:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYKYA-00012q-Da
	for gcvg-git-2@gmane.org; Thu, 20 Sep 2007 13:50:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752044AbXITLuZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2007 07:50:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751272AbXITLuZ
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Sep 2007 07:50:25 -0400
Received: from mail.gmx.net ([213.165.64.20]:51060 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750789AbXITLuY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2007 07:50:24 -0400
Received: (qmail invoked by alias); 20 Sep 2007 11:50:23 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp018) with SMTP; 20 Sep 2007 13:50:23 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/J7XEzqjvJcTNb6t91PcTMQJpHtSJvAr6LXboEYy
	6UkN8hB5hw7nWO
X-X-Sender: gene099@racer.site
In-Reply-To: <20070918035721.GL3099@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58769>

Hi,

On Mon, 17 Sep 2007, Shawn O. Pearce wrote:


>  $ git log --pretty=format:%an --since=6.months.ago -- fast-import.c \
>       | sort | uniq -c | sort -nr
>   14 Shawn O. Pearce
>    3 Pierre Habouzit
>    3 Junio C Hamano
>    2 Simon Hausmann
>    2 Alex Riesen
>    1 Theodore Ts'o
>    1 Sven Verdoolaege
>    1 Sami Farin
>    1 Nicolas Pitre
>    1 Luiz Fernando N. Capitulino
>    1 Dana L. How

FWIW I'd do

git shortlog -n --since=6.months.ago HEAD -- fast-import.c|grep "^[A-Z]"

instead...

Ciao,
Dscho
