From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] prepare deprecation of git-revert
Date: Sun, 2 Nov 2008 17:12:09 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811021706580.22125@pacific.mpi-cbg.de.mpi-cbg.de>
References: <1225468527-29694-1-git-send-email-madcoder@debian.org> <20081031165003.GA5355@steel.home> <20081102093225.GA32296@laptop>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 02 17:06:36 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwfTG-0001gM-Ob
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 17:06:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754179AbYKBQEs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2008 11:04:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754173AbYKBQEr
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 11:04:47 -0500
Received: from mail.gmx.net ([213.165.64.20]:38783 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754159AbYKBQEq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Nov 2008 11:04:46 -0500
Received: (qmail invoked by alias); 02 Nov 2008 16:04:44 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp013) with SMTP; 02 Nov 2008 17:04:44 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19qibhsK4Fq0RaWQQjV5/H0pmnwPK91w5CikC7stw
	twsbAf8SXTxPFs
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <20081102093225.GA32296@laptop>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99849>

Hi,

On Sun, 2 Nov 2008, Nguyen Thai Ngoc Duy wrote:

>     Add git command expansion
>     
>     This allows git commands to be typed shorter (in shells that do not
>     support autocompletion). There are three types of expansion:
>     
>      - "foo" matches "foo*" commands (bi -> bisect)
>      - "foo" also matches "f*-oo*" (fim -> fast-import)
>      - "foo-bar" (with dash) matches "foo*-bar*" (fo-p -> format-patch)

I'd rather have the soft-alias code back to perform this expansion, but 
only for a limited and explicit set of abbreviations.

Ciao,
Dscho
