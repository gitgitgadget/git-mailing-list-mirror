From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: Visualizing merge conflicts after the fact (using kdiff3)
Date: Mon, 6 Jul 2015 21:38:13 +0200
Message-ID: <559AD925.9030408@gmail.com>
References: <557F791D.3080003@nextest.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 06 21:38:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCCE3-00075R-59
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jul 2015 21:38:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753425AbbGFTin (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2015 15:38:43 -0400
Received: from plane.gmane.org ([80.91.229.3]:53097 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752765AbbGFTim (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2015 15:38:42 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1ZCCDv-00070k-Oa
	for git@vger.kernel.org; Mon, 06 Jul 2015 21:38:39 +0200
Received: from p5b156072.dip0.t-ipconnect.de ([91.21.96.114])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 06 Jul 2015 21:38:39 +0200
Received: from sschuberth by p5b156072.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 06 Jul 2015 21:38:39 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: p5b156072.dip0.t-ipconnect.de
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12)
 Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
In-Reply-To: <557F791D.3080003@nextest.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273451>

On 16.06.2015 03:17, Eric Raible wrote:

> So naturally I want to check each of them for correctness.

Sorry for joining this thread so late, I only come to know about it from the draft of the upcoming Git Rev News 5 [1].

A while ago Robin Green was asking a very similar question on StackOverflow [2], and I came up with a script called "git-show-merge-resolution.sh" [3]. Maybe that's something you're interested in, too.

[1] https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-5.md#support
[2] stackoverflow.com/questions/24958182/kdiff3-to-code-review-merge-commit/24958228
[3] https://github.com/sschuberth/dev-scripts/blob/master/git/git-show-merge-resolution.sh

-- 
Sebastian Schuberth
