From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: libreoffice merge(tool?) issue #3 ...
Date: Tue, 22 Feb 2011 10:55:17 -0500
Message-ID: <993F66D7-7659-4AA5-9931-1EB66CAA01DB@silverinsanity.com>
References: <1298388877.32648.171.camel@lenovo-w500>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, kendy@novell.com,
	Norbert Thiebaud <nthiebaud@gmail.com>
To: michael.meeks@novell.com
X-From: git-owner@vger.kernel.org Tue Feb 22 17:01:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrugK-0005GA-HF
	for gcvg-git-2@lo.gmane.org; Tue, 22 Feb 2011 17:01:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754409Ab1BVQBi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Feb 2011 11:01:38 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:45045 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753557Ab1BVQBi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Feb 2011 11:01:38 -0500
X-Greylist: delayed 377 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Feb 2011 11:01:38 EST
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 987A31FFC157; Tue, 22 Feb 2011 15:55:16 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.5 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.5
Received: from [129.21.210.223] (bcg2784.student.rit.edu [129.21.210.223])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id 8F96D1FFC114;
	Tue, 22 Feb 2011 15:55:15 +0000 (UTC)
In-Reply-To: <1298388877.32648.171.camel@lenovo-w500>
X-Mailer: Apple Mail (2.1082)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167559>


On Feb 22, 2011, at 10:34 AM, Michael Meeks wrote:

> PS. of course, perhaps this is 'just me' - for space / time /
> simplicty / certainty reasons, I do a lot of "cp -lR foo/.git baa/" to
> duplicate trees - but AFAIK all git operations are atomic and use
> renames rather than in-place re-writing: right ?

FYI: `git clone foo bar` will use hard-links to copy the object files and is both very fast and space efficient.  (See the description of `--local` in git-clone(1), which is used by default for local repositories since git 1.5.3.)  It's also guaranteed to work while the correctness of `cp -lR` depends on implementation details of git.

~~ Brian