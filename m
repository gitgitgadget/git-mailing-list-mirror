From: Yann Dirson <dirson@bertin.fr>
Subject: [BUG] git gui alert dialogs interfere with each other
Date: Wed, 27 Feb 2013 16:26:18 +0100
Organization: Bertin Technologies
Message-ID: <20130227162618.2a6762f0@chalon.bertin.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "me@bt" <dirson@bertin.fr>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 27 16:35:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UAj2f-0003rG-QT
	for gcvg-git-2@plane.gmane.org; Wed, 27 Feb 2013 16:35:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760148Ab3B0PfJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2013 10:35:09 -0500
Received: from cabourg.bertin.fr ([195.68.26.10]:47169 "EHLO cabourg.bertin.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759785Ab3B0PfI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2013 10:35:08 -0500
X-Greylist: delayed 527 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Feb 2013 10:35:07 EST
Received: from cabourg.bertin.fr (localhost [127.0.0.1])
	by postfix.imss70 (Postfix) with ESMTP id 4FB25A0F91
	for <git@vger.kernel.org>; Wed, 27 Feb 2013 16:26:16 +0100 (CET)
Received: from yport1.innovation.bertin.fr (yport1.bertin.fr [192.168.1.13])
	by cabourg.bertin.fr (Postfix) with ESMTP id 299B5A0F90
	for <git@vger.kernel.org>; Wed, 27 Feb 2013 16:26:16 +0100 (CET)
Received: from chalon.bertin.fr ([172.16.1.1]) by yport1.innovation.bertin.fr
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPPA id <0MIV0059VXJRGE90@yport1.innovation.bertin.fr> for
 git@vger.kernel.org; Wed, 27 Feb 2013 16:26:16 +0100 (CET)
X-Mailer: Claws Mail 3.8.1 (GTK+ 2.24.10; i486-pc-linux-gnu)
X-TM-AS-Product-Ver: IMSS-7.0.0.8220-7.0.0.1014-19672.003
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217210>

(Seen in 1.7.12.3)

When launching git gui in a repo where there are 1. lots of (>5000) stashed changes
(to do a tree move), and 2. many non-packed files, git gui throws 2 alert dialogs:
one saying that it will only show 5000 changed files and ignore the others, which
very quickly hidden by the offer to repack.  If I decline repacking, then both
dialogs are discarded, and the first one, which is quite critical, may not have been
seen at all by the user.

-- 
Yann Dirson - Bertin Technologies
