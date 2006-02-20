From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Should we support Perl 5.6?
Date: Mon, 20 Feb 2006 19:37:28 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0602201934270.28957@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Feb 20 19:37:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBFug-0005Lm-O0
	for gcvg-git@gmane.org; Mon, 20 Feb 2006 19:37:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161114AbWBTSha (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Feb 2006 13:37:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161116AbWBTSha
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Feb 2006 13:37:30 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:43162 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1161115AbWBTSh3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2006 13:37:29 -0500
Received: from virusscan.mail (amavis2.rz.uni-wuerzburg.de [132.187.3.47])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id DB62A1444FE
	for <git@vger.kernel.org>; Mon, 20 Feb 2006 19:37:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id C71E786E0
	for <git@vger.kernel.org>; Mon, 20 Feb 2006 19:37:28 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id A52461444FE
	for <git@vger.kernel.org>; Mon, 20 Feb 2006 19:37:28 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16487>

Hi,

I just had a failure when pulling, because since a few days (to be exact, 
since commit 1cb30387, git-fmt-merge-msg uses a syntax which is not 
understood by Perl 5.6.

It is this:

	open $fh, '-|', 'git-symbolic-ref', 'HEAD' or die "$!";

I know that there was already some discussion on this list, but I don't 
remember if we decided on leaving 5.6 behind or not.

Somebody remembers?

Ciao,
Dscho
