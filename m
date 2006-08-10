From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 0/9] git-verify-pack: clean up and make builtin
Date: Thu, 10 Aug 2006 17:02:29 +0200
Message-ID: <11552221582769-git-send-email-rene.scharfe@lsrfire.ath.cx>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 10 17:03:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GBC3b-0007Kf-Ap
	for gcvg-git@gmane.org; Thu, 10 Aug 2006 17:02:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161311AbWHJPCo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Aug 2006 11:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161314AbWHJPCo
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Aug 2006 11:02:44 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:9925
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S1161304AbWHJPCk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Aug 2006 11:02:40 -0400
Received: by neapel230.server4you.de (Postfix, from userid 1000)
	id 40D2C7015; Thu, 10 Aug 2006 17:02:38 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.4.2.rc4.g242a
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25190>

This patch series makes git-verify-pack handle user supplied parameters
much more carefully and converts it to a builtin command.  As a bonus it
plugs a memory leak and makes some comments clearer.  It applies to the
current next branch (a934882).
