From: seanh <seanh.nospam@gmail.com>
Subject: Using git to track my PhD thesis, couple of questions
Date: Thu, 27 Aug 2009 21:34:02 +0100
Message-ID: <20090827203402.GC7168@kisimul>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 27 22:36:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgliI-00024I-6m
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 22:36:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752635AbZH0Ugp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2009 16:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752622AbZH0Ugp
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 16:36:45 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:63315 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752230AbZH0Ugo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2009 16:36:44 -0400
Received: by ewy2 with SMTP id 2so1583542ewy.17
        for <git@vger.kernel.org>; Thu, 27 Aug 2009 13:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=fusgK81JEsgQlmQ4xO4WBwq48ZdKlXijHY2YnleB9yE=;
        b=rhjxgAKzL79EpACGk6+YV+tPwypo8Nfw4Yh9Srn2A0GkLziT1xpY0bUTRAnRzVyE3/
         F+Ec7DmMosuZAJErnIYmOckgWu7BPVUZWvtFCbofvlAw43gwVywk4FEzVnpnFbvkFE3g
         CWv5tEf5Ng2PLlNi0gG0BqxEDAySx/dphpa4k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=Z2Oi5GiD9FdIsWB+WVuGwchaLnkZJzNFKM0dOtRNPQZiIz+Pag4qSU/oXc0ZA2Xbbp
         ynAULgqZBb3RqIWpwMVFzaZxBQLtQ75V+SpXDuGKfOC/5Vagj3TUCYNOyESeNhtuN4Xm
         8VJlOPnZEcGQHbnRH8JdKrlrq5YTL+3JlO+o0=
Received: by 10.211.158.11 with SMTP id k11mr166373ebo.63.1251405405707;
        Thu, 27 Aug 2009 13:36:45 -0700 (PDT)
Received: from kisimul (kisimul.inf.ed.ac.uk [129.215.197.9])
        by mx.google.com with ESMTPS id 23sm180587eya.19.2009.08.27.13.36.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 27 Aug 2009 13:36:45 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127205>

I'm planning to use git to track my PhD thesis as I work on it and to 
let my supervisors track it. I've setup a git repository and a gitweb 
instance showing it. There are a couple of specific requirements.

1. My supervisors don't want to see all the little commits that I make 
day by day. So I'll commit to a dev branch, then whenever I've made 
significant progress will merge it into a trunk branch. I want the trunk 
branch to get all the changes but as one big commit, not inherit all the 
little commits like a normal merge would do. I think this is a `git 
merge --squash`. Btw the help for that command ends quite brilliantly: 
"(or more in case of an octopus)".

2. They don't want to look at the latex source but the PDFs built from 
it, which they're going to annotate with their comments. So I need an 
easy way for them to get the PDF of each commit from gitweb without 
having to checkout the repo and build it themselves. Normally I 
wouldn't commit the PDF files into the repo because they're compiled 
files not source files, but it seems that just building a PDF and 
committing it along with each commit to trunk would be by far the 
easiest way to achieve this. But will git store the PDFs efficiently, or 
will the repo start to get really big?

Thanks
