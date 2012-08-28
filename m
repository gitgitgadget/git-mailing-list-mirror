From: Stephen Bash <bash@genarts.com>
Subject: Re: diff/merge tool that ignores whitespace changes
Date: Tue, 28 Aug 2012 13:40:39 -0400 (EDT)
Message-ID: <1679275990.100371.1346175639379.JavaMail.root@genarts.com>
References: <12945e4d-6a76-4c5d-a4ee-132552a5da4d@zcs>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Enrico Weigelt <enrico.weigelt@vnc.biz>
X-From: git-owner@vger.kernel.org Tue Aug 28 19:40:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6PmY-0006G6-Gu
	for gcvg-git-2@plane.gmane.org; Tue, 28 Aug 2012 19:40:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752846Ab2H1Rkr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Aug 2012 13:40:47 -0400
Received: from hq.genarts.com ([173.9.65.1]:18854 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752333Ab2H1Rkq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Aug 2012 13:40:46 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 09A75BE12C4;
	Tue, 28 Aug 2012 13:40:45 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qbJ1KAEf9Cwq; Tue, 28 Aug 2012 13:40:39 -0400 (EDT)
Received: from mail.hq.genarts.com (localhost [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 6A540BE1249;
	Tue, 28 Aug 2012 13:40:39 -0400 (EDT)
In-Reply-To: <12945e4d-6a76-4c5d-a4ee-132552a5da4d@zcs>
X-Mailer: Zimbra 7.2.0_GA_2669 (ZimbraWebClient - GC21 (Mac)/7.2.0_GA_2669)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204432>

----- Original Message -----
> From: "Enrico Weigelt" <enrico.weigelt@vnc.biz>
> Sent: Tuesday, August 28, 2012 12:26:39 PM
> Subject: diff/merge tool that ignores whitespace changes
> 
> I'm looking for a diff / merge tool that treats lines with
> only whitespace changes (trailing or leading whitespaces,
> linefeeds, etc) as equal.
> 
> The goal is to make reviews as well as merging or rebasing
> easier when things like indentions often change.
> 
> Does anybody know an solution for that ?

I use kdiff3 which has the option to ignore whitespace changes (bonus: I can use it on all three major OSes as my work requires).  It's GUI based, so that could be considered a downside to some.

I usually use a combination of Git's built-in diff and kdiff to check my work.

HTH,
Stephen
