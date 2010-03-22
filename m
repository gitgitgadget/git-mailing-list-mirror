From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: Re: commit --amend neglecting return value
Date: Mon, 22 Mar 2010 01:20:20 -0400
Message-ID: <E139EF92-B047-4928-A390-D47224CAA3DB@gernhardtsoftware.com>
References: <20100322043616.GF21406@baikonur.stro.at> <196847A3-42CB-4CE8-8FFC-D7C8C8AFCDF7@gernhardtsoftware.com>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: maximilian attems <max@stro.at>, git@vger.kernel.org
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Mon Mar 22 06:20:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nta40-0005xg-Nw
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 06:20:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752537Ab0CVFU2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Mar 2010 01:20:28 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:46682 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751493Ab0CVFU1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Mar 2010 01:20:27 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 256DC1FFC2EE; Mon, 22 Mar 2010 05:20:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [10.10.10.10] (cpe-67-240-172-169.rochester.res.rr.com [67.240.172.169])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id 4233D1FFC133;
	Mon, 22 Mar 2010 05:20:12 +0000 (UTC)
In-Reply-To: <196847A3-42CB-4CE8-8FFC-D7C8C8AFCDF7@gernhardtsoftware.com>
X-Mailer: Apple Mail (2.1077)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142899>


On Mar 22, 2010, at 1:16 AM, Brian Gernhardt wrote:

> If you want to abort committing while editing the message, delete the entire message (in Vim: "0dG:wq^M") and git will reply "Aborting commit due to empty commit message."

Oops.  Obviously I meant "ggdG:wq^M".

Also, a quick search of :help and testing reveals that ":cq" causes Vim to exit with non-zero status which will cause git to abort the commit.

~~ Brian
