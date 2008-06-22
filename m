From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: linux-x86-tip: pilot error?
Date: Sun, 22 Jun 2008 15:21:38 -0700
Message-ID: <20080622222138.GG22569@linux.vnet.ibm.com>
References: <20080622123620.GA9328@linux.vnet.ibm.com> <237967ef0806220548t3fd73211v354071efe2db22e4@mail.gmail.com> <20080622132105.GD22569@linux.vnet.ibm.com> <20080622214202.GA15311@atjola.homenet>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mikael Magnusson <mikachu@gmail.com>, mingo@elte.hu,
	git@vger.kernel.org
To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jun 23 00:22:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAXxK-0006wE-C4
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 00:22:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758058AbYFVWVp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Jun 2008 18:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758062AbYFVWVo
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jun 2008 18:21:44 -0400
Received: from E23SMTP04.au.ibm.com ([202.81.18.173]:56540 "EHLO
	e23smtp04.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757721AbYFVWVn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jun 2008 18:21:43 -0400
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp04.au.ibm.com (8.13.1/8.13.1) with ESMTP id m5MMKp5Q015233
	for <git@vger.kernel.org>; Mon, 23 Jun 2008 08:20:51 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id m5MMLeQI254312
	for <git@vger.kernel.org>; Mon, 23 Jun 2008 08:21:40 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id m5MMLdmE028304
	for <git@vger.kernel.org>; Mon, 23 Jun 2008 08:21:40 +1000
Received: from paulmck-laptop.localdomain (wecm-9-67-149-169.wecm.ibm.com [9.67.149.169])
	by d23av02.au.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id m5MMLcpH028298;
	Mon, 23 Jun 2008 08:21:39 +1000
Received: by paulmck-laptop.localdomain (Postfix, from userid 1000)
	id 2EBF513E9DA; Sun, 22 Jun 2008 15:21:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080622214202.GA15311@atjola.homenet>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85809>

On Sun, Jun 22, 2008 at 11:42:02PM +0200, Bj=F6rn Steinbrink wrote:
> On 2008.06.22 06:21:05 -0700, Paul E. McKenney wrote:
> > Trying "git-checkout -b tip-core-rcu tip-core-rcu-2008-06-16_09.23_=
Mon"
> > acts like it is doing something useful, but doesn't find the recent=
 updates,
> > which I believe happened -before- June 16 2008.
>=20
> Do you mean these?
> rcu: make rcutorture more vicious: reinstate boot-time testing
> rcu: make rcutorture more vicious: add stutter feature

Indeed those are the ones that I am looking for!

> I just fetched tip, and here, those two were committed on June 18 200=
8.
> They're in tip/core/rcu, but not in the tag you mentioned.
>=20
> JFYI, I found those by using "git log --grep=3Dstutter --all", and th=
en
> passing the commit hash to "git describe":
>=20
> $ git describe --contains --all 31a72bce0bd6f3e0114009288bccbc96376ee=
eca
> remotes/tip/core/rcu

Thank you -- that does find those commits for me as well.  <scratches
head>

							Thanx, Paul
