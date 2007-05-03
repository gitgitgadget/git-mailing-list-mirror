From: John Wiegley <jwiegley@gmail.com>
Subject: Problem with git-svn
Date: Thu, 3 May 2007 17:10:15 -0600
Message-ID: <C6C8044A-E4C7-4385-9C8B-EC3D85B8D8A9@gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 04 07:10:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hjq41-0006u3-ER
	for gcvg-git@gmane.org; Fri, 04 May 2007 07:10:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767679AbXEDFKW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 May 2007 01:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767672AbXEDFKW
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 01:10:22 -0400
Received: from an-out-0708.google.com ([209.85.132.242]:38127 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767679AbXEDFKT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 01:10:19 -0400
Received: by an-out-0708.google.com with SMTP id b33so732120ana
        for <git@vger.kernel.org>; Thu, 03 May 2007 22:10:19 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:mime-version:content-transfer-encoding:message-id:content-type:to:from:subject:date:x-mailer;
        b=smZRxUZo0wjCEFtVHwgGWp6rwnhZULGGVFaEbFh98XIlI24hiHF78OX9PXorT3wFxWqM7nBdmUtQaVN8BVUgCy2Fd+B/e0f0bun9Xkqfcop4zAltpf6wJGkLZVUz3H9cvlD/jAYUPq9Vcrijc4EC9HAJNFhnMgogw0XNgFBwv7k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:mime-version:content-transfer-encoding:message-id:content-type:to:from:subject:date:x-mailer;
        b=dGxurIGRCX23B+HHIyWITySRFLMKcr8BF3CsqyKEaDRUJ/zS2JoUg/KRsP/Dv089VBfFZGBnR9YBN5Aw4XknfGmA7hkx5mwV8kJ47D2UAnvT6KsiX7Dpefgv2wlGkTSzBSwgQd9jUaJvNE1YdhBvH39b0u2R51CSG5Iqxet/+h8=
Received: by 10.100.212.15 with SMTP id k15mr2338704ang.1178255418973;
        Thu, 03 May 2007 22:10:18 -0700 (PDT)
Received: from ?192.168.0.9? ( [71.211.41.155])
        by mx.google.com with ESMTP id c39sm5723945anc.2007.05.03.22.10.17;
        Thu, 03 May 2007 22:10:17 -0700 (PDT)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46129>

Hello,

I've been using git-svn for a couple of weeks now quite happily.   
Then the other day I decided to start using "git-clone -l ..." in  
order to create a few concurrent topic branches.  I then moved to my  
canonical repository and did a "pull" from many of these topic branches.

So now I have a master git repository that reflects all of my  
accumulated work.  I want to reflect this up to my subversion  
repository.  However, it seems that doing all of that cloning and  
pulling has screwed up git-svn's tracking.  I get this error now when  
I try to dcommit:

Unable to extract revision information from commit  
865da18a70e8e93b1776864c73581198028e1190~1

The refid it's complaining about represents a pull of three changes  
from one of those topic branches:

commit 865da18a70e8e93b1776864c73581198028e1190
Merge: 42b0b95... f25fcef...
Author: John Wiegley <johnw@newartisans.com>
Date:   Thu May 3 00:17:17 2007 -0600

     Merge branch 'master' of /Users/johnw/src/ledger/master/

The refids that this refers to are also in my log, all with version  
information and log comments.

How do I get git-svn past this point?  I can't find any command that  
will make it functional again.  The last time this happened I just  
wiped my git repository and rebuilt it from scratch; but since people  
are tracking my git repository now, I'd rather now have to reset all  
of my refids (not to mention the sheer amount of time that it takes).

Thank you,
   John
