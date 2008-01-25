From: Jan Engelhardt <jengelh@computergmbh.de>
Subject: git add does not sanitize paths
Date: Fri, 25 Jan 2008 20:57:27 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0801252055520.15243@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 25 20:58:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIUga-000165-Hu
	for gcvg-git-2@gmane.org; Fri, 25 Jan 2008 20:58:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751780AbYAYT53 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2008 14:57:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752006AbYAYT53
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jan 2008 14:57:29 -0500
Received: from sovereign.computergmbh.de ([85.214.69.204]:42946 "EHLO
	sovereign.computergmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751574AbYAYT52 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2008 14:57:28 -0500
Received: by sovereign.computergmbh.de (Postfix, from userid 25121)
	id 574E718F3409B; Fri, 25 Jan 2008 20:57:27 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by sovereign.computergmbh.de (Postfix) with ESMTP id 511271D51E30F
	for <git@vger.kernel.org>; Fri, 25 Jan 2008 20:57:27 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71732>

Hi,


	git add net/netfilter//nf_conntrack_sip.c

while this is a valid path in Linux, git refuses to add it to the index. 
Would it be worthwhile to sanitize it (either by calling realpath(3) or 
by doing a stat(2))? (Please consider this as a feature request.)
Please cc on replies, thanks :)

Jan

- git version 1.5.3.4
