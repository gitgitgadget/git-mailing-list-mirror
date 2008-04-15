From: David Newall <davidn@davidnewall.com>
Subject: Re: Reporting bugs and bisection
Date: Tue, 15 Apr 2008 19:03:15 +0930
Message-ID: <4804765B.2070300@davidnewall.com>
References: <47FEADCB.7070104@rtr.ca> <20080413121831.d89dd424.akpm@linux-foundation.org> <20080413202118.GA29658@2ka.mipt.ru> <200804132233.50491.rjw@sisk.pl> <20080413205406.GA9190@2ka.mipt.ru> <48028830.6020703@earthlink.net> <alpine.DEB.1.10.0804131546370.9318@asgard> <20080414043939.GA6862@1wt.eu> <20080414053943.GU9785@ZenIV.linux.org.uk> <20080413232441.e216a02c.akpm@linux-foundation.org> <20080414072328.GW9785@ZenIV.linux.org.uk> <Xine.LNX.4.64.0804150131300.4160@us.intercode.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Al Viro <viro@ZenIV.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Willy Tarreau <w@1wt.eu>, david@lang.hm,
	Stephen Clark <sclark46@earthlink.net>,
	Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, Tilman Schmidt <tilman@imap.cc>,
	Valdis.Kletnieks@vt.edu, Mark Lord <lkml@rtr.ca>,
	David Miller <davem@davemloft.net>, jesper.juhl@gmail.com,
	yoshfuji@linux-ipv6.org, jeff@garzik.org,
	linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org,
	netdev@vger.kernel.org
To: James Morris <jmorris@namei.org>
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762773AbYDOJd2@vger.kernel.org Tue Apr 15 11:34:21 2008
connect(): Connection refused
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762773AbYDOJd2@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlhYP-0001WV-UG
	for glk-linux-kernel-3@gmane.org; Tue, 15 Apr 2008 11:34:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762773AbYDOJd2 (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 15 Apr 2008 05:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755314AbYDOJdQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2008 05:33:16 -0400
Received: from eth7959.sa.adsl.internode.on.net ([150.101.82.22]:33030 "EHLO
	hawking.rebel.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755217AbYDOJdP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2008 05:33:15 -0400
Received: from [192.168.0.9] (ppp121-45-0-36.lns10.adl2.internode.on.net [::ffff:121.45.0.36])
  (AUTH: PLAIN davidn, SSL: TLSv1/SSLv3,256bits,AES256-SHA)
  by hawking.rebel.net.au with esmtp; Tue, 15 Apr 2008 19:03:11 +0930
  id 00394473.48047658.00000286
User-Agent: Thunderbird 2.0.0.12 (X11/20080227)
In-Reply-To: <Xine.LNX.4.64.0804150131300.4160@us.intercode.com.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79578>

James Morris wrote:
> I don't know how to solve this, but suspect that encouraging the use of 
> reviewed-by and also including it in things like analysis of who is 
> contributing, selection for kernel summit invitations etc. would be a 
> start.  At least, better than nothing.


Would it be hard to keep count of the number of errors introduced by
author and reviewer?
