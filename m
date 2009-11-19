From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Hey - A Conceptual Simplication....
Date: Thu, 19 Nov 2009 11:27:27 +0100
Message-ID: <200911191127.28768.jnareb@gmail.com>
References: <005a01ca684e$71a1d710$54e58530$@com> <31e9dd080911181152h665d5d9dr5c0736c0ca3234c1@mail.gmail.com> <009401ca68bc$7e4b12b0$7ae13810$@com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "'Jason Sewall'" <jasonsewall@gmail.com>,
	'Jan =?utf-8?q?Kr=C3=BCger=27?= <jk@jk.gs>, git@vger.kernel.org
To: "George Dennie" <gdennie@pospeople.com>
X-From: git-owner@vger.kernel.org Thu Nov 19 11:27:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NB4Es-0007uw-14
	for gcvg-git-2@lo.gmane.org; Thu, 19 Nov 2009 11:27:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756180AbZKSK1e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2009 05:27:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756148AbZKSK1e
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Nov 2009 05:27:34 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:33609 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755101AbZKSK1d (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2009 05:27:33 -0500
Received: by bwz27 with SMTP id 27so2143513bwz.21
        for <git@vger.kernel.org>; Thu, 19 Nov 2009 02:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=9Gzfmn9MulyoN9uhv6hisTVQvnnN26yY5N6IBwTWphM=;
        b=YsnKcBLPsMeYzjv6DBxP6TVDEkQ/XOlUPw9HKyJ9bzAQet395sSrLq4AZT3hVGqWrJ
         yns3t8NZkhQ0bRWmJYiAFijNTO0iIhyQ78QGVn1mQC5mIlN9eVKxrXrB6AfNiNxv7f4E
         EDNlszhsWayiQch6C5vRE/vXOMpU9VYDTQ0WQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=KzTxi3h4mRUTEdcvvPlf7hPLamthlDdqw3zz42D0hHrpsw9b18nAtqu6ZkuWKfBRAS
         jGgHxg8Xf54ONQxTbw9WLolTj8a8s165MjICnr/rTQ02MZDiF+1R3APlcpTclxhW/ZJL
         90Z0IbdIu/jVDfSUKn880mobPMUi8btkb3juQ=
Received: by 10.204.10.7 with SMTP id n7mr5104438bkn.68.1258626455139;
        Thu, 19 Nov 2009 02:27:35 -0800 (PST)
Received: from ?192.168.1.13? (abvd116.neoplus.adsl.tpnet.pl [83.8.201.116])
        by mx.google.com with ESMTPS id 16sm122400fxm.4.2009.11.19.02.27.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 19 Nov 2009 02:27:34 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <009401ca68bc$7e4b12b0$7ae13810$@com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133223>

Side-note: you are employing very strange line wrapping... you should
word wrap your lines so they do not exceed 70-76 characters, and you
should not (except when required for readability) rewrap quoted text.

On Thu, 19 Nov 2009, George Dennie wrote:
> Thanks Linus, Jason, and Jakub...
> 
> Linus Torvalds wrote....
>>On Wed, 18 Nov 2009, George Dennie wrote:
>>> 
>>> The Git model does not seem to go far enough conceptually, for some 
>>> unexplainable reason...
>>
>> Others already mentioned this, but the concept you missed is the git
>> 'index', which is actually very central (it is actually the first
>> part of git written, before even the object database) but is
>> something that most people who get started with git can (and do)
>> ignore. 
> 
> Uhmmm, subtle. I hear you. Thanks for the heads up. But before that,
> I just put these two cents down... 

> [...] Now, I have not had occasions to do merges, as such. So I am
> finding the justification for the index vague. [...]

Errr... you didn't do any merges?  What is then your experience with
using version control, then?


As for using index during merge: merge is joining two (or more) lines
of history (lines of development), bringing contents of another branch
into current branch.  Some of changes are independent, for example
if one branch changes one file, and other branch changed other file.
This is so called trivial merge, example of tree-level merge.  Even
if branches merged touch the same file, if changes were made in separate
sections of file git can merge changes (using three-way merge / diff3
algorithm).

The problem starts if there are changes which touch the same sections
of a file.  This generates so called merge conflict (contents conflict),
and you have to resolve such conflict manually.

During merge index helps to manage information about yet unmerged parts.
Let's assume for example that you made a mistake in merge resolution in
some file, and you want to scratch your attempt and try it anew. 
Without index it would be very hard to do without trashing resolutions 
of other conflicts.

> For example, the functional notion of the repository seems well
> defined: a growing web of immutable commits each created as either
> an isolated commit or more typically an update and/or merger of
> one or more pre-existing commits.

If by "web" you mean DAG (Directed Acyclic Graph) of commits, then
yes, it is _part_ of repository.

There are also refs (branches, tags, remote-tracking branches), which 
are also part of repository, very important part.  Those are named
references into DAG of commits.


As to commits being created as update of existing commit or from 
scratch: that would depend on the way of development.  Merge commits
are much, much more rare than ordinary commits (especially that git 
favors fast-forwards by default when there is no need for merge).

> 
> With such a description the rest of the structure becomes almost
> implicit: Commits may be annotated such as with release number labels.
> Commits that have not been linked to such as by an update or merger
> remain dangling like loose threads in the web and are called branches.
> Branches may be given special labels that the repository will then
> automatically update so as to refer to the latest commit to that
> branch.      

Almost right.
 
> I don't yet have such a clear model for the index. Yes it is a staging
> platform, but so is the IDE....I'll do more reading. 

The index is area where you prepare commits, if needed.  But you
don't need to care that there is something like the index, and prepare
your commits in working area.  But when you need it, it is there.

-- 
Jakub Narebski
Poland
