From: Roland Dreier <rdreier@cisco.com>
Subject: Re: GIT Packages for Debian Etch
Date: Mon, 18 Jun 2007 16:36:56 -0700
Message-ID: <adavedkesx3.fsf@cisco.com>
References: <20070618212524.GC16393@cip.informatik.uni-erlangen.de>
	<Pine.LNX.4.64.0706181617060.18601@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Glanzmann <thomas@glanzmann.de>, carlo@alinoe.com,
	Linus Torvalds <torvalds@osdl.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Michael Gernoth <simigern@cip.informatik.uni-erlangen.de>,
	GIT <git@vger.kernel.org>
To: Christoph Lameter <clameter@sgi.com>
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933807AbXFRXhV@vger.kernel.org Tue Jun 19 01:37:40 2007
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933807AbXFRXhV@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0Qmx-0006FG-Pu
	for glk-linux-kernel-3@gmane.org; Tue, 19 Jun 2007 01:37:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933807AbXFRXhV (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 18 Jun 2007 19:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932953AbXFRXhA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jun 2007 19:37:00 -0400
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:33023 "EHLO
	sj-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932509AbXFRXg7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jun 2007 19:36:59 -0400
Received: from sj-dkim-2.cisco.com ([171.71.179.186])
  by sj-iport-3.cisco.com with ESMTP; 18 Jun 2007 16:36:58 -0700
X-IronPort-AV: i="4.16,436,1175497200"; 
   d="scan'208"; a="495441618:sNHT45767920"
Received: from sj-core-5.cisco.com (sj-core-5.cisco.com [171.71.177.238])
	by sj-dkim-2.cisco.com (8.12.11/8.12.11) with ESMTP id l5INaw2M031338;
	Mon, 18 Jun 2007 16:36:58 -0700
Received: from xbh-sjc-211.amer.cisco.com (xbh-sjc-211.cisco.com [171.70.151.144])
	by sj-core-5.cisco.com (8.12.10/8.12.6) with ESMTP id l5INastb029284;
	Mon, 18 Jun 2007 23:36:58 GMT
Received: from xfe-sjc-212.amer.cisco.com ([171.70.151.187]) by xbh-sjc-211.amer.cisco.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 18 Jun 2007 16:36:57 -0700
Received: from roland-conroe ([171.71.26.194]) by xfe-sjc-212.amer.cisco.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 18 Jun 2007 16:36:56 -0700
Received: by roland-conroe (Postfix, from userid 33217)
	id 9FDCDE7185; Mon, 18 Jun 2007 16:36:56 -0700 (PDT)
X-Message-Flag: Warning: May contain useful information
In-Reply-To: <Pine.LNX.4.64.0706181617060.18601@schroedinger.engr.sgi.com> (Christoph Lameter's message of "Mon, 18 Jun 2007 16:18:32 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
X-OriginalArrivalTime: 18 Jun 2007 23:36:57.0002 (UTC) FILETIME=[8F2B00A0:01C7B201]
DKIM-Signature: v=0.5; a=rsa-sha256; q=dns/txt; l=603; t=1182209818; x=1183073818;
	c=relaxed/simple; s=sjdkim2002;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=rdreier@cisco.com;
	z=From:=20Roland=20Dreier=20<rdreier@cisco.com>
	|Subject:=20Re=3A=20GIT=20Packages=20for=20Debian=20Etch
	|Sender:=20;
	bh=kQRqv2mKLoLr4vjpMWWKyzpN+915w3ciGO618PgPXSY=;
	b=sJW10l3eNRj89TMqzY2A7otHYTZt5XNSnGme8FJiNUIecStQOGN7fQYSy0Wko3Gw72bzXwt4
	nbf0tH3zFzOYyEvjEarAwbIr9rxW4mRZXfpVbdOGx6JjEfP+EoASW70z;
Authentication-Results: sj-dkim-2; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim2002 verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50427>

 > Is there some way you can feed that into Debian please? Why the go around 
 > through a separate repository? The maintainer of git-core is not actively 
 > maintaining the package?

No.  The current version of git in Debian is 1.5.2.1, a little out of
date from the current 1.5.2.2 but not too bad.  However, Debian Etch
was already released with an older version of git.  Debian
testing/Lenny (the next release, which is still being developed) does
not have the latest version of git yet because it is blocked waiting
for the next version of curl as well as a few other problems.

 - R.
