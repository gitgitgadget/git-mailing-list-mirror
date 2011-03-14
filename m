From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: Git workflow for beta/production
Date: Mon, 14 Mar 2011 16:10:59 -0700
Message-ID: <868vwh47ss.fsf@red.stonehenge.com>
References: <324BE2A8-5987-4324-AE27-D5CC01341710@appnexus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Joseph Huttner <jhuttner@appnexus.com>
X-From: git-owner@vger.kernel.org Tue Mar 15 00:18:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzH1n-0004cS-It
	for gcvg-git-2@lo.gmane.org; Tue, 15 Mar 2011 00:18:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757504Ab1CNXSL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2011 19:18:11 -0400
Received: from lax-gw12.mailroute.net ([199.89.0.112]:40774 "EHLO
	mail.mroute.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757483Ab1CNXSJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2011 19:18:09 -0400
X-Greylist: delayed 425 seconds by postgrey-1.27 at vger.kernel.org; Mon, 14 Mar 2011 19:18:09 EDT
Received: from localhost (localhost [127.0.0.1])
	by lax-gw12.mroute.net (Postfix) with ESMTP id 46718327064B;
	Mon, 14 Mar 2011 23:11:00 +0000 (UTC)
X-Virus-Scanned: by MailRoute
Received: from red.stonehenge.com (red.stonehenge.com [208.79.95.2])
	by lax-gw12.mroute.net (Postfix) with ESMTP id CBE3B327063C;
	Mon, 14 Mar 2011 23:10:59 +0000 (UTC)
Received: by red.stonehenge.com (Postfix, from userid 1001)
	id A3D233C31; Mon, 14 Mar 2011 16:10:59 -0700 (PDT)
x-mayan-date: Long count = 12.19.18.3.12; tzolkin = 6 Eb; haab = 5 Cumku
In-Reply-To: <324BE2A8-5987-4324-AE27-D5CC01341710@appnexus.com> (Joseph
	Huttner's message of "Mon, 14 Mar 2011 15:27:22 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169035>

>>>>> "Joseph" == Joseph Huttner <jhuttner@appnexus.com> writes:

Joseph> The catch is that after a feature has been stomped on in Beta,
Joseph> it **may** go to Production, but only if Product Managers still
Joseph> think it is an important feature.  In other words, there is no
Joseph> guarantee that a feature in Beta will ever make it to
Joseph> Production.  It may be axed completely, in which case it would
Joseph> never get to Production and would be taken out of Beta.  Also,
Joseph> there is no guarantee that features that do make it to
Joseph> Production will go in in the order that they went in to Beta.

Sounds like you want the same sort of workflow that git itself uses,
with topic branches.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Smalltalk/Perl/Unix consulting, Technical writing, Comedy, etc. etc.
See http://methodsandmessages.posterous.com/ for Smalltalk discussion
