From: Adam Roben <aroben@apple.com>
Subject: Re: git-svn and local only topic branch
Date: Tue, 1 May 2007 09:45:48 -0700
Message-ID: <0E0C5313-0DCA-4DE5-96C5-9AD74758B68A@apple.com>
References: <8b65902a0705010940pb3bfb16u624d470068351624@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v880)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Guilhem Bonnefille <guilhem.bonnefille@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 01 18:45:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HivUA-0007zs-9Q
	for gcvg-git@gmane.org; Tue, 01 May 2007 18:45:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754772AbXEAQpv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 May 2007 12:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754785AbXEAQpv
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 12:45:51 -0400
Received: from mail-out4.apple.com ([17.254.13.23]:61481 "EHLO
	mail-out4.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754772AbXEAQpu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2007 12:45:50 -0400
Received: from relay7.apple.com (a17-128-113-37.apple.com [17.128.113.37])
	by mail-out4.apple.com (8.13.8/8.13.8) with ESMTP id l41GjmUQ022080;
	Tue, 1 May 2007 09:45:48 -0700 (PDT)
Received: from relay7.apple.com (unknown [127.0.0.1])
	by relay7.apple.com (Symantec Mail Security) with ESMTP id 6A95630077;
	Tue,  1 May 2007 09:45:48 -0700 (PDT)
X-AuditID: 11807125-9fc4cbb00000097b-56-46376ebc3111 
Received: from [17.203.14.129] (il0301a-dhcp01.apple.com [17.203.14.129])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by relay7.apple.com (Apple SCV relay) with ESMTP id 5374E30012;
	Tue,  1 May 2007 09:45:48 -0700 (PDT)
In-Reply-To: <8b65902a0705010940pb3bfb16u624d470068351624@mail.gmail.com>
X-Mailer: Apple Mail (2.880)
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45958>

On May 1, 2007, at 9:40 AM, Guilhem Bonnefille wrote:

> Hi,
>
> I'm using Git as a SVN frontend (via git-svn). Recently, I made a
> topic branch, I did some job on it and wish to "upload" my work (on
> the SVN). But, I do not want "pushing" all commits, I only want to
> create a single commit on the SVN, while keeping full commits on my
> Git repo. But I did not find how to do this.

    If you just want to make a commit to Subversion containing all the  
changes on your branch, then you should be able to do this:

git svn commit-diff upstream topic

    That will take the entire diff between upstream and your topic  
branch and make one commit to Subversion containing that diff.

-Adam
