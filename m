From: Kacper Kornet <draenog@pld-linux.org>
Subject: rev-parse -q --verify with not existent upstream branch
Date: Fri, 31 Aug 2012 19:11:58 +0200
Message-ID: <20120831171158.GM21362@camk.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 31 19:12:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7Ulc-00036f-Ot
	for gcvg-git-2@plane.gmane.org; Fri, 31 Aug 2012 19:12:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754631Ab2HaRMS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Aug 2012 13:12:18 -0400
Received: from moat.camk.edu.pl ([148.81.175.50]:51085 "EHLO moat.camk.edu.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754270Ab2HaRMR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2012 13:12:17 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by moat.camk.edu.pl (Postfix) with ESMTP id 41DF95F0050
	for <git@vger.kernel.org>; Fri, 31 Aug 2012 19:13:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at camk.edu.pl
Received: from moat.camk.edu.pl ([127.0.0.1])
	by localhost (liam.camk.edu.pl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id RgCPB-C5PjHU for <git@vger.kernel.org>;
	Fri, 31 Aug 2012 19:12:58 +0200 (CEST)
Received: from gatekeeper2.camk.edu.pl (gatekeeper.camk.edu.pl [192.168.1.23])
	by moat.camk.edu.pl (Postfix) with ESMTP id 81BFB5F0053
	for <git@vger.kernel.org>; Fri, 31 Aug 2012 19:12:58 +0200 (CEST)
Received: by gatekeeper2.camk.edu.pl (Postfix, from userid 1293)
	id 48E9140E3F; Fri, 31 Aug 2012 19:11:58 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204595>


Documentation to git-rev-parse claims that

-q, --quiet
   Only meaningful in --verify mode. Do not output an error
   message if the first argument is not a valid object name; instead exit
   with non-zero status silently.


However when I try to check if the current branch has a configured
upstream one with:

git rev-parse -q --verify  '@{u}'

I still receives the error message:

error: No upstream configured for branch 'threading'

Additinally withour -q --verify options the error message is printed
twice:

error: No upstream configured for branch 'threading'
@{u}
error: No upstream configured for branch 'threading'
fatal: ambiguous argument '@{u}': unknown revision or path not in the
working tree.
Use '--' to separate paths from revision

-- 
  Kacper
