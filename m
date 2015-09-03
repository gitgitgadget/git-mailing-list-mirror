From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Do you plan to release 2.5.2 any time soon?
Date: Thu, 03 Sep 2015 12:00:42 -0700
Message-ID: <xmqqbndjjpk5.fsf@gitster.mtv.corp.google.com>
References: <alpine.DEB.1.00.1509030038460.16897@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Sep 03 21:00:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXZke-0003gi-Jn
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 21:00:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752823AbbICTAp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2015 15:00:45 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:33566 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751332AbbICTAo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2015 15:00:44 -0400
Received: by pacex6 with SMTP id ex6so49916458pac.0
        for <git@vger.kernel.org>; Thu, 03 Sep 2015 12:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version:content-type;
        bh=8YNLSwE8dAX5YlqYGr4Y09/+4xUDdI6ZjJc/DCNvgzo=;
        b=eRoP7dh18dnAihgfWCq6JHJNp0C5G2J5U/BlLjf9NxSJlyLBtzJ+GjkySIKiS5kT5d
         6tM/bG1XHRPTCY+Y9gnRC/6AZC5v4U4Nnva9dygGO9cup6Nl9bDVPO55a2qH/gjjj/xh
         EDsAAhswpBkJSyUV+8pwPUH5s5YKHuKWU375MD8ITOWK2wCRjYtHwRMijVgjKjVpUZFX
         sVQM6lk8GMuqm4jg7DLxcDyWQ2LQZayrP+4wT5SO6OVa1pKb6EsLm11jJWqgyjjuFu8t
         I7FyRR670CPbJahtM3aF8HRsM/ArBwra0dbdPmNvv45w6zpE5TNRxe+3OZxRkfnWe+tL
         iMyQ==
X-Received: by 10.68.162.99 with SMTP id xz3mr71944380pbb.134.1441306844210;
        Thu, 03 Sep 2015 12:00:44 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:71da:b56c:f873:e611])
        by smtp.gmail.com with ESMTPSA id fz8sm16923882pdb.0.2015.09.03.12.00.43
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Thu, 03 Sep 2015 12:00:43 -0700 (PDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277239>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I have a couple of fixes lined up for bugs in Git for Windows 2.5.1. Do
> you plan to release 2.5.2 any time soon? If yes, I would hold off,
> otherwise I will just do a Git for Windows 2.5.1 (Rel 2).

Among the topics marked for possible later merging to 'maint' in the
draft release notes to 2.6, candidates for future maintenance
snapshots are:

* mh/get-remote-group-fix # 4 (2 weeks ago) 
* cb/open-noatime-clear-errno # 1 (9 days ago) 
* jk/long-error-messages # 2 (9 days ago) 
* jh/strbuf-read-use-read-in-full # 1 (9 days ago) 
* ps/t1509-chroot-test-fixup # 2 (2 weeks ago) 
* sg/help-group # 1 (8 days ago) 
* nd/dwim-wildcards-as-pathspecs # 1 (9 days ago) 
* jk/fix-alias-pager-config-key-warnings # 1 (3 days ago) 
* jk/rev-list-has-no-notes # 1 (3 days ago) 
* nd/fixup-linked-gitdir # 1 (2 days ago) 
* as/docfix-reflog-expire-unreachable # 1 (8 days ago) 
* sg/t3020-typofix # 1 (8 days ago) 
* po/po-readme # 1 (8 days ago) 
* sg/wt-status-header-inclusion # 1 (8 days ago) 
* ss/fix-config-fd-leak # 1 (8 days ago) 
* jc/calloc-pathspec # 1 (8 days ago) 
* rs/archive-zip-many # 3 (2 days ago) 
* dt/commit-preserve-base-index-upon-opportunistic-cache-tree-update # 1 (2 days ago) 
* cc/trailers-corner-case-fix # 3 (22 hours ago) 
* jk/log-missing-default-HEAD # 1 (22 hours ago) 
* ee/clean-test-fixes # 1 (22 hours ago) 

These I deem are safe (not just the changes themselves are trivially
correct but it is unlikely to make things gravely worse if it turns
out there were ramifications no reviewers thought about with them)
and can go in 2.5.2.

As to other topics that are in 'master' but not in the above list, I
do not have doubt about their value (otherwise they would not be in
'master' in the first place), but either they are still too young in
'master' or are with sufficiently big impact on the callchain that
it is not entirely implausible that they have risks of unforeseen
ramifications and fallouts.

Let's aim to tag 2.5.2 soonish, before mid next-week at the latest.
