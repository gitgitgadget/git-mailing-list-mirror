From: Andreas Ericsson <ae@op5.se>
Subject: Re: Problems with using git
Date: Thu, 02 Mar 2006 02:24:14 +0100
Message-ID: <4406493E.3000701@op5.se>
References: <44063B7C.40609@webdrake.net> <Pine.LNX.4.64.0603011651240.22647@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Joseph Wakeling <joseph.wakeling@webdrake.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 02 02:24:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEcYF-0002a7-IQ
	for gcvg-git@gmane.org; Thu, 02 Mar 2006 02:24:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbWCBBYQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Mar 2006 20:24:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751282AbWCBBYQ
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Mar 2006 20:24:16 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:19670 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751271AbWCBBYQ
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Mar 2006 20:24:16 -0500
Received: from [192.168.1.20] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 391526BCBE; Thu,  2 Mar 2006 02:24:15 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603011651240.22647@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17038>

Linus Torvalds wrote:
> 
> On Thu, 2 Mar 2006, Joseph Wakeling wrote:
> 
>>I'm using openSUSE 10.0 and the package installed is git-core version
>>0.99.3git20050905-2.
> 
> 
> I think your problems are just related to the fact that the tutorial is 
> newer than your git version.
> 
> Just fetch a newer version of git first (0.99.3 should be new enough to 
> happily fetch a newer version using git itself, but it might be easier to 
> just get a tar-ball), and you'll have an easier time at it.
> 

... and the way to fetch and install that repo with your current git is:

	$ git clone git://git.kernel.org/pub/scm/git/git.git git
	$ cd git && make all strip install

There are 2215 commits since 0.99.3, so I think you'll find much has 
changed since then.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
