From: Steven Walter <stevenrwalter@gmail.com>
Subject: Re: git-svn segmetation fault
Date: Sat, 2 Feb 2008 16:03:48 -0500
Message-ID: <20080202210348.GA11722@dervierte>
References: <47A39DFD.9020905@saville.com> <47A3BE6F.6080304@saville.com> <20080202034258.GA27814@dervierte> <47A3E9A8.1060102@saville.com> <20080202160332.GA25945@dervierte> <47A4BCE8.5030308@saville.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Wink Saville <wink@saville.com>
X-From: git-owner@vger.kernel.org Sat Feb 02 22:04:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLPXU-0006wd-VX
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 22:04:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756849AbYBBVEI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 16:04:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756400AbYBBVEH
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 16:04:07 -0500
Received: from wa-out-1112.google.com ([209.85.146.178]:27900 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752775AbYBBVEE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 16:04:04 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1732237wah.23
        for <git@vger.kernel.org>; Sat, 02 Feb 2008 13:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=ucnjf2w4Sabr6d7s+vczYUFIOLGjlWvUNb726lBaMJo=;
        b=diUprpjo3Z6K0YvPCtSTH8A/Xx/kaETP20592HbW9hbClUgeydObFisQhMmAYNq+EeTytKn2xnSLLS/GPW4BMNBf1zq86JVL97xHqlHlhSn/haqj1WufwHhsRe/OXqz+hiabDyEvRvpxDOq3LWp+XbFnXwpdb0pNg4XgLBGMUJo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=cQN11czgkDNvUm6k8NUqq7NajipnhS0gVSVLvg/QAQRs2aOXMrafGj0bQBPpE+cIQjcT6yWBLJACNyyR8gzZYVRtlCjmJVywXW4JfwUJfwBhS7X/RRx0aBZvCsoWGjh73SC3dPMBx+0C1NtHDBYemz1sIol3g6fBrTk0XbWrgyc=
Received: by 10.114.175.16 with SMTP id x16mr5470353wae.116.1201986243751;
        Sat, 02 Feb 2008 13:04:03 -0800 (PST)
Received: from dasbrennen.isa-geek.org ( [76.177.39.93])
        by mx.google.com with ESMTPS id i20sm6749682wxd.2.2008.02.02.13.03.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 02 Feb 2008 13:04:01 -0800 (PST)
Received: by dasbrennen.isa-geek.org (Postfix, from userid 1000)
	id 430AF36400; Sat,  2 Feb 2008 16:03:48 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <47A4BCE8.5030308@saville.com>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72302>

On Sat, Feb 02, 2008 at 10:56:40AM -0800, Wink Saville wrote:
> <I did that but a rebase command resulted in: />
>
> wink@ic2d1:$ git svn rebase
> Unable to determine upstream SVN information from working tree history
>
> <I've bee using git-svn for a few days without trouble. Do I need
> the do another "git svn clone" using the base url rather than
> pointing to the trunk? />

You shouldn't have to clone again.  First time removing .git/svn, then
running "git svn fetch" (which ought to rebuild what was there).  You
ought to be able to rebase after that.
-- 
-Steven Walter <stevenrwalter@gmail.com>
Freedom is the freedom to say that 2 + 2 = 4
B2F1 0ECC E605 7321 E818  7A65 FC81 9777 DC28 9E8F 
