From: Yann Dirson <dirson@bertin.fr>
Subject: clone --mirror should be replaced by --mirror=(fetch|push)
Date: Fri, 10 Jun 2011 09:12:21 +0200
Organization: Bertin Technologies
Message-ID: <20110610091221.013ebae6@chalon.bertin.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 10 09:41:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUwLO-0003m2-Oj
	for gcvg-git-2@lo.gmane.org; Fri, 10 Jun 2011 09:41:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753437Ab1FJHlV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2011 03:41:21 -0400
Received: from blois.bertin.fr ([195.68.26.9]:41606 "EHLO blois.bertin.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751803Ab1FJHlV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2011 03:41:21 -0400
X-Greylist: delayed 327 seconds by postgrey-1.27 at vger.kernel.org; Fri, 10 Jun 2011 03:41:21 EDT
Received: from blois.bertin.fr (localhost [127.0.0.1])
	by postfix.imss70 (Postfix) with ESMTP id 283B0541C3
	for <git@vger.kernel.org>; Fri, 10 Jun 2011 09:35:52 +0200 (CEST)
Received: from yport1.innovation.bertin.fr (yport1.bertin.fr [192.168.1.13])
	by blois.bertin.fr (Postfix) with ESMTP id D3361541E7
	for <git@vger.kernel.org>; Fri, 10 Jun 2011 09:35:51 +0200 (CEST)
Received: from chalon.bertin.fr ([172.16.1.1]) by yport1.innovation.bertin.fr
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPPA id <0LMK00GIWD3RIEA0@yport1.innovation.bertin.fr> for
 git@vger.kernel.org; Fri, 10 Jun 2011 09:35:51 +0200 (CEST)
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.24.4; i486-pc-linux-gnu)
X-TM-AS-Product-Ver: IMSS-7.0.0.8220-6.5.0.1024-18190.005
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175599>

Whereas "git remote add" has depreciated --mirror in favor of
--mirror=fetch and --mirror=push, "git clone --mirror", which creates a
"fetch mirror", also sets up things in the old "dangerous and useless"
(see 0990248) way.

-- 
Yann Dirson - Bertin Technologies
