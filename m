From: Andreas Ericsson <ae@op5.se>
Subject: Re: Recover broken git index?
Date: Thu, 28 May 2009 11:01:49 +0200
Message-ID: <4A1E52FD.6090801@op5.se>
References: <4A1DB700.4080705@bcm.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Misha Koshelev <mk144210@bcm.edu>
X-From: git-owner@vger.kernel.org Thu May 28 11:02:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9bV2-0005Io-Bw
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 11:02:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756340AbZE1JBy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2009 05:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756195AbZE1JBy
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 05:01:54 -0400
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:44879 "HELO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753511AbZE1JBx (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 May 2009 05:01:53 -0400
Received: from source ([72.14.220.158]) by na3sys009aob108.postini.com ([74.125.148.12]) with SMTP
	ID DSNKSh5S+5KP1Iy6JfEUut5Ndyt2H0es8hX8@postini.com; Thu, 28 May 2009 02:01:48 PDT
Received: by fg-out-1718.google.com with SMTP id 16so1438685fgg.10
        for <git@vger.kernel.org>; Thu, 28 May 2009 02:01:47 -0700 (PDT)
Received: by 10.86.91.13 with SMTP id o13mr1285950fgb.23.1243501306873;
        Thu, 28 May 2009 02:01:46 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.174.166])
        by mx.google.com with ESMTPS id d6sm18367938fga.2.2009.05.28.02.01.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 May 2009 02:01:46 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <4A1DB700.4080705@bcm.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120173>

Misha Koshelev wrote:
> Hi, I seem to have an unrecoverable git index. I have attached the
> output of git-fsck --full. There seem to be a lot of missing trees and
> blobs. Any good way to recover?
> 

Start by copying the repository somewhere safe so you don't accidentally
delete things in it.

If it's really the index that's broken, a simple

  git checkout master && git reset --hard

should do the trick.

If it doesn't, it's not the index that's at fault.


Have you done history surgery on this repository (extensive rebasing
or filter-branch'ing)?


Answers to the questions below really should have been in your original
post. Please include them if we're to be able to understand what's going
on:
What OS and platform are you using?
What git version are you using?
How did you first notice this?
What were you doing when you first noticed this?
Is your repository working correctly otherwise (ie, do you only spot
these errors when you run "git fsck --full")?

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Register now for Nordic Meet on Nagios, June 3-4 in Stockholm
 http://nordicmeetonnagios.op5.org/

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
