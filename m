From: g2 <gerald.gutierrez@gmail.com>
Subject: How to jump between two repositories ...
Date: Tue, 4 Dec 2007 21:59:57 -0800
Message-ID: <C6AF7922-B2F7-42EB-B5DD-25353BC0AF2A@gmail.com>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 05 07:00:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IznJ3-0002wO-NT
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 07:00:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751444AbXLEGAF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 01:00:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751455AbXLEGAF
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 01:00:05 -0500
Received: from rv-out-0910.google.com ([209.85.198.186]:28161 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750969AbXLEGAC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 01:00:02 -0500
Received: by rv-out-0910.google.com with SMTP id k20so3483024rvb
        for <git@vger.kernel.org>; Tue, 04 Dec 2007 22:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to:content-type:content-transfer-encoding:mime-version:subject:date:x-mailer;
        bh=GVimKjDj+2ZyJ6jpRCa7bpojxSHQZlhAaXvMlP6GXlM=;
        b=vZAT3RhNtydXBzjdsjAmKslOIhXjIYms6INuyiczmKphJd4upE3any6BrlorsNyNOWnHrNSyYp2X8K6GOAeCX3OX03tywZoWQ+Za7q5inC4fApInbw7J0v73zD4TvFPcwoNAePqO4cPsBPAoWAQyuA6rNMJCt+bcroGJVg73hs4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:from:to:content-type:content-transfer-encoding:mime-version:subject:date:x-mailer;
        b=Qb95e2RCXZ32IY4heqqM/JD9p8NW9jZZCNjnFl7l0MWKTz7U0Azbp8eBbwjo0hlAd/sY+oUuk06enWh5vyoWyV8G7ODxnRZFp2sA3Np6euSxjMk7I+xAffkKkNNuW/zCnBzjogbvPR1pfLg1BxTMe0+DTHbzMF+n3cWnURa3RPo=
Received: by 10.141.129.14 with SMTP id g14mr907456rvn.1196834401634;
        Tue, 04 Dec 2007 22:00:01 -0800 (PST)
Received: from ?192.168.0.200? ( [70.79.106.215])
        by mx.google.com with ESMTPS id l17sm82285rvb.2007.12.04.21.59.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 04 Dec 2007 21:59:59 -0800 (PST)
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67103>

Hello all,

I am currently working on some code at the office that I also want to  
work with at home. Seems like a good candidate for git. So I created a  
repository at work and did a "git clone" at home. I've run into some  
strange behaviour that I don't understand and would appreciate if  
someone can clarify for me.

Imagine this scenario. At work:
git init
edit test.c
git add test.c
git commit

Then at home:
git clone <work git url>
edit test.c
git commit -a
git push

At this point, I wanted to push my changes back to my work repository  
so I can continue work the next day. So at home, I did a git push. I  
expect that my work repository has the newest material, but I find  
that when I do "git status" at work the next day, it tells me that my  
test.c is "modified" and has already staged it for commit. I need to  
do a "git reset" followed by "git checkout" to update my work folder  
to the latest stuff.

Totally different from my expectation of the repository knowing that  
it is out of date and then kindly suggesting that I should do a "git  
update" of some sort. What piece of understanding am I missing to  
properly "get" what is going on here, and how am I supposed to  
properly work with this setup?

Thanks for any help.
Gerald.
