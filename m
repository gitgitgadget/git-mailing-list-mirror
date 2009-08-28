From: Jakub Narebski <jnareb@gmail.com>
Subject: Merging in Subversion 1.5 (was: Re: Using git to track my PhD thesis, couple of questions)
Date: Fri, 28 Aug 2009 08:12:27 -0700 (PDT)
Message-ID: <m3ocq0km5m.fsf_-_@localhost.localdomain>
References: <4A979690.1050601@gnu.org> <20090827203402.GC7168@kisimul>
	<vpqk50pasek.fsf@bauges.imag.fr> <20090827203402.GC7168@kisimul>
	<9b18b3110908271521w764684cfg3b009f6960ee5dc4@mail.gmail.com>
	<20090827203402.GC7168@kisimul>
	<7v1vmxq6nw.fsf@alter.siamese.dyndns.org>
	<20090827203402.GC7168@kisimul>
	<fabb9a1e0908271341o3a558eedq85541e68875ab77f@mail.gmail.com>
	<20090827203402.GC7168@kisimul> <20090828133708.GA11146@kisimul>
	<vpqpragt5bo.fsf@bauges.imag.fr> <4A97E1B1.7090107@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>
To: Matthias Andree <matthias.andree@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 28 17:13:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mh38F-0006AF-Pf
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 17:12:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752191AbZH1PMa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 11:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751794AbZH1PM3
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 11:12:29 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:41780 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751513AbZH1PM1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 11:12:27 -0400
Received: by fxm17 with SMTP id 17so1629444fxm.37
        for <git@vger.kernel.org>; Fri, 28 Aug 2009 08:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=mhxDHf5mMZWRlk/GSGbbqMMELfET8/Agvx/8KmNQ7/w=;
        b=iRSSrg2wCeogKJ5JBCfFmrhoNf+oAPe+sCmIGDa6cTC80DKdhxqmGkPCCQ93oMQIdl
         o9OLaQtpJ7+hD4het+Un6+TbP/3Cm1JmI5bwe8v3JqT1YidF0tDDBc9uVYKVVJWZ8Ff/
         H3pKIcUVO33sTZhK7X4fQCt4QLjqee926uFKM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=YZ7hoDRnU4ncHhOTkamnIbbJMV4ILRF6Bdrw7TtRkPiUBjdyvZocPScp6+7xXCC2xu
         rzVDNk6Dq9Midrq90nlBLvi0W53UQihE2Q9/G1f8ryRbYPXBqiNyAD0NDhn5b8/gTcjZ
         wcQQgPkax+tttkPXPc1eFanD71S3kttN/NHMQ=
Received: by 10.103.125.18 with SMTP id c18mr348208mun.71.1251472348038;
        Fri, 28 Aug 2009 08:12:28 -0700 (PDT)
Received: from localhost.localdomain (abvl130.neoplus.adsl.tpnet.pl [83.8.209.130])
        by mx.google.com with ESMTPS id j10sm5574084muh.26.2009.08.28.08.12.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 28 Aug 2009 08:12:27 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n7SFCMQK026167;
	Fri, 28 Aug 2009 17:12:25 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n7SFCLC9026164;
	Fri, 28 Aug 2009 17:12:21 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4A97E1B1.7090107@gmx.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127301>

Matthias Andree <matthias.andree@gmx.de> writes:
> Matthieu Moy schrieb:
>> seanh <seanh.nospam@gmail.com> writes:
>> 
>>> In response to Matthieu and Paolo, I'm not sure I understand the git 
>>> internals involved in the discussion around merge --squash, I had a 
>>> feeling this would produce a 'merge' that git in some sense would 'not 
>>> know about',
>> 
>> Yes, that's it. Git does a merge, and immediately forgets it was a
>> merge. The consequence is when you merge again later, Git will not be
>> able to use the merge information to be clever about merging. Somehow,
>> Git will be as bad as SVN for merging if you don't know what you're
>> doing ;-).
> 
> To be fair, SVN versions 1.5 and newer can track merges. If the
> repository predates 1.5, it has to be updated on the server side
> (see the release notes for details). It just tracks which revisions
> have been merged and which not, for further details, see the svn
> book. (http://svnbook.red-bean.com/ IIRC)

>From what I understand (from what I have read, and browsed, and
lurged, and noticed) is that Subversion 1.5+ does merge tracking, but
in very different way that in Git:

 * the svn:mergeinfo is client-side property; if I understand
   correctly this would help you in repeated merges, but not anyone
   other

 * svn:mergeinfo contains _per-file_ merge info, so it is much, much
   more "chatty" than Git multiple parents.  This might be more
   powerfull approach, in the same sense that more advanced merge
   strategies that 3-way merge were more powerfull -- but 3-way merge
   is best because it is simple (and either it is simple that 3-way
   merge is enough, or complicated so manual intervention is required).

 * You have to explicitely enable using svn:mergeinfo in log and blame

 * The command to merge trunk into branch is different from command to
   merge branch into trunk.

Also IIRC there is warning (well, at least there was in Subversion 1.5
release notes) that merge tracking doesn't work entirely correctly in
the face of criss-cross merges (multiple merge bases) and renaming
(although I do hope that they fixed problem with silent corruption if
there is rename during merge).

-- 
Jakub Narebski

Git User's Survey 2009: http://tinyurl.com/GitSurvey2009
