From: Tim Chase <git@tim.thechases.com>
Subject: Preventing merges from one branch into others
Date: Thu, 7 Feb 2013 13:14:40 -0600
Message-ID: <20130207131440.716c1022@bigbox.christie.dr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 07 20:13:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3Wue-0007Qe-Pc
	for gcvg-git-2@plane.gmane.org; Thu, 07 Feb 2013 20:13:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166Ab3BGTNM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2013 14:13:12 -0500
Received: from boston.accountservergroup.com ([50.22.11.22]:48220 "EHLO
	boston.accountservergroup.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754503Ab3BGTNL (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Feb 2013 14:13:11 -0500
Received: from [108.223.140.164] (port=51182 helo=bigbox.christie.dr)
	by boston.accountservergroup.com with esmtpsa (TLSv1:DHE-RSA-AES128-SHA:128)
	(Exim 4.80)
	(envelope-from <git@tim.thechases.com>)
	id 1U3WuD-0005y9-Qf
	for git@vger.kernel.org; Thu, 07 Feb 2013 13:13:10 -0600
X-Mailer: Claws Mail 3.7.6 (GTK+ 2.20.1; x86_64-pc-linux-gnu)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - boston.accountservergroup.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - tim.thechases.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215712>

[tried IRC to no avail]
I've been trying to find a way to prevent myself from merging a
client-specific branch back into my dev/master branches.  Is there an
easy/straightforward way to do this (perhaps via a hook)?  I didn't
see any sort of "pre-merge" hook script.  Visualized:

  A -> B -> C [dev]
   \
    -> Q -> R -> S [customer-specific]

and I want to ensure that changes Q/R/S never find their way back
into dev.

So I was hoping some sort of "hey, you're an idiot for trying to merge
$CUSTOMER_BRANCH back into dev/master" warning. :-)

-tkc
