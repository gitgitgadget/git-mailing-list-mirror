From: Ed Avis <eda@waniasset.com>
Subject: Re: Log messages beginning # and git rebase -i
Date: Tue, 28 Jul 2015 09:51:40 +0000 (UTC)
Message-ID: <loom.20150728T115023-269@post.gmane.org>
References: <loom.20150727T133256-715@post.gmane.org> <CAPig+cRT6=YCHz+phfE+84y27ey-6ScjPxP2cHiVqumJmR6mOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 28 11:52:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZK1YH-00016H-C2
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 11:52:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755274AbbG1Jv4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 05:51:56 -0400
Received: from plane.gmane.org ([80.91.229.3]:41113 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752032AbbG1Jvz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 05:51:55 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1ZK1Y7-0000vN-LC
	for git@vger.kernel.org; Tue, 28 Jul 2015 11:51:52 +0200
Received: from 80.169.169.174 ([80.169.169.174])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 11:51:51 +0200
Received: from eda by 80.169.169.174 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 11:51:51 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 80.169.169.174 (Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:39.0) Gecko/20100101 Firefox/39.0 Cyberfox/39.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274763>

Eric Sunshine <sunshine <at> sunshineco.com> writes:

>>the editing for the
>>combined log message treats lines beginning with # as comments.  This means
>>that if you are not careful the commit message can get lost on rebasing.
>>
>>I suggest that git rebase should add an extra space at the start

>'git rebase --interactive' respects the core.commentChar configuration
>variable, which you can set to some value other than '#'.

I was thinking of the default configuration.  But you are right, this applies
to whatever the comment character is - so if commentChar is set to * for
example, then log lines beginning with * should get an extra space prepended
in git rebase --interactive so that they don't get lost.

-- 
Ed Avis <eda@waniasset.com> 
