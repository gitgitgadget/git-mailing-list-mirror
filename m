From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: t9118 broken in current master, 9918285, git/git/v1.7.2-rc2
Date: Wed, 7 Jul 2010 23:42:53 -0400
Message-ID: <8E6B46F9-41B7-4902-8910-A13144005C12@silverinsanity.com>
References: <4C352EB5.5020005@gmail.com> <68AF81DF-7434-4493-8FBF-6DDEF27BFAB1@silverinsanity.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: gitzilla@gmail.com, git@vger.kernel.org
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Thu Jul 08 05:43:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWi0w-0001Vy-SK
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 05:43:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755454Ab0GHDnA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jul 2010 23:43:00 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:51179 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755441Ab0GHDm7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Jul 2010 23:42:59 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 3183F1FFC058; Thu,  8 Jul 2010 03:42:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [10.10.10.10] (cpe-74-67-185-155.rochester.res.rr.com [74.67.185.155])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id 6FCC51FFC056;
	Thu,  8 Jul 2010 03:42:45 +0000 (UTC)
In-Reply-To: <68AF81DF-7434-4493-8FBF-6DDEF27BFAB1@silverinsanity.com>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150532>


On Jul 7, 2010, at 11:15 PM, Brian Gernhardt wrote:

> I'm getting intermittent errors in t9115 instead.

Okay, but intermittent I mean that I had SVN_HTTPD_PORT defined in one place and not the other.  It actually caused failures in tests 9115, 9120, 9142.  Running tests in parallel appears to break the SVN httpd setup and teardown.

~~ Brian