From: Kazutoshi Satoda <k_satoda@f2.dion.ne.jp>
Subject: Re: [PATCH] tests: remove unused full-svn-test target
Date: Tue, 23 Feb 2016 01:01:55 +0900
Message-ID: <56CB30F3.40908@f2.dion.ne.jp>
References: <20160222030814.GA18817@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Feb 22 17:02:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXswC-0002v2-Mv
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 17:02:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752616AbcBVQCM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 11:02:12 -0500
Received: from mail-ae1-f13.auone-net.jp ([106.187.231.13]:39528 "EHLO
	dmta03.auone-net.jp" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752542AbcBVQCL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 11:02:11 -0500
Received: from amlmta052.auone-net.jp (amlmta052-MM [10.188.23.115])
	by dmta03.auone-net.jp (au one net mail) with ESMTP id 97CE7DA008C
	for <git@vger.kernel.org>; Tue, 23 Feb 2016 01:02:09 +0900 (JST)
Received: from [0.0.0.0] ([176.31.45.7])
	by amlmta052.auone-net.jp id 56cb30fc000bd5ec00006394000012fb100009d9e58e;
	Tue, 23 Feb 2016 01:02:04 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <20160222030814.GA18817@dcvr.yhbt.net>
X-MXM-DELIVERY-TYPE: 3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286932>

On 2016/02/22 12:08 +0900, Eric Wong wrote:
> git-svn has not supported GIT_SVN_NO_OPTIMIZE_COMMITS for
> the "set-tree" sub-command in 9 years since commit 490f49ea5899
> ("git-svn: remove optimized commit stuff for set-tree").
> 
> So remove this target to avoid confusion.

> diff --git a/t/Makefile b/t/Makefile
> index 43b15e3..ad97a7e 100644
...
> -# we can test NO_OPTIMIZE_COMMITS independently of LC_ALL
> -full-svn-test:
> -	$(MAKE) $(TSVN) GIT_SVN_NO_OPTIMIZE_COMMITS=1 LC_ALL=C
> -	$(MAKE) $(TSVN) GIT_SVN_NO_OPTIMIZE_COMMITS=0 LC_ALL=en_US.UTF-8

The variable TSVN becomes unused by this removal. It should be removed
together, shouldn't it?

-- 
k_satoda
