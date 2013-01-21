From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [RFC/PATCH] add: warn when -u or -A is used without filepattern
Date: Mon, 21 Jan 2013 16:00:23 +0100 (CET)
Message-ID: <1217961884.4232967.1358780423428.JavaMail.root@dewire.com>
References: <1358769611-3625-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Eric James Michael Ritz <lobbyjones@gmail.com>,
	Tomas Carnecky <tomas.carnecky@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Jan 21 16:00:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxIrf-0008NN-Di
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 16:00:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755620Ab3AUPAZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2013 10:00:25 -0500
Received: from zimbra.dewire.com ([83.140.172.131]:38210 "EHLO
	zimbra.dewire.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753503Ab3AUPAZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2013 10:00:25 -0500
Received: from localhost (localhost [127.0.0.1])
	by zimbra.dewire.com (Postfix) with ESMTP id C389A826E3;
	Mon, 21 Jan 2013 16:00:23 +0100 (CET)
X-Virus-Scanned: amavisd-new at dewire.se
Received: from zimbra.dewire.com ([127.0.0.1])
	by localhost (zimbra.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QS-ieiDZ4DI8; Mon, 21 Jan 2013 16:00:23 +0100 (CET)
Received: from zimbra.dewire.com (zimbra.dewire.com [10.1.2.96])
	by zimbra.dewire.com (Postfix) with ESMTP id 7B3E982608;
	Mon, 21 Jan 2013 16:00:23 +0100 (CET)
In-Reply-To: <1358769611-3625-1-git-send-email-Matthieu.Moy@imag.fr>
X-Originating-IP: [213.67.12.15]
X-Mailer: Zimbra 7.2.0_GA_2681 (ZimbraWebClient - FF3.0 (Mac)/7.2.0_GA_2681)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214122>



----- Ursprungligt meddelande -----
> Most git commands that can be used with our without a filepattern are
> tree-wide by default, the filepattern being used to restrict their
> scope.
> A few exceptions are: 'git grep', 'git clean', 'git add -u' and 'git
> add -A'.
> 
> The inconsistancy of 'git add -u' and 'git add -A' are particularly
> problematic since other 'git add' subcommands (namely 'git add -p'
> and
> 'git add -e') are tree-wide by default.
> 
> Flipping the default now is unacceptable, so this patch starts
> training
> users to type explicitely 'git add -u|-A :/' or 'git add -u|-A .', to
> prepare
> for the next steps:
> 
> * forbid 'git add -u|-A' without filepattern (like 'git add' without
>   option)

git add -u without filepattern is, I believe very common, so no noisy
output there please.

git diff
#looks good
git add -u

-- robin
