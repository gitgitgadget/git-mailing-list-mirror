From: Andreas Ericsson <ae@op5.se>
Subject: Re: More help needed on merging unrelated repos
Date: Tue, 04 Nov 2008 21:12:58 +0100
Message-ID: <4910ACCA.7080007@op5.se>
References: <46d6db660811040514qc6c9663u17bd231e1ba662ad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Christian MICHON <christian.michon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 04 21:15:32 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxSJA-0005KU-9s
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 21:15:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754043AbYKDUOK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 15:14:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754040AbYKDUOJ
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 15:14:09 -0500
Received: from mail.op5.se ([193.201.96.20]:35442 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754024AbYKDUOI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 15:14:08 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id BCCB91B80CA3;
	Tue,  4 Nov 2008 21:09:14 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.879
X-Spam-Level: 
X-Spam-Status: No, score=-2.879 tagged_above=-10 required=6.6
	tests=[AWL=-0.380, BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xwBh-UO4suno; Tue,  4 Nov 2008 21:09:13 +0100 (CET)
Received: from clix.int.op5.se (unknown [172.27.78.22])
	by mail.op5.se (Postfix) with ESMTP id 4FB121B800A4;
	Tue,  4 Nov 2008 21:09:08 +0100 (CET)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <46d6db660811040514qc6c9663u17bd231e1ba662ad@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100103>

Christian MICHON wrote:
> Hi,
> 
> I previously posted here a question on how to merge unrelated repos,
> and I was quite happy with the answer.
> git pull repo_name repo_branch
> 
> Yet, when I merge these repos (they're unrelated), I'd like to merge
> all of them at once.
> 
> How do I pull for example 2 repos in 1 command ? I cannot figure out
> the exact syntax to use.
> 
> I tried:
> git pull ../i1 0.5 ../i2 master
> git pull ../i1 0.5 -- ../i2 master
> 
> I also tried to play with --no-commit and -s to no avail.
> 
> Does anyone of you already use this and knows the trick ? Thanks in advance!
> 

You can only pull from a single repository at a time. The first way of doing
what you want that comes to mind is:

  git remote add lib1 lib1url
  git remote add lib2 lib2url
  git fetch lib1 && git fetch lib2 && git merge lib1/master lib2/master

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
