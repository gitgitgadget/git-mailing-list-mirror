From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: on subtree checkout
Date: Tue, 26 Feb 2008 01:59:10 +0000 (GMT)
Message-ID: <alpine.DEB.1.00.0802260156350.3322@eeepc-johanness>
References: <fcaeb9bf0802240134i46e276ajfe83071e0b18ce61@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git mailing list <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 26 02:59:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTp6n-0006Ym-J9
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 02:59:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754373AbYBZB7P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 20:59:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754221AbYBZB7P
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 20:59:15 -0500
Received: from mail.gmx.net ([213.165.64.20]:51075 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752505AbYBZB7O (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 20:59:14 -0500
Received: (qmail invoked by alias); 26 Feb 2008 01:59:12 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO eeepc-johanness.home) [86.138.198.40]
  by mail.gmx.net (mp016) with SMTP; 26 Feb 2008 02:59:12 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/u9GJbD1HuzEwQpgGvDPLH2ho2B2GK9mBMjZX4hv
	UZ9ciQDTXs/JtB
X-X-Sender: user@eeepc-johanness
In-Reply-To: <fcaeb9bf0802240134i46e276ajfe83071e0b18ce61@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75099>

Hi,

On Sun, 24 Feb 2008, Nguyen Thai Ngoc Duy wrote:

> I'm going to implement subtree checkout. The plan is to save "index
> prefix" in GIT_DIR/prefix and update git commands to use index prefix
> when accessing the index. If I'm heading a wrong way, stop me now.

As I wrote a long time ago already, I think the correct approach would be 
to reuse the code for the core.ignoreStat feature.

But I agree with others that you should think about sane implementations 
of rebase/merge with partial checkouts.

Ciao,
Dscho
