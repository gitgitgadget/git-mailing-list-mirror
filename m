From: Jan Engelhardt <jengelh@medozas.de>
Subject: gitweb forgets to send utf8 header for raw blob views
Date: Wed, 28 May 2008 20:04:03 +0200 (CEST)
Message-ID: <alpine.LNX.1.10.0805282002510.19264@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 28 20:05:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1Q1E-0002sS-4J
	for gcvg-git-2@gmane.org; Wed, 28 May 2008 20:05:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752049AbYE1SEH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2008 14:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752010AbYE1SEF
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 14:04:05 -0400
Received: from sovereign.computergmbh.de ([85.214.69.204]:35729 "EHLO
	sovereign.computergmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751940AbYE1SEE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2008 14:04:04 -0400
Received: by sovereign.computergmbh.de (Postfix, from userid 25121)
	id 36C1A180461F9; Wed, 28 May 2008 20:04:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by sovereign.computergmbh.de (Postfix) with ESMTP id 3036D1CF0B2D7
	for <git@vger.kernel.org>; Wed, 28 May 2008 20:04:03 +0200 (CEST)
User-Agent: Alpine 1.10 (LNX 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83118>

Hi,


I have configured gitweb to use utf8, and that works for text blob views 
like on
http://dev.medozas.de/gitweb.cgi?p=hxtools;a=blob;f=bin/git-forest;hb=HEAD
but it does not for raw blob views like
http://dev.medozas.de/gitweb.cgi?p=hxtools;a=blob_plain;f=bin/git-forest;hb=HEAD


Jan
