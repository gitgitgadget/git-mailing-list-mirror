From: Stephen Bash <bash@genarts.com>
Subject: Re: no autocrlf on Visual Studio subdirectory
Date: Wed, 15 Jun 2011 10:16:08 -0400 (EDT)
Message-ID: <5843516.7553.1308147368895.JavaMail.root@mail.hq.genarts.com>
References: <BANLkTikbnKNHxt5wKDjUWYby+p3w0cHcgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Aaron Gray <aaronngray.lists@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 15 16:16:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWqtO-0006iO-Eh
	for gcvg-git-2@lo.gmane.org; Wed, 15 Jun 2011 16:16:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754910Ab1FOOQR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2011 10:16:17 -0400
Received: from hq.genarts.com ([173.9.65.1]:54622 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754800Ab1FOOQQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2011 10:16:16 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 47D0815C8005;
	Wed, 15 Jun 2011 10:16:15 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iZfXyWmwMz1o; Wed, 15 Jun 2011 10:16:09 -0400 (EDT)
Received: from mail.hq.genarts.com (mail.hq.genarts.com [10.102.202.62])
	by mail.hq.genarts.com (Postfix) with ESMTP id ECA8515C8001;
	Wed, 15 Jun 2011 10:16:08 -0400 (EDT)
In-Reply-To: <BANLkTikbnKNHxt5wKDjUWYby+p3w0cHcgg@mail.gmail.com>
X-Mailer: Zimbra 6.0.10_GA_2692 (ZimbraWebClient - SAF3 (Mac)/6.0.10_GA_2692)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175835>

----- Original Message -----
> From: "Aaron Gray" <aaronngray.lists@gmail.com>
> To: "Git Mailing List" <git@vger.kernel.org>
> Sent: Wednesday, June 15, 2011 9:52:58 AM
> Subject: no autocrlf on Visual Studio subdirectory
> 
> I am wondering if there is a way of keeping CRLF's under my
> VisualStudio2010 subdirectory but applying core.autocrlf on all other
> repository directories.

Short answer is gitattributes eol setting.  Git will fallback to core.autocrlf for files that aren't named in the .gitattributes file.

Potentially useful is this [1] thread.

[1] http://thread.gmane.org/gmane.comp.version-control.git/174413/focus=174496

HTH,
Stephen
