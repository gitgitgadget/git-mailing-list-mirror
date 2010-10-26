From: Eric Raible <raible@nextest.com>
Subject: Re: How do I get a list of all unmerged files?
Date: Tue, 26 Oct 2010 10:06:35 -0700
Message-ID: <4CC70A9B.4030801@nextest.com>
References: <20101026143245.11433.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: George Spelvin <linux@horizon.com>
X-From: git-owner@vger.kernel.org Tue Oct 26 19:06:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PAmyw-0001j7-8a
	for gcvg-git-2@lo.gmane.org; Tue, 26 Oct 2010 19:06:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758164Ab0JZRGg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Oct 2010 13:06:36 -0400
Received: from pops.nextest.com ([12.96.234.114]:10501 "EHLO
	Exchange.DOMAIN1.nextest.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751796Ab0JZRGg (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Oct 2010 13:06:36 -0400
Received: from [131.101.20.211] (131.101.20.211) by
 Exchange.DOMAIN1.nextest.com (131.101.21.39) with Microsoft SMTP Server (TLS)
 id 8.2.254.0; Tue, 26 Oct 2010 10:06:35 -0700
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.9) Gecko/20100915 Lightning/1.0b2 Thunderbird/3.1.4
In-Reply-To: <20101026143245.11433.qmail@science.horizon.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160001>

On 11:59 AM, George Spelvin wrote:
> After a merge with conflicts, mostly resolved by rerere, I want to pass a list of
> all unmerged files to the editor for manual review.
> 
> I can see the list (wrapped in a bunch of inconvenient human-readable cruft)
> in "git status".  I can also get a list (again with a bunch of extraneous
> info) from "git ls-files -u".  What I can't figure out is how to get
> "git ls-files -u" with --stage turned *off*.
> 
> I'm sure this exists somewhere, but I can't find it.  Can someone enlighten
> me?
> 
> vim `git command here`
> 
> Thank you.

It's not exactly what you asked for but this might
give you what you want:

	git config merge.tool vim
	git mergetool

HTH - Eric
