From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH 1/3] gitweb: Refactor 'log' action generation, adding git_log_body()
Date: Sat, 14 Nov 2009 08:10:50 +0900
Message-ID: <20091114081050.6117@nanako3.lavabit.com>
References: <1258074134-27011-1-git-send-email-jnareb@gmail.com>
	<1258074134-27011-2-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 14 00:14:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N95M3-0000kO-3m
	for gcvg-git-2@lo.gmane.org; Sat, 14 Nov 2009 00:14:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932394AbZKMXOr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2009 18:14:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932303AbZKMXOq
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Nov 2009 18:14:46 -0500
Received: from karen.lavabit.com ([72.249.41.33]:57000 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932277AbZKMXOq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2009 18:14:46 -0500
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id D5E6411B86F;
	Fri, 13 Nov 2009 17:14:50 -0600 (CST)
Received: from 1998.lavabit.com (customer-148-233-239-23.uninet.net.mx [148.233.239.23])
	by lavabit.com with ESMTP id YB0H83FQ1GIB; Fri, 13 Nov 2009 17:14:50 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=h+l3L9zCjJEVQASAcsLtwO6kJtTv3W9TsK5jKqeTzowVDjLPGLiCp+7tmP0FO9TiJMHtTU00sFuslzcMBFk9d8UbyUvle5XhI1rcqfMis/uFQYio1f6TLVdN8uSSwHoXSKIvTuHlngh/XLtjOuaD0/oZcL9zyHzNZXjYa4KacK4=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <1258074134-27011-2-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132849>

Quoting Jakub Narebski <jnareb@gmail.com>

> Put the main part of 'log' view generation into git_log_body,
> similarly how it is done for 'shortlog' and 'history' views (and
> also for 'tags' and 'heads' views).
>
> This is preparation for extracting common code between 'log',
> 'shortlog' and 'history' actions.
>
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> ---
> This is pure refactoring: output should change.

Did you mean "should not change"?

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
