From: Stephen Bash <bash@genarts.com>
Subject: Re: error: refs/tags/2.0.9 does not point to a valid object!
Date: Mon, 18 Oct 2010 16:31:43 -0400 (EDT)
Message-ID: <23120755.523391.1287433903205.JavaMail.root@mail.hq.genarts.com>
References: <AANLkTi=JgVhkNVu70nW7_vbqWUsS=mnJGQDVBtm-dxJD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Mathieu Malaterre <mathieu.malaterre@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 18 22:31:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7wNA-0000p9-P6
	for gcvg-git-2@lo.gmane.org; Mon, 18 Oct 2010 22:31:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757622Ab0JRUbv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Oct 2010 16:31:51 -0400
Received: from hq.genarts.com ([173.9.65.1]:7717 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755870Ab0JRUbv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Oct 2010 16:31:51 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 8D83F1E26355;
	Mon, 18 Oct 2010 16:31:49 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ubJk7P2mdG28; Mon, 18 Oct 2010 16:31:43 -0400 (EDT)
Received: from mail.hq.genarts.com (mail.hq.genarts.com [10.102.202.62])
	by mail.hq.genarts.com (Postfix) with ESMTP id 4DED61E26211;
	Mon, 18 Oct 2010 16:31:43 -0400 (EDT)
In-Reply-To: <AANLkTi=JgVhkNVu70nW7_vbqWUsS=mnJGQDVBtm-dxJD@mail.gmail.com>
X-Mailer: Zimbra 6.0.7_GA_2473.UBUNTU8 (ZimbraWebClient - SAF3 (Mac)/6.0.7_GA_2473.UBUNTU8)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159286>



----- Original Message -----
> From: "Mathieu Malaterre" <mathieu.malaterre@gmail.com>
> To: git@vger.kernel.org
> Sent: Monday, October 18, 2010 3:23:57 PM
> Subject: error: refs/tags/2.0.9 does not point to a valid object!
> 
> I am trying to convert a SVN repository to GIT.
> 
> The filter ran for a couple of hours. But after the conversion I get
> the following:
> 
> Initialized empty Git repository in /tmp/bla/.git/
> remote: Counting objects: 59368, done.
> remote: Compressing objects: 100% (25408/25408), done.
> remote: Total 59368 (delta 43461), reused 44204 (delta 33809)
> Receiving objects: 100% (59368/59368), 14.40 MiB | 14.27 MiB/s, done.
> Resolving deltas: 100% (43461/43461), done.
> error: refs/tags/2.0.9 does not point to a valid object!
> error: refs/tags/2.0.8 does not point to a valid object!
> error: refs/tags/2.0.7 does not point to a valid object!
> error: refs/tags/2.0.6 does not point to a valid object!
> error: refs/tags/2.0.5 does not point to a valid object!
> error: refs/tags/2.0.4 does not point to a valid object!
> error: refs/tags/2.0.16 does not point to a valid object!
> error: refs/tags/2.0.15 does not point to a valid object!
> error: refs/tags/2.0.14 does not point to a valid object!
> error: refs/tags/2.0.13 does not point to a valid object!
> error: refs/tags/2.0.12 does not point to a valid object!
> error: refs/tags/2.0.11 does not point to a valid object!
> error: refs/tags/2.0.10 does not point to a valid object!
> 
> Could someone please let me know what I am doing wrong in my script
> in filter-branch.

Yep, I ran into the exact same problem.  Short answer, move/remove the refs/original directory before cloning, and the issue should go away.

http://kerneltrap.org/mailarchive/git/2010/8/20/37441

There was also a proposed test case:

http://kerneltrap.org/mailarchive/git/2010/9/7/39119

HTH,
Stephen
