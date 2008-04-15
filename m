From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: branch description
Date: Tue, 15 Apr 2008 11:36:40 -0700 (PDT)
Message-ID: <m3iqyjrmmk.fsf@localhost.localdomain>
References: <9b3e2dc20804150951scf8b3c7x26f3a56eab1f9840@mail.gmail.com>
	<f9d2a5e10804151031o1d09c1f9od0ad78dcf9b746c5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Stephen Sinclair" <radarsat1@gmail.com>, git@vger.kernel.org
To: "Russ Dill" <russ.dill@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 15 20:39:38 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jlq2X-0006z5-LR
	for gcvg-git-2@gmane.org; Tue, 15 Apr 2008 20:37:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753361AbYDOSgp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2008 14:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752684AbYDOSgp
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Apr 2008 14:36:45 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:29451 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752518AbYDOSgo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2008 14:36:44 -0400
Received: by nf-out-0910.google.com with SMTP id g13so596144nfb.21
        for <git@vger.kernel.org>; Tue, 15 Apr 2008 11:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=fQF9t7842K3uzd6R3QX/3ZCoK9ueuI2IfUMGmQ3NPEQ=;
        b=mTSDSmYv9b2ZDrT2bPFb9thIryLcgriKtRtSFlHG1uSc34F5WQO62hsxOe4vVjE+QKDYqM6oHAOIMN9HBJBHNhpIzCyTOCmbfs43a4lkxxC2hU8h6Q3LKcbIvKJt6ra5ZqgQbciMyYfpOu1evNWXoEQUW6en9qnfG4Q7qxDswXE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=NNief8iSXQ/nY3tetGHP1pveK3/QFSZMzkbPxb+xcjTWIGe8tsnSfqJEmI65haEiJx+kSYAODu2sWK8GP4IrMVMwuGWg6dzNN+8aalZTZ8mrznkJC4QqDn8ed2Uo/GV50G/XpcM7nAMBImlwvax9MLtQ/gocrfNA+Q5mDEui08o=
Received: by 10.78.142.3 with SMTP id p3mr4801816hud.81.1208284602510;
        Tue, 15 Apr 2008 11:36:42 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.244.53])
        by mx.google.com with ESMTPS id s37sm3047251hub.58.2008.04.15.11.36.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 15 Apr 2008 11:36:40 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m3FIacKw021438;
	Tue, 15 Apr 2008 20:36:38 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m3FIaa4R021435;
	Tue, 15 Apr 2008 20:36:36 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <f9d2a5e10804151031o1d09c1f9od0ad78dcf9b746c5@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79618>

"Russ Dill" <russ.dill@gmail.com> writes:

>>  I find it useful to use fairly short names for branches.  However,
>>  sometimes I would like to have a full sentence to actually describe
>>  what the branch is for, without having the peruse the actual commits.
> 
> Me too.
> 
>>  This information could of course be kept on a web page, but it would
>>  be nice to have it in the repo.
> 
> Like, putting your bug number in the branch name.
> 
>>  Is there any such branch annotation command?
>>  Ideally I'd like to see a sentence displayed next to the branch name
>>  when I use "git-branch".
>>  Perhaps, git-branch --info or something.
> 
> The problem is that a branch is just a floating name for a line of
> development. Its not really a "thing" in the repository like a tag or
> a commit. You'd need to make some sort of special tag that describes
> the branch or somesuch.

Errr... not exactly.  It is true that refs such like branches reside
outside object database[1], and that names of refs are purely local
matter (see old master -> origin mapping, and new refs/heads/* ->
refs/remotes/<remote>/* mapping).  But you can examine list of
branches in remote repository using e.g. git-ls-remote or its
equivalent in the git API.

So I think better solution would be to add this info somewhere outside
object database, for example in repository config (assuming that not
all branches would have description) as it already stores branch
related information, _and_ enhance commands to make use of this info,
not only git-branch, but also git-for-each-ref, git-show-refs and
git-ls-remote (and its equivalents).

Footnotes:
==========
[1] And have to be, Mercurial misdesign nothwithstanding
-- 
Jakub Narebski
Poland
ShadeHawk on #git
