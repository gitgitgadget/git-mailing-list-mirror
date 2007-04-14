From: Rene Herman <rene.herman@gmail.com>
Subject: Re: GIT and the current -stable
Date: Sun, 15 Apr 2007 01:13:05 +0200
Message-ID: <46216001.3000503@gmail.com>
References: <46206842.80203@gmail.com> <20070414083410.GU6602@sequoia.sous-sol.org> <462096AA.3080003@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	Greg KH <greg@kroah.com>, git@vger.kernel.org
To: Chris Wright <chrisw@sous-sol.org>
X-From: git-owner@vger.kernel.org Sun Apr 15 01:14:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HcrS7-00037Z-Q5
	for gcvg-git@gmane.org; Sun, 15 Apr 2007 01:14:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752994AbXDNXOe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Apr 2007 19:14:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752820AbXDNXOe
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Apr 2007 19:14:34 -0400
Received: from smtpq1.groni1.gr.home.nl ([213.51.130.200]:57871 "EHLO
	smtpq1.groni1.gr.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751649AbXDNXOd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2007 19:14:33 -0400
Received: from [213.51.130.189] (port=44244 helo=smtp2.groni1.gr.home.nl)
	by smtpq1.groni1.gr.home.nl with esmtp (Exim 4.30)
	id 1HcrRv-0001pH-Om; Sun, 15 Apr 2007 01:14:31 +0200
Received: from cc334381-b.groni1.gr.home.nl ([82.73.12.33]:48840 helo=[192.168.0.3])
	by smtp2.groni1.gr.home.nl with esmtp (Exim 4.30)
	id 1HcrRu-0005Ih-8K; Sun, 15 Apr 2007 01:14:30 +0200
User-Agent: Thunderbird 1.5.0.10 (X11/20070221)
In-Reply-To: <462096AA.3080003@gmail.com>
X-AtHome-MailScanner-Information: Please contact support@home.nl for more information
X-AtHome-MailScanner: Found to be clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44471>

On 04/14/2007 10:54 AM, Rene Herman wrote:

> On 04/14/2007 10:34 AM, Chris Wright wrote:
> 
>> I've already put a tree like this up on kernel.org.  The master branch
>> is Linus' tree, and there's branches for each of the stable releases
>> called linux-2.6.[12-20].y (I didn't add 2.6.11.y).
>>
>> http://git.kernel.org/?p=linux/kernel/git/stable/linux-2.6-stable.git;a=summary 
> 
> I see, thank you; that sounds like a good "master" repo to clone then.

Okay, I just cloned this repo, like:

git clone -n \
git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6-stable.git \
stable

How do I now checkout for example 2.6.20.6, or get a diff between 2.6.20.6 
and the (at the moment of writing latest -stable) 2.6.20.7?

rene@7ixe4:~/src/linux$ cd stable
rene@7ixe4:~/src/linux/stable$ git branch -a
* master
   origin/HEAD
   origin/linux-2.6
   origin/linux-2.6.12.y
   origin/linux-2.6.13.y
   origin/linux-2.6.14.y
   origin/linux-2.6.15.y
   origin/linux-2.6.16.y
   origin/linux-2.6.17.y
   origin/linux-2.6.18.y
   origin/linux-2.6.19.y
   origin/linux-2.6.20.y
   origin/master

and I can check them out like

rene@7ixe4:~/src/linux/stable$ git checkout origin/linux-2.6.20.y

or in this case, but only this case, like:

rene@7ixe4:~/src/linux/stable$ git checkout v2.6.20.7

"v2.6.20.7" seems to be the only tag from the stable branches that's present 
  in this tree?

rene@7ixe4:[...]$ git tag -l | grep "v2\.6\.[[:digit:]]\{1,2\}\."
v2.6.20.7

Rene.
