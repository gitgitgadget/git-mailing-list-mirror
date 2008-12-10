From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH 2/3] gitweb: Cache $parent_commit info in git_blame()
Date: Wed, 10 Dec 2008 12:49:01 +0900
Message-ID: <20081210124901.6117@nanako3.lavabit.com>
References: <20081209224622.28106.89325.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, Luben Tuikov <ltuikov@yahoo.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 10 04:51:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAG6G-0008Bo-Bg
	for gcvg-git-2@gmane.org; Wed, 10 Dec 2008 04:51:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754675AbYLJDtj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2008 22:49:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754634AbYLJDtj
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Dec 2008 22:49:39 -0500
Received: from karen.lavabit.com ([72.249.41.33]:42599 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754601AbYLJDti (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2008 22:49:38 -0500
Received: from d.earth.lavabit.com (d.earth.lavabit.com [192.168.111.13])
	by karen.lavabit.com (Postfix) with ESMTP id D7F76C888A;
	Tue,  9 Dec 2008 21:49:37 -0600 (CST)
Received: from 2870.lavabit.com (212.62.97.23)
	by lavabit.com with ESMTP id 2LHVOHH2TU4U; Tue, 09 Dec 2008 21:49:37 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=1Qv8ePCffwgGrS79Hrk9m+/5jDgcDagvV9D5bxK+dBIFPrp30vdSKrFjFr9r1LTMPpwrZb0x8klA3W3/VnfnWbfdEi9M/1IWea01qRXjJ4F+DPPy6LRtanGGgA/9wXlw/m5inJVfeRKvGXSv1E0bvIF6x5UJye6dDqke6xUpUs8=;
  h=From:To:Cc:Subject:Date:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <20081209224622.28106.89325.stgit@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102665>

Quoting Jakub Narebski <jnareb@gmail.com>:

> Unfortunately the implementation in 244a70e used one call for
> git-rev-parse to find parent revision per line in file, instead of
> using long lived "git cat-file --batch-check" (which might not existed
> then), or changing validate_refname to validate_revision and made it
> accept <rev>^, <rev>^^, <rev>^^^ etc. syntax.

Could you substantiate why this is "Unfortunate"?  Is the new implementation faster?  By how much?

When "previous" commit information is available in the output from "git blame", can you make use of it?

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
