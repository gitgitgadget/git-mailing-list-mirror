From: Tom Prince <tom.prince@ualberta.net>
Subject: git-local-fetch and objects/info/alternates.
Date: Tue, 10 Jan 2006 18:53:12 -0700
Message-ID: <20060111015311.GA4637@socrates>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Jan 11 02:52:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwV9p-00081K-2U
	for gcvg-git@gmane.org; Wed, 11 Jan 2006 02:52:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161087AbWAKBwK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jan 2006 20:52:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161089AbWAKBwK
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jan 2006 20:52:10 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:16117 "EHLO
	pd2mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1161087AbWAKBwI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2006 20:52:08 -0500
Received: from pd2mr5so.prod.shaw.ca (pd2mr5so-qfe3.prod.shaw.ca [10.0.141.8])
 by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0ISW000OINUW2J50@l-daemon> for git@vger.kernel.org; Tue,
 10 Jan 2006 18:52:08 -0700 (MST)
Received: from pn2ml2so.prod.shaw.ca ([10.0.121.146])
 by pd2mr5so.prod.shaw.ca (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar
 15 2004)) with ESMTP id <0ISW00BHCNUWB820@pd2mr5so.prod.shaw.ca> for
 git@vger.kernel.org; Tue, 10 Jan 2006 18:52:08 -0700 (MST)
Received: from socrates ([68.148.44.80])
 by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0ISW006OANUVNPW0@l-daemon> for git@vger.kernel.org; Tue,
 10 Jan 2006 18:52:08 -0700 (MST)
Received: from socrates (localhost [127.0.0.1])	by socrates (8.13.4/8.13.4)
 with ESMTP id k0B1rCjp006289	for <git@vger.kernel.org>; Tue,
 10 Jan 2006 18:53:12 -0700
Received: (from cougar@localhost)	by socrates (8.13.4/8.13.4/Submit)
 id k0B1rCTh006288	for git@vger.kernel.org; Tue, 10 Jan 2006 18:53:12 -0700
To: git@vger.kernel.org
Content-disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14472>

Is there some way to make git-local-fetch not try to copy files if the
source repository is in the destinations objects/info/alternates?
