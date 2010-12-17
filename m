From: Ken Brownfield <krb@irridia.com>
Subject: Re: Performance issue exposed by git-filter-branch
Date: Thu, 16 Dec 2010 18:31:52 -0800
Message-ID: <1FBB24BF-6517-4906-99D5-A5DDBEA14D6D@irridia.com>
References: <41C1B4AC-8427-4D62-BEB6-689A4BE4EE5B@irridia.com> <20101217014539.GA6775@burratino>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: David Barr <david.barr@cordelta.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 17 03:32:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTQ6x-0005sC-2w
	for gcvg-git-2@lo.gmane.org; Fri, 17 Dec 2010 03:31:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752069Ab0LQCby (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Dec 2010 21:31:54 -0500
Received: from endymion.irridia.com ([184.105.192.220]:30966 "EHLO
	endymion.irridia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751345Ab0LQCbx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Dec 2010 21:31:53 -0500
Received: from shrike2.sfo.corp.google.com (unknown [72.14.229.84])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by endymion.irridia.com (Postfix) with ESMTPSA id 2069A14561D;
	Thu, 16 Dec 2010 18:31:53 -0800 (PST)
In-Reply-To: <20101217014539.GA6775@burratino>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163852>

The thread titled "git and larger trees, not so fast?".  Some of the history is lost, but here's the earliest post I can find:

http://lists-archives.org/git/627040-git-and-larger-trees-not-so-fast.html

On GMANE:
http://article.gmane.org/gmane.comp.version-control.git/55460/match=git+larger+trees+not+so+fast

But I can't figure out how to show the whole thread.

Sorry, that paragraph of my email disappeared. :-(

Ken

On Dec 16, 2010, at 5:45 PM, Jonathan Nieder wrote:

> Hi Ken,
> 
> Ken Brownfield wrote:
> 
>> Is there a way to apply the optimizations mentioned in that old
>> thread to the code paths used by git-filter-branch (mainly git-read
>> and git-rm, seemingly), or is there another way to investigate and
>> improve the performance of the filter?
> 
> Which old thread?
> 
> You might be able to get faster results using the approach of [1]
> (using "git cat-file --batch-check" to collect the trees you want
> and "git fast-import" to paste them together), which avoids unpacking
> trees when not needed.
> 
> Hope that helps,
> Jonathan
> 
> [1] http://repo.or.cz/w/git/barrbrain/github.git/commitdiff/db-svn-filter-root
