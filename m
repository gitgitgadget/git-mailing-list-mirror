From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: From P4 to Git
Date: Fri, 31 Jul 2009 11:22:42 +0200
Message-ID: <200907311122.43918.jnareb@gmail.com>
References: <85ljm84lat.fsf@oqube.com> <m3fxcg3473.fsf@localhost.localdomain> <85r5vxbd8e.fsf@oqube.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Sam Vilain <sam@vilain.net>
To: Arnaud Bailly <abailly@oqube.com>
X-From: git-owner@vger.kernel.org Fri Jul 31 11:16:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWoDz-0005Dz-9H
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 11:16:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751497AbZGaJQT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2009 05:16:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751473AbZGaJQT
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Jul 2009 05:16:19 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:50552 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751429AbZGaJQR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2009 05:16:17 -0400
Received: by ewy10 with SMTP id 10so1362556ewy.37
        for <git@vger.kernel.org>; Fri, 31 Jul 2009 02:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=MzLPR9lRCX7fde+yjQt59W+fCUp0SpP/TLoByNvVAxg=;
        b=YBC4zsTiCJTsoivEYAcEbn21OcaBsLj2ElZmlYO+JR58dbOsKuVm7OifMwufICgVS5
         3EyrXuqwozT1SZ1uoTkjDnJSjYKm08zgVAVuyM0eIK2b734/P13m2Em3CHZIORfogGEs
         C993OIjhX/10NyxcmtC4ljafJfocFNVR5w4js=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=cBYrJ0APL4Uy9zDTiRFcSqnzbfsENe0eKb/lZXXtutII8xiMFUvMwSfHCgK+PsUv9Z
         UCeKBKUTrLntigORDSQlH1bwSWEcxuAMAaX6DuXFgxAC5jCG4osX9mp2uejm1rcztPSA
         7MQzdv20qrJxkpuV/+cwoZT7SE6Ak7PzJuVjM=
Received: by 10.211.195.15 with SMTP id x15mr597704ebp.9.1249031775104;
        Fri, 31 Jul 2009 02:16:15 -0700 (PDT)
Received: from ?192.168.1.13? (abvk103.neoplus.adsl.tpnet.pl [83.8.208.103])
        by mx.google.com with ESMTPS id 28sm2532157eye.54.2009.07.31.02.16.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 31 Jul 2009 02:16:14 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <85r5vxbd8e.fsf@oqube.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124515>

I have re-added git mailing list to Cc.

On Fri, 31 July 2009, Arnaud Bailly wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
>>
>>>  2. have a very large codebase
>>
>> How large codebase?  What it means "large codebase"?  Large number of
>> files, or files large in size (usually binary)?
> 
> Mostly lot of source files, amounting to about 9 MLOCs of mixed
> languages source.
> 
>> Git can deal comfortably with codebase of the size of Linux kernel.
>> Perl 5 core was converted from Perforce to Git.
> 
> I guess we are in the same order of magnitude than kernel.

Linux kernel, for development of which git was initially designed,
is around 7.5M LoC of code (10M LoC with comments and blank lines)[1].
The performance for such large codebase has to be good (at least on
Linux and other POSIX systems), as good performance was one of goal
decisions of git.

Perl 5 core, which version control history was converted from Perforce
to Git in December 2008[1][2] by Sam Vilain (you might want to take
a look how it was done; unfortunately it seems that Sam Vilain blog
vanished from Internet), is 2.3M LoC of mixed language code (mainly
Perl and C, with twice as much Perl), so it is smaller than yours
codebase.

[1] According to OSS software metric site Ohloh (http://www.ohloh.net)
[2] http://news.perlfoundation.org/2008/12/perl_5_development_now_on_git.html
[3] http://use.perl.org/article.pl?sid=08/12/22/0830205

>> But git is snapshot based, not changeset based, and treats project
>> (repository) as whole, not as a combination of single file histories.
>> This means that it would be unproductive to use 'everything in single
>> repository' approach.  If your codebase is of the size of whole KDE
>> tree, or the whole GNOME tree, you would need to organize it and split
>> it into smaller, reasonably sized repositories (you can urganize them
>> back together in a superproject using submodules).
> 
> That's my biggest concern. We are actually using a single tree repository
> approach with lot of branches. What led me to Git at first was the ease
> of branching and merging. I used branching and merging with Subversion
> and its painful.

So it looks like you wouldn't _need_ to split source tree into separate
smaller repositories for performance reasons.  Still it might be good
idea to put separate (sub)projects into separate repositories.  But
I guess you can do that even at later time (although it would be best
to do this upfront).

Branching and merging in Git is very easy (with Subversion 1.5 merging
is supposedly to get easier).  Git itself uses 'topic branches' workflow,
where each feature (each series of patches) gets its own branch, and
branches are cherry-picked to be merged (or to be dropped, or replaced
by newer version of series).
 
>> There is GitStat project: http://mirror.celinuxforum.org/gitstat/

Which follows Linux kernel.  There are also some GitStat deployments
tracking other code.

>> There was also Git-Statistics project at Google Summer of Code 2008
>> which repository can be found at http://repo.or.cz/w/git-stats.gitSee http://git.or.cz/gitwiki/SoC2008Projects
>>
> 
> Great.

And there are tools such as Ohloh, which do software metric, and some
of code is available.  GitHub hosting site also offers some software 
metric / statistic tools in its web interface; I don't know about other
sites such as Gitorious or InDefero.  Gitweb currently doesn't offer any
statistics.

-- 
Jakub Narebski
Poland
