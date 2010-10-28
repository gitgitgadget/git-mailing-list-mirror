From: lists@haller-berlin.de (Stefan Haller)
Subject: Re: Why the default action for pull is merge, but not rebase?
Date: Thu, 28 Oct 2010 09:27:29 +0200
Message-ID: <1jr2fbt.1sik9wjkrc2tpM%lists@haller-berlin.de>
References: <4CC87DE6.9090604@nextest.com>
Cc: Euguess@gmail.com, git@vger.kernel.org
To: raible@nextest.com (Eric Raible),
	jrnieder@gmail.com (Jonathan Nieder)
X-From: git-owner@vger.kernel.org Thu Oct 28 09:27:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBMth-0004lf-Oa
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 09:27:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757760Ab0J1H1e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Oct 2010 03:27:34 -0400
Received: from mail.ableton.net ([62.96.12.115]:41381 "EHLO mail.ableton.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756088Ab0J1H1d (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Oct 2010 03:27:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=haller-berlin.de; s=mail_2009081900;
	h=Message-ID:Date:From:Subject:In-Reply-To:Cc:To; bh=44w+mEmagbI09KzRmoiwJrmTQDLWO8MWpkgL0RwETo0=;
	b=quNRkF6Xi6TAe+xLM2pzxkx1Tdh4Vh18I1sfudx9IIfe+X/bPD3xkHk4x9ZHHk15ybV2VvS1PqYHJ1FY2P4IIlMwsHuDLQduQKgJBMDOZn7I8SyjeAZg4qT39AY1bTOOWUL/jhIFIu3Jr//BIWzhF5xoMJWpYLtVDSqRj1FvVc4=;
Received: from dslb-088-074-024-169.pools.arcor-ip.net ([88.74.24.169] helo=[192.168.42.92])
	by mail.ableton.net with esmtpsa (SSLv3:AES128-SHA:128)
	(Exim 4.72)
	(envelope-from <lists@haller-berlin.de>)
	id 1PBMtW-00017J-98; Thu, 28 Oct 2010 09:27:30 +0200
In-Reply-To: <4CC87DE6.9090604@nextest.com>
User-Agent: MacSOUP/2.8.3 (Mac OS X version 10.6.4 (x86))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160161>

Eric Raible <raible@nextest.com> wrote:

> On 11:59 AM, Jonathan Nieder wrote:
>
> > Maybe the "[branch "<name>"] rebase" and "[branch] autosetuprebase"
> > configuration items could help.
> 
> One frustrating aspect of branch.<name>.rebase is that AFAIK
> there's no way for it to preserve merges.
> 
> I would much prefer if branch.<name>.rebase was allowed to
> specify the arguments to be passed to rebase:
> 
>   git config branch.mybranch.rebase "-i --preserve-merges"

For me it would be good enough if there were some way of making
"pull --rebase" error out in the case that merges are involved.  I'll
then either do a pull --no-rebase, or deal with the situation in some
other way; but getting the merge "flattened" by "git pull" without being
told about it is what's frustrating to me.


-- 
Stefan Haller
Berlin, Germany
http://www.haller-berlin.de/
