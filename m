From: linux@horizon.com
Subject: Re: From b65bc21e7d8dc8cafc70dfa6354cb66b8874b2d9 Mon Sep 17 00:00:00 2001 [PATCH] Makefile: add framework to verify and bench sha1 implementations.
Date: 24 Jun 2006 05:29:21 -0400
Message-ID: <20060624092921.32165.qmail@science.horizon.com>
References: <7v3bdv0xyd.fsf_-_@assigned-by-dhcp.cox.net>
Cc: linux@horizon.com
X-From: git-owner@vger.kernel.org Sat Jun 24 15:12:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fu7wY-0008MT-T5
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 15:12:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752229AbWFXNM4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 09:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752230AbWFXNM4
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 09:12:56 -0400
Received: from science.horizon.com ([192.35.100.1]:33066 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1752228AbWFXNM4
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jun 2006 09:12:56 -0400
Received: (qmail 32166 invoked by uid 1000); 24 Jun 2006 05:29:21 -0400
To: git@vger.kernel.org, junkio@cox.net
In-Reply-To: <7v3bdv0xyd.fsf_-_@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22517>

Nice work, but I might point out that the original PPC SHA bug was hashing
more than 0.5G of contiguous data in a *single* call to SHA1_Update,
while your test program works with 8K buffers.
