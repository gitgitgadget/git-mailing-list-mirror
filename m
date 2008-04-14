From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Reporting bugs and bisection
Date: Mon, 14 Apr 2008 13:38:02 -0700
Message-ID: <20080414133802.4535e4da.akpm@linux-foundation.org>
References: <47FEADCB.7070104@rtr.ca>
	<20080413121831.d89dd424.akpm@linux-foundation.org>
	<20080413202118.GA29658@2ka.mipt.ru>
	<200804132233.50491.rjw@sisk.pl>
	<20080413205406.GA9190@2ka.mipt.ru>
	<48028830.6020703@earthlink.net>
	<alpine.DEB.1.10.0804131546370.9318@asgard>
	<20080414043939.GA6862@1wt.eu>
	<20080414053943.GU9785@ZenIV.linux.org.uk>
	<20080413232441.e216a02c.akpm@linux-foundation.org>
	<4803ACE5.4020502@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: viro@ZenIV.linux.org.uk, w@1wt.eu, david@lang.hm,
	sclark46@earthlink.net, johnpol@2ka.mipt.ru, rjw@sisk.pl,
	tilman@imap.cc, Valdis.Kletnieks@vt.edu, lkml@rtr.ca,
	davem@davemloft.net, jesper.juhl@gmail.com,
	yoshfuji@linux-ipv6.org, jeff@garzik.org,
	linux-kernel@vger.kernel.org, git@vger.kernel.org,
	netdev@vger.kernel.org
To: Rene Herman <rene.herman@keyaccess.nl>
X-From: netdev-owner@vger.kernel.org Mon Apr 14 22:39:57 2008
connect(): Connection refused
Return-path: <netdev-owner@vger.kernel.org>
Envelope-to: linux-netdev-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlVSs-0002Ft-HA
	for linux-netdev-2@gmane.org; Mon, 14 Apr 2008 22:39:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752188AbYDNUi6 (ORCPT <rfc822;linux-netdev-2@m.gmane.org>);
	Mon, 14 Apr 2008 16:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752210AbYDNUi5
	(ORCPT <rfc822;netdev-outgoing>); Mon, 14 Apr 2008 16:38:57 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:55857 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751932AbYDNUi4 (ORCPT
	<rfc822;netdev@vger.kernel.org>); Mon, 14 Apr 2008 16:38:56 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3EKc4pM029614
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 14 Apr 2008 13:38:05 -0700
Received: from akpm.corp.google.com (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id m3EKc2g7025741;
	Mon, 14 Apr 2008 13:38:02 -0700
In-Reply-To: <4803ACE5.4020502@keyaccess.nl>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.20; i486-pc-linux-gnu)
X-Spam-Status: No, hits=-2.76 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: netdev-owner@vger.kernel.org
Precedence: bulk
List-ID: <netdev.vger.kernel.org>
X-Mailing-List: netdev@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79532>

On Mon, 14 Apr 2008 21:13:41 +0200
Rene Herman <rene.herman@keyaccess.nl> wrote:

> Does that mean you're not going to take patches that align the right end of 
> lines in comments? :-(

erm, was that ":-(" supposed to be a ":-)"?

I don't like to merge patches which fix typos and spellos and grammaros
in comments, simply because I'd be buried in the things.  I do take such
fixes for user-visible text (Documentation/, kerneldoc comments and
printks).

Right-justification of comments would fall rather a long way below spelling
fixes.

