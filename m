From: Pierre Habouzit <madcoder@debian.org>
Subject: Make the ftplugin right wrt gitdir
Date: Wed, 18 Oct 2006 02:47:25 +0200
Message-ID: <11611324463754-git-send-email-madcoder@debian.org>
References: <11611319762395-git-send-email-madcoder@debian.org>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 02:50:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZzb0-0001yQ-LZ
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 02:47:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198AbWJRAr2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 20:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbWJRAr2
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 20:47:28 -0400
Received: from pan.madism.org ([88.191.16.128]:22504 "EHLO hermes.madism.org")
	by vger.kernel.org with ESMTP id S1751198AbWJRAr1 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Oct 2006 20:47:27 -0400
Received: from hermes.madism.org (localhost.localdomain [127.0.0.1])
	by hermes.madism.org (Postfix) with ESMTP id EE467B0060;
	Wed, 18 Oct 2006 02:47:23 +0200 (CEST)
Received: from hades.madism.org (olympe.madism.org [82.243.245.108])
	by hermes.madism.org (Postfix) with ESMTP id D5B07B005C;
	Wed, 18 Oct 2006 02:47:23 +0200 (CEST)
Received: by hades.madism.org (Postfix, from userid 1000)
	id 8425D62127; Wed, 18 Oct 2006 02:47:26 +0200 (CEST)
To: Jeff King <peff@peff.net>
X-Mailer: git-send-email 1.4.2.3
In-Reply-To: <11611319762395-git-send-email-madcoder@debian.org>
X-AV-Checked: ClamAV (using ClamSMTP) at pan.madism.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29163>

sorry for the mess, I'm a bit tired :)
Here is a third patch to fix the plugin to find the git-dir properly.

Also add a nice shortcut to quit that buffer.
