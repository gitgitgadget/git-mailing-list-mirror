From: Kacper Kornet <draenog@pld-linux.org>
Subject: Apostrophe at the end of author name
Date: Fri, 29 Jun 2012 14:41:22 +0200
Message-ID: <20120629124122.GG1258@camk.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 29 15:12:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Skb0B-0003Kj-1x
	for gcvg-git-2@plane.gmane.org; Fri, 29 Jun 2012 15:12:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755002Ab2F2NMn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jun 2012 09:12:43 -0400
Received: from moat.camk.edu.pl ([148.81.175.50]:52062 "EHLO moat.camk.edu.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754854Ab2F2NMm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jun 2012 09:12:42 -0400
X-Greylist: delayed 1865 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 Jun 2012 09:12:42 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by moat.camk.edu.pl (Postfix) with ESMTP id 809205F004C
	for <git@vger.kernel.org>; Fri, 29 Jun 2012 14:42:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at camk.edu.pl
Received: from moat.camk.edu.pl ([127.0.0.1])
	by localhost (liam.camk.edu.pl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id MeNazeLaqEXE for <git@vger.kernel.org>;
	Fri, 29 Jun 2012 14:42:29 +0200 (CEST)
Received: from gatekeeper2.camk.edu.pl (gatekeeper.camk.edu.pl [192.168.1.23])
	by moat.camk.edu.pl (Postfix) with ESMTP id C76A45F004A
	for <git@vger.kernel.org>; Fri, 29 Jun 2012 14:42:29 +0200 (CEST)
Received: by gatekeeper2.camk.edu.pl (Postfix, from userid 1293)
	id 7A56746735; Fri, 29 Jun 2012 14:41:22 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200816>

I try to import some repositories into git and one of the developers has
asked his name to be presented as: Name 'Nick' <email>.
However git commit --author="Name 'Nick' <email>" strips the last
apostrophe and produces a commit authored by: Name 'Nick <email>.

Maybe the function  strbuf_addstr_without_crud in ident.c should strip
the trailing apostrophe only when it removed it also from the beginning
of the string?

-- 
  Kacper
