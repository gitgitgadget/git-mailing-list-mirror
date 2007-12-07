From: Ingo Molnar <mingo@elte.hu>
Subject: git-bisect feature suggestion: "git-bisect diff"
Date: Fri, 7 Dec 2007 10:34:39 +0100
Message-ID: <20071207093439.GA21896@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 07 10:35:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0Zc6-0001vl-6V
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 10:35:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752219AbXLGJe4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 04:34:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752238AbXLGJez
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 04:34:55 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:36077 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752218AbXLGJez (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 04:34:55 -0500
Received: from elvis.elte.hu ([157.181.1.14])
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1J0Zba-00047Z-6n
	from <mingo@elte.hu>; Fri, 07 Dec 2007 10:34:53 +0100
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 348273E2166; Fri,  7 Dec 2007 10:34:38 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Received-SPF: neutral (mx3: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.2.3
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67403>


would be nice to have:

 git-bisect diff

that enables one to have a look at the currently open bisection window, 
in git-log -p format. This would often be much faster to analyze than 
looking at git-bisect visualize. (and it could also be used in non-GUI 
workflows)

Right now i have this silly git-bisect-diff script:

git-log -p "`git-bisect log | grep good | tail -1 | cut -d' ' -f3`".."\
`git-bisect log | grep bad | tail -1 | cut -d' ' -f3`"

	Ingo
