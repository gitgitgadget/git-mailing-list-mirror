From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: linux-x86-tip: pilot error?
Date: Sun, 22 Jun 2008 23:42:02 +0200
Message-ID: <20080622214202.GA15311@atjola.homenet>
References: <20080622123620.GA9328@linux.vnet.ibm.com> <237967ef0806220548t3fd73211v354071efe2db22e4@mail.gmail.com> <20080622132105.GD22569@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mikael Magnusson <mikachu@gmail.com>, mingo@elte.hu,
	git@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
X-From: git-owner@vger.kernel.org Sun Jun 22 23:43:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAXKy-0005Pc-Ag
	for gcvg-git-2@gmane.org; Sun, 22 Jun 2008 23:43:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754714AbYFVVmJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Jun 2008 17:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754638AbYFVVmI
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jun 2008 17:42:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:54969 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754041AbYFVVmH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jun 2008 17:42:07 -0400
Received: (qmail invoked by alias); 22 Jun 2008 21:42:04 -0000
Received: from i577BA657.versanet.de (EHLO atjola.local) [87.123.166.87]
  by mail.gmx.net (mp033) with SMTP; 22 Jun 2008 23:42:04 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/HkCER+0nHrAwg4mKiTJxs2o9HQpA1niq7O9Q414
	iredA8VK6kSh1X
Content-Disposition: inline
In-Reply-To: <20080622132105.GD22569@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85806>

On 2008.06.22 06:21:05 -0700, Paul E. McKenney wrote:
> Trying "git-checkout -b tip-core-rcu tip-core-rcu-2008-06-16_09.23_Mo=
n"
> acts like it is doing something useful, but doesn't find the recent u=
pdates,
> which I believe happened -before- June 16 2008.

Do you mean these?
rcu: make rcutorture more vicious: reinstate boot-time testing
rcu: make rcutorture more vicious: add stutter feature

I just fetched tip, and here, those two were committed on June 18 2008.
They're in tip/core/rcu, but not in the tag you mentioned.

JFYI, I found those by using "git log --grep=3Dstutter --all", and then
passing the commit hash to "git describe":

$ git describe --contains --all 31a72bce0bd6f3e0114009288bccbc96376eeec=
a
remotes/tip/core/rcu

Bj=F6rn
