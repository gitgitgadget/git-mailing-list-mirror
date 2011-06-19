From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: help on importing
Date: Sun, 19 Jun 2011 08:23:16 -0700 (PDT)
Message-ID: <m3sjr5u9qg.fsf@localhost.localdomain>
References: <20110619180348.576ea06e.mihamina@bbs.mg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mihamina Rakotomandimby <mihamina@bbs.mg>
X-From: git-owner@vger.kernel.org Sun Jun 19 17:23:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYJqO-00059C-9g
	for gcvg-git-2@lo.gmane.org; Sun, 19 Jun 2011 17:23:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754306Ab1FSPXT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jun 2011 11:23:19 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:44821 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754239Ab1FSPXS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2011 11:23:18 -0400
Received: by fxm17 with SMTP id 17so507655fxm.19
        for <git@vger.kernel.org>; Sun, 19 Jun 2011 08:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type;
        bh=aDP8djIx+LVilNiqh2MO+seYaxIX+L5LwaQLW72aMo8=;
        b=T6Ud4vJMK4iVONk59L0Qemww920NPOAEzExmQsWlajB7d43u6rb8/GgMNbznJJw8Fm
         /EmVSqcOy1jaP8brXMF26gZy6EGv5YsUcoVeybwiANmggoCbER5hrVr9SK4go+HLGA5q
         8BSINWfguUbz3erts7DmloJBdxNstw5bjIfqw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=Vj3m1XDQRm/kfgObPqDSJfrwjKZvVjqsTN3bla5ssP0v0EjOwtBftJOYXXpsu5vial
         bD/hOUxI0YiXnPkpKdBhojiMO9VOg/OYBwMWwK1bbYfOawnsD9mcLPMYM1E5L+FY3L8H
         spjPOaKgpWi/PTCjCNaprtHP7ROrNPBwlq9IE=
Received: by 10.223.32.142 with SMTP id c14mr2391763fad.59.1308496997641;
        Sun, 19 Jun 2011 08:23:17 -0700 (PDT)
Received: from localhost.localdomain (absh236.neoplus.adsl.tpnet.pl [83.8.127.236])
        by mx.google.com with ESMTPS id q21sm2309860fan.16.2011.06.19.08.23.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 19 Jun 2011 08:23:16 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p5JFMjG0022877;
	Sun, 19 Jun 2011 17:22:55 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p5JFMVTh022867;
	Sun, 19 Jun 2011 17:22:31 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20110619180348.576ea06e.mihamina@bbs.mg>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176023>

Mihamina Rakotomandimby <mihamina@bbs.mg> writes:

> I made several commits to a small local program.
> When I list them with "git log" I see them.
> 
> To publish my work, I choosed to sign in a forge (like github, google
> code,...). I choosed forge.ocamlcore.org

Note that you don't have to choose _one_ place.  With distributed
version control systems you can interact with many remote repositories
(though only one would be called "origin" and would be the default
repository).

I for example push both to repo.or.cz and to GitHub.
 
> With my account creation, the forge automatically created an empty GIT
> repository.
> 
> I clone it with:
>
>   $ git clone git+ssh://rakotomandimby@forge.ocamlcore.org/gitroot/ocaml-crypt/ocaml-crypt.git
>   Initialized empty Git repository in /tmp/ocaml-crypt/ocaml-crypt/.git/
>   warning: You appear to have cloned an empty repository.
>
> I am surprised the initialisation is not in /tmp/ocaml-crypt/ocaml-crypt.git/.git/ 
> as I pulled "ocaml-crypt.git".

It is Git convention to use 'project/.git' for a working repository,
which working area (checked out files) in 'project/', while using
'project.git' for name of _bare_ repository, i.e. without working
directory.

  project/.git  ==  project.git
  project/          [no workdir]

> Anyway...
> When add+commit a file into "/tmp/ocaml-crypt/ocaml-crypt/", 
> I get no errors, but when pushing:
>
>   $ git push
>   No refs in common and none specified; doing nothing.
>   Perhaps you should specify a branch such as 'master'.
>   fatal: The remote end hung up unexpectedly
> 
> I don't understand...

The default Git behavior is to push *only* matching branches. With
this workflow you must push a branch explicitly first time. What you
need to do is to use

  $ git push --all

to push all branches, or "git push origin HEAD" to push only current
branch.

This behavior is configurable, either via `push.default` config
variable, or via `remote.origin.push`.

HTH
-- 
Jakub Narebski
Poland
ShadeHawk on #git
