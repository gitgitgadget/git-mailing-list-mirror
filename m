From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb doesn't work with bare repositories
Date: Sat, 29 Nov 2008 16:25:12 -0800 (PST)
Message-ID: <m3bpvyjc0r.fsf@localhost.localdomain>
References: <4931D23A.10402@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: lolkaantimat@gmail.com
X-From: git-owner@vger.kernel.org Sun Nov 30 01:26:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6a8u-0007Sa-5i
	for gcvg-git-2@gmane.org; Sun, 30 Nov 2008 01:26:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753636AbYK3AZQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Nov 2008 19:25:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753570AbYK3AZQ
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Nov 2008 19:25:16 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:26910 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753444AbYK3AZO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Nov 2008 19:25:14 -0500
Received: by nf-out-0910.google.com with SMTP id d3so1024821nfc.21
        for <git@vger.kernel.org>; Sat, 29 Nov 2008 16:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=NZr6VuTWHyQgsmTLp8EaygljWmNBVIIRVhoz5Nq40xQ=;
        b=AOg1HHRqBgF2E8eHJ48xe6aHyUwToH9v4hu4VX5ks4OA/HwGpmGCZ/dccelMPdquOK
         xiJcSfywnig2VBF4T3VjwvscvVEQwi1PtASjG8/aL8HaBcsOyz3nVgc46k8PtVOwkZ5B
         ZzgWJ9nCJaQSMnsOGubBXmMB42F5+YWuZFsG0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=lPqRv4S1NewUs6HCf43sCn3wEtZxEGVqZ0sTosmGKumjlbqTw4o2TvOy+kcUIomJb+
         mEvD24JohFc9o8eEhRhkET3EK6FsxzuhiuID9iKdT2UXFtKyMG7ZyvgkPcqcFyBNaJ28
         /gVynyr8NOhBwVH5gcisrYHgTmjZJ3RYPeNvY=
Received: by 10.210.92.8 with SMTP id p8mr10762742ebb.101.1228004712914;
        Sat, 29 Nov 2008 16:25:12 -0800 (PST)
Received: from localhost.localdomain (abvs96.neoplus.adsl.tpnet.pl [83.8.216.96])
        by mx.google.com with ESMTPS id 23sm7873848eya.57.2008.11.29.16.25.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 29 Nov 2008 16:25:12 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id mAU0PBCe030424;
	Sun, 30 Nov 2008 01:25:12 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id mAU0PAKU030421;
	Sun, 30 Nov 2008 01:25:10 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4931D23A.10402@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101939>

Evgeniy Ivanov <lolkaantimat@gmail.com> writes:

> I have installed gitweb and can't make it work with bare repos.

Actually gitweb treats all repositories as bare repositories,
and doesn't touch at all neither index nor working area.

> I have such config:
> $my_uri = "http://mysite.org:8000";
> $projectroot = "/srv/www/gamekeeper/htdocs/projects";
> 
> In projects I have created bare repo:

I assume that you have done:

$ cd /srv/www/gamekeeper/htdocs/projects

> $ mkdir some

I assume that you meant here

$ mkdir some.git

> $ cd some.git
> $ git --bare init
> $ cd /some_git_repo
> $ git push /srv/www/gamekeeper/htdocs/projects master

I assume that you meant:

$ git push /srv/www/gamekeeper/htdocs/projects/some.git master

> 
> Everything fine, but when I click the link on some.git I don't have a
> page (just "Error 404").

What error? Please provide _exact_ error message.

Does the problem persists with the following corrections? Do you
have permissions set up correctly? How did you generate gitweb.cgi?

SAA#1 (Standard admin answer #1): WORKSFORME.
-- 
Jakub Narebski
Poland
ShadeHawk on #git
