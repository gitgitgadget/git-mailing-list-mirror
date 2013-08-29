From: Yann Dirson <dirson@bertin.fr>
Subject: [BUGLET] Short form of options with an optional parameter are not very
 clear
Date: Thu, 29 Aug 2013 11:40:52 +0200
Organization: Bertin Technologies
Message-ID: <20130829114052.2e0ec810@chalon.bertin.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: dirson@bertin.fr
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 29 11:40:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEyiU-0004NO-5A
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 11:40:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753356Ab3H2Jke (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 05:40:34 -0400
Received: from blois.bertin.fr ([195.68.26.9]:48483 "EHLO blois.bertin.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751650Ab3H2Jkd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 05:40:33 -0400
Received: from blois.bertin.fr (localhost [127.0.0.1])
	by postfix.imss70 (Postfix) with ESMTP id 022B34C28
	for <git@vger.kernel.org>; Thu, 29 Aug 2013 11:40:32 +0200 (CEST)
Received: from yport1.innovation.bertin.fr (yport1.bertin.fr [192.168.1.13])
	by blois.bertin.fr (Postfix) with ESMTP id D4D88446B
	for <git@vger.kernel.org>; Thu, 29 Aug 2013 11:40:31 +0200 (CEST)
Received: from chalon.bertin.fr ([172.16.1.1]) by yport1.innovation.bertin.fr
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPPA id <0MSA00CZJDJJ9R30@yport1.innovation.bertin.fr> for
 git@vger.kernel.org; Thu, 29 Aug 2013 11:40:31 +0200 (CEST)
X-Mailer: Claws Mail 3.9.2 (GTK+ 2.24.20; i486-pc-linux-gnu)
X-TM-AS-Product-Ver: IMSS-7.0.0.8250-7.0.0.1014-20112.006
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233243>

I just stumbled over the "git status -uno" form, and it took me some
time to realize that "no" was a parameter to -u, rather than aggregated
(and undocumented) -n and -o.

Whereas the manpage does document the "-u[<mode>]" syntax, which dissipate
the misunderstanding, --help output does not, listing "-u" in a way that
appears not to take any option.

Looks like the --help output would gain from having the optional parameter
displayed in the short form...

-- 
Yann Dirson - Bertin Technologies
