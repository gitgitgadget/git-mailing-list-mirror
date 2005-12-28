From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-inject-tarball
Date: Wed, 28 Dec 2005 17:18:30 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0512281717040.28473@wbgn013.biozentrum.uni-wuerzburg.de>
References: <pan.2005.12.28.02.40.14.577883@progsoc.org>
 <Pine.LNX.4.63.0512281230070.15184@wbgn013.biozentrum.uni-wuerzburg.de>
 <43B2B474.1000603@hogyros.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Anand Kumria <wildfire@progsoc.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 28 17:19:06 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ere0Y-0002fT-W2
	for gcvg-git@gmane.org; Wed, 28 Dec 2005 17:18:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964854AbVL1QSc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Dec 2005 11:18:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932534AbVL1QSc
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Dec 2005 11:18:32 -0500
Received: from wrzx35.rz.uni-wuerzburg.de ([132.187.3.35]:22410 "EHLO
	wrzx35.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932532AbVL1QSc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Dec 2005 11:18:32 -0500
Received: from amavis.mail (amavis2.rz.uni-wuerzburg.de [132.187.3.47])
	by wrzx35.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 0239DE4182; Wed, 28 Dec 2005 17:18:31 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by amavis.mail (Postfix) with ESMTP id EA5292B62;
	Wed, 28 Dec 2005 17:18:30 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by amavis.mail (Postfix) with ESMTP id CFFD427CA;
	Wed, 28 Dec 2005 17:18:30 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id A0C6E141606; Wed, 28 Dec 2005 17:18:30 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Simon Richter <Simon.Richter@hogyros.de>
In-Reply-To: <43B2B474.1000603@hogyros.de>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
X-Spam-Status: No, hits=0.0 tagged_above=0.0 required=8.0 tests=
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14101>

Hi,

On Wed, 28 Dec 2005, Simon Richter wrote:

> Well, the most important thing for such a tool IMO would be that it wouldn't
> overwrite any uncommitted changes, so it's not as trivial as it seems.

Ah, but that's easy:

	test -z "$(git-diff-index --name-only HEAD)" || exit 1

(This is just the idea; you should also output an error message.)

Hth,
Dscho
