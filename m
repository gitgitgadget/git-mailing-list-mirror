From: Pierre Habouzit <madcoder@debian.org>
Subject: filter-branch enhancements
Date: Thu, 30 Oct 2008 17:18:56 +0100
Message-ID: <1225383538-23666-1-git-send-email-madcoder@debian.org>
References: <20081030132623.GC24098@artemis.corp>
Cc: pasky@suse.cz, srabbelier@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 30 17:20:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvaG6-0005xS-VC
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 17:20:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755009AbYJ3QTE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2008 12:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755214AbYJ3QTE
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 12:19:04 -0400
Received: from pan.madism.org ([88.191.52.104]:39190 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753522AbYJ3QTB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 12:19:01 -0400
Received: from madism.org (def92-12-88-177-251-208.fbx.proxad.net [88.177.251.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 0CE823B416;
	Thu, 30 Oct 2008 17:18:59 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 6512B5EE23B; Thu, 30 Oct 2008 17:18:58 +0100 (CET)
X-Mailer: git-send-email 1.6.0.3.758.gc29b0
In-Reply-To: <20081030132623.GC24098@artemis.corp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99493>

The first patch is about making git-filter-branch use parse options, and
is independant, but the current state made my eyes bleed, and I wanted
to work on the second patch ;)

The second patch is more a request for comments, and if people think
it's useful, I'll try to check it actually works, and write some tests
for it.
