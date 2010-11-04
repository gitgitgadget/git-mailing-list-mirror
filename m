From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: can subversion 1.6 be made "just as distributed as git"?
Date: Thu, 04 Nov 2010 03:00:45 -0700 (PDT)
Message-ID: <m34obxh0j9.fsf@localhost.localdomain>
References: <loom.20101104T014408-903@post.gmane.org>
	<BF8EE51A-AFE4-4EBA-82E8-4A8B32678FBF@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: MDellerus <mdellerus@yahoo.com>, git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Thu Nov 04 11:00:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDwcp-0003Sb-7D
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 11:00:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754080Ab0KDKAu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Nov 2010 06:00:50 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:37855 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753368Ab0KDKAt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Nov 2010 06:00:49 -0400
Received: by bwz11 with SMTP id 11so1475625bwz.19
        for <git@vger.kernel.org>; Thu, 04 Nov 2010 03:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=N8KuBfwLe15GS2Yvo5s1nom0/djOnBxI/W+ULfiWm1w=;
        b=rkFCaMsDNALq7Omj5b21iP0z1Rj4TmpVYiXU32l4C7K5RAf31B9qNxZBuTZeRrj9gs
         HffWjtKJZDNRRZMeLKjjfJFcWuhQwtsVpi4Mbsgp2aSmzg4ISmARf69fIwwfHPbMZL2X
         ZmnpOmLHAs938V+ptrrB8J+5RwJ1IJi4//Ttw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=SZ4/yow5ITpc7jkqisheGrrCN8YLhiwPOOULSDMA6++tE/F2IwTfiXXIFEsAwSHBGQ
         BW9A6fa48DQrFBno3CNbC1W0BE/nYya3yfoqgLYPu0Z7eu9gTtZSxPfy/7mvpHWflHQK
         hc534Oyqyuu8Xee2gQ3+/UmOLIMvUeBoKt480=
Received: by 10.204.55.3 with SMTP id s3mr447613bkg.56.1288864847395;
        Thu, 04 Nov 2010 03:00:47 -0700 (PDT)
Received: from localhost.localdomain (abvz101.neoplus.adsl.tpnet.pl [83.8.223.101])
        by mx.google.com with ESMTPS id a25sm6506292bks.8.2010.11.04.03.00.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Nov 2010 03:00:45 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id oA4A05TG020414;
	Thu, 4 Nov 2010 11:00:16 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id oA49xe7g020403;
	Thu, 4 Nov 2010 10:59:40 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <BF8EE51A-AFE4-4EBA-82E8-4A8B32678FBF@sb.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160710>

Kevin Ballard <kevin@sb.org> writes:
> On Nov 3, 2010, at 5:45 PM, MDellerus wrote:
> 
> > I have a co-worker who has suggested that, using "svnadmin hotcopy", subversion 
> > can be
> >    just as "distributed" a system as Git
> > 
> > While I see how this can be done, it hardly seems to me to qualify as "just as", 
> > making this "plausible" at best.
> > 
> > Can anyone give me a quick confirmation of this?  Confirmed? Plausible? Busted?
> > 
> > If this is confirmed or plausible, could someone give me a quick run-down?
> > 
> > (I would appreciate a response, no matter how long it takes, but I do have a 
> > meeting with this co-worker in another 16 hours... (10am Pacific).)
> > 
> > Thanks in advance!
> > 
> > (FYI - I have cross-posted this, just once, to an SVN forum, in the event they 
> > might have a different opinion.)
>
> Using "svnadmin hotcopy" you could certainly get your own local repo, but I fail to
> see how you could easily join your history up with someone else's history using this
> mechanism.

This is only replication, not distribution.

This is the same mistake that makes people say that branching in
Subversion is easy... while what is important is not how easy and fast
is to _create_ branch, but how easy is to merge it.  The same applies
with distributed version control: it is not about how easy is to
replicate repository, but how easy is to merge in (pull) changes from
replica.

By the way, how "svndamin hotcopy" / svnsync works with the fact that
svn:log property is unversioned but might be changed, also for
revisions in the past?

> If you really want to use SVN in a distributed manner, I would recommend
> you simply use SVK.

Wikipedia says that "On May 28, 2009, Chia-liang Kao announced that
Best Practical will no longer be actively developing SVK" and marks
SVK as no-longer maintained, but latest release of SVK on CPAN is from
23 Mar 2010.

Note that http://ldn.linuxfoundation.org/article/dvcs-round-one-system-rule-them-all-part-3
synthetic benchmark from Jan _2009_ finds that SVK has very bad scaling
behavior, and would have bad performance for larger projects.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
