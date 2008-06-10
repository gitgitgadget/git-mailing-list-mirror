From: Andrew Klossner <andrew@cesa.opbu.xerox.com>
Subject: Re: git clone stable-2.6.25.y fails over HTTP
Date: Tue, 10 Jun 2008 08:05:05 -0700
Message-ID: <200806101505.m5AF5525024775@pogo.cesa.opbu.xerox.com>
To: greg@kroah.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 10 17:26:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K65jX-0001Na-63
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 17:26:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751652AbYFJPZJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 11:25:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752767AbYFJPZJ
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 11:25:09 -0400
Received: from wbmler2.mail.xerox.com ([13.13.138.217]:42852 "EHLO
	wbmler2.mail.xerox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751652AbYFJPZI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2008 11:25:08 -0400
X-Greylist: delayed 1164 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Jun 2008 11:25:07 EDT
Received: from wbmlir1.mail.xerox.com (wbmlir1.mail.xerox.com [13.131.8.221])
	by wbmler2.mail.xerox.com (8.14.2/8.13.8) with ESMTP id m5AFEIS6022174;
	Tue, 10 Jun 2008 11:14:20 -0400
Received: from wbmlir1.mail.xerox.com (localhost [127.0.0.1])
	by wbmlir1.mail.xerox.com (8.14.2/8.13.6) with ESMTP id m5AF5AKQ007802;
	Tue, 10 Jun 2008 11:05:10 -0400
Received: from hermes.opbu.xerox.com (hermes.opbu.xerox.com [13.62.6.81])
	by wbmlir1.mail.xerox.com (8.14.2/8.13.6) with ESMTP id m5AF576H007783
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 10 Jun 2008 11:05:07 -0400
X-Xerox-Source-Ip: 13.62.6.81
X-Xerox-Source-Name: hermes.opbu.xerox.com
X-Xerox-Reported-Name: hermes.opbu.xerox.com
Received: from pogo.cesa.opbu.xerox.com (pogo.cesa.opbu.xerox.com [13.62.33.31])
	by hermes.opbu.xerox.com (8.13.7+Sun/8.13.7) with ESMTP id m5AF56UN004233;
	Tue, 10 Jun 2008 08:05:06 -0700 (PDT)
Received: from cesa.opbu.xerox.com (gto.cesa.opbu.xerox.com [13.62.136.98])
	by pogo.cesa.opbu.xerox.com (8.13.6+Sun/8.13.6) with ESMTP id m5AF5525024775;
	Tue, 10 Jun 2008 08:05:05 -0700 (PDT)
In-Reply-To: Your message of "Fri, 06 Jun 2008 14:54:00 PDT."
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84517>

Following up last week's problem with the stable-2.6.25.y tree:

>From the HTTP perspective, the tree is stuck in time.  The two new
tags v2.6.25.5 and v2.6.25.6 do not appear when I do this:

% git pull -v
From http://www.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.25.y
 = [up to date]      master     -> origin/master
Already up-to-date.

On my home machine, I verified that these tags appear as expected when
I pull with the git protocol.  But at work I'm behind a firewall and
am stuck with HTTP.

  -=- Andrew Klossner
