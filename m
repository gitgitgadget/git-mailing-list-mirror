From: Timothy Washington <timothyjwashington@yahoo.ca>
Subject: Re: "Not currently on any branch"
Date: Sun, 4 Oct 2009 21:01:20 -0700 (PDT)
Message-ID: <106990.92203.qm@web111508.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 05 06:06:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Muepv-0000xR-D5
	for gcvg-git-2@lo.gmane.org; Mon, 05 Oct 2009 06:06:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbZJEEB6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2009 00:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750727AbZJEEB6
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Oct 2009 00:01:58 -0400
Received: from web111508.mail.gq1.yahoo.com ([67.195.15.175]:41036 "HELO
	web111508.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750703AbZJEEB5 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Oct 2009 00:01:57 -0400
Received: (qmail 92305 invoked by uid 60001); 5 Oct 2009 04:01:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s1024; t=1254715281; bh=zGt4B2hUBtKTUWRBI7MF4NZO05ezqdzDdmBU41n+rRQ=; h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:MIME-Version:Content-Type; b=SoYIKkpmZpL2rqsDLglDFU2xkS8289Zf//GV38GwWiz11AiY+yY5J4V5JUwli3IfpYQCQajs9+l/MKCPZR0mKkoW6qn2pVnczZhpCbMGtiYSYkDTjnIySByEpW6oB2zSKH0l+qH9DnPAM4T9pzryBWIyIsXvqBf9KKQNZiy0RBI=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.ca;
  h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:MIME-Version:Content-Type;
  b=6n0xKEtAbVGJ9qw5AlC18TKfQtKmqD8xfyFyTDIFKv2YO+tdG/E4fhqkRpvoV2N+xjdv7Y4emoVmhwcfWy8Q8OmYvBzLkyZEMNRI/v3GB5/R0RHH4NsmLuSInbwxsWHi8kT47GtsgbBY8b7XxpwqQSKKJany+qw8xxY6+XpIDiU=;
X-YMail-OSG: Dqt9j68VM1nHZc1kUxL71qL_5tZqZHMBxfHWJNn2ujyQ00l0HNI2zdG48aJcGZh1Iuy3FhZJvXgGEOKCFP.TJBy6fhU580jbTFD2qc8Snu1mdZ9CjzEwaB4RpyoK4LmSKsRlZpfj9UBhuO_BKqmd2FokKoADPG7FpATPQ70hdptkWFOTrJtfoSJsxOL3SpcVMOQVDKhqKxcjEbEMMr.nILNBJMYXQihZvLagpl4hoIgOkJre7zAB6AntaBh.jpv70qR1wnjfZLFf_sk5Z6xFnpQVzwM0zIhQULlCIB3aSbEr0nAsEOX_vwhMp.Hk14sgX4_n1iuk4t3WJdjK.uwK1KKYLf0OKYQmzubg_89FyD9i1s7gdg--
Received: from [173.33.212.254] by web111508.mail.gq1.yahoo.com via HTTP; Sun, 04 Oct 2009 21:01:20 PDT
X-Mailer: YahooMailRC/157.18 YahooMailWebService/0.7.347.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129527>


Thanks for all the responses so far. But if you take a look at my repo (http://repo.or.cz/w/Bookkeeping.git), at the bottom of the page, there's clearly a 'ui-integration' branch. But if I try to go to my ui-integration branch, I get the message below. So I'm just clueless as to where it went. If use the -b option, then I'll create a new branch. But I don't want that. I want to keep all the data that was in my original 'ui-integration' branch. 

[timothyw] ~/Projects/Bookkeeping.4 $ git checkout ui-integration
error: pathspec 'ui-integration' did not match any file(s) known to git.


These are what's in the files under my .git/ directory. And again, I'm foggy as to where my ui-integration branch went and to how to get it back. 

"HEAD"
cee341c53a249f7d003a12cfeb8cc743275d028f

"ORIG_HEAD"
baca7c9f43e44d67406d3671e0afd84eaea870a3

"config"
[core]
    repositoryformatversion = 0
    filemode = true
    bare = false
    logallrefupdates = true
    ignorecase = true
[remote "origin"]
    url = http://repo.or.cz/r/Bookkeeping.git
    fetch = +refs/heads/*:refs/remotes/origin/*
[branch "master"]
    remote = origin
    merge = refs/heads/master

"description"
Unnamed repository; edit this file to name it for gitweb.

fig. 1 


Thanks
Tim 






________________________________
From: Clemens Buchacher <drizzd@aon.at>
To: Tim <timothyjwashington@yahoo.ca>
Cc: git@vger.kernel.org
Sent: Sunday, October 4, 2009 3:22:29 AM
Subject: Re: "Not currently on any branch"

On Fri, Oct 02, 2009 at 08:08:52PM +0000, Tim wrote:
> I have some code in a git repo that is "Not currently on any branch". Now,
> there's the master branch and another branch 'ui-integration' that I'm
> using in this project. I don't know how the project got into this headless
> state, but I need to be using the 'ui-integration' branch. 

It can happen either by explicitly detaching HEAD using "git checkout
<commit>", or if you used rebase and it is still in progress.

Clemens

________________________________
Instant message from any web browser! Try the new Yahoo! Canada Messenger for the Web BETA


      __________________________________________________________________
Yahoo! Canada Toolbar: Search from anywhere on the web, and bookmark your favourite sites. Download it now
http://ca.toolbar.yahoo.com.
