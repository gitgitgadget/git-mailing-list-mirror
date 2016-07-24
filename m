Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18B8C203E1
	for <e@80x24.org>; Sun, 24 Jul 2016 18:12:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752240AbcGXSMa (ORCPT <rfc822;e@80x24.org>);
	Sun, 24 Jul 2016 14:12:30 -0400
Received: from plane.gmane.org ([80.91.229.3]:46643 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752005AbcGXSM3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2016 14:12:29 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1bRNt3-0005R1-OV
	for git@vger.kernel.org; Sun, 24 Jul 2016 20:12:25 +0200
Received: from c-71-202-183-39.hsd1.ca.comcast.net ([71.202.183.39])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 24 Jul 2016 20:12:25 +0200
Received: from nobozo by c-71-202-183-39.hsd1.ca.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 24 Jul 2016 20:12:25 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:	git@vger.kernel.org
From:	Jon Forrest <nobozo@gmail.com>
Subject: [RFC] A Change to Commit IDs Too Ridiculous to Consider?
Date:	Sun, 24 Jul 2016 11:12:12 -0700
Message-ID: <nn30dv$5sn$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: c-71-202-183-39.hsd1.ca.comcast.net
X-Mozilla-News-Host: news://www.gmane.org:119
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


Those of us who write instructional material about Git all face the same problem.
This is that we can't write step by step instructions that show the results of
making a commit because users will always see different commit IDs.
This is fundamental to the design of Git.

Even if the instructional material tells users to use standard author and committer
information, (e.g. john.doe@example.com) and shows the text of the file being committed
and the commit message to add, the resulting commit ID will differ from reader to reader
since the commit will presumably take place at different times.

What if it were possible, for instructional purposes only, to somehow tell Git to relax
this requirement. By this I mean, the commit date would *not* be included when constructing
the commit ID. This would allow tutorials to show exactly what to expect to see when running commands.

I realize that questions would remain such as how to turn on this behavior (e.g. command line flags,
environment variables) and whether 'git log' (and maybe other commands) should somehow distinguish these
mutant commits. There would probably be other issues to consider.

Again, this is for instructional purposes only, and only when the committer explicitly
chooses to use this option. I'm *not* proposing a general change to Git's behavior.

Is such a thing to ridiculous to even consider? Is there a better way to achieve the same result?

Jon Forrest


