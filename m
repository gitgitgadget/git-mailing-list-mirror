From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: How to host a github?
Date: Wed, 29 Jul 2009 02:31:07 -0700 (PDT)
Message-ID: <m3bpn33kfe.fsf@localhost.localdomain>
References: <24713161.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: jvsrvcs <jvsrvcs@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 11:31:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MW5VJ-0003UR-Rb
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 11:31:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751496AbZG2JbK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2009 05:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751458AbZG2JbK
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 05:31:10 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:59868 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751413AbZG2JbI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2009 05:31:08 -0400
Received: by fxm18 with SMTP id 18so265496fxm.37
        for <git@vger.kernel.org>; Wed, 29 Jul 2009 02:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=tvMxNHnZiaRu6w3pv7TFVAlc7AOW6QuNh4KonJByM5k=;
        b=VAjHRJUbTnQ9rCweoICEQYblaYtVRpCdjbE30tmmozMlokP7+duN+WJWJwFtZf5K/O
         r08wc75vNS6M7BaZE9QYjtXtn4Jbc0wVaSDluCLGH6QMXNOCDFbumCee+H9IBkru2Z8J
         qqSzwaAFZ+mxOgVcThC6CfZfCI+0Yhzjt106E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=mTZs078uDkS0IWhN/i0+IGdo55b4tkM3bYO6U9D/wnE2YBCTYmfFPiyap9zGamYqOw
         bvr8B/IjZf/TREzEJR2QypjoFcHEL9gMPA1vV0wsBsMw3guSgSBLR3rNlR9ZjHKEUuYQ
         2svhqdgBiZsYoIVZOspZ/R6oSSj+WtgAPGaaY=
Received: by 10.204.118.134 with SMTP id v6mr5466427bkq.2.1248859867938;
        Wed, 29 Jul 2009 02:31:07 -0700 (PDT)
Received: from localhost.localdomain (abvm110.neoplus.adsl.tpnet.pl [83.8.210.110])
        by mx.google.com with ESMTPS id 18sm2095430fks.40.2009.07.29.02.31.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 29 Jul 2009 02:31:07 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n6T9V5UO018307;
	Wed, 29 Jul 2009 11:31:05 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n6T9V2UN018304;
	Wed, 29 Jul 2009 11:31:02 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <24713161.post@talk.nabble.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124336>

jvsrvcs <jvsrvcs@gmail.com> writes:

> I want to share code with a few co-workers and I want to use git.
> 
> I installed git (cygwin), created a /project/ and then $cd project
> and then $ git init
> 
> I have found so much documentation as to what to do next, that
> I'm confused.

Read "Git User's Manual" (should be distributed with Git), check out
"Git Community Book" (http://book.git-scm.com).

More links at:
  http://git.or.cz/gitwiki/GitDocumentation
  http://git-scm.com/documentation

Some links here might also help:
  http://git.or.cz/gitwiki/BlogPosts

> 
> Do I have to create an account on github in order to share code with
> a few local developers?

No, you don't have to do that.
 
> Could I run some sort of server on my laptop in order to share code?
> (we only need to share during office hours).  Basically I just
> want to share code but do not want to sign up for an account
> on github.
> 
> How do I work this?

References about hosting git repositories, etc.:
* http://www.kernel.org/pub/software/scm/git/docs/user-manual.html#sharing-development
  "Git User's Manual", Chapter 4. Sharing development with others
* http://book.git-scm.com/4_setting_up_a_public_repository.html
  http://book.git-scm.com/4_setting_up_a_private_repository.html
  "Git Community Book", Setting up Public/Private Repository
* My answers to similar questions at StackOverflow:
  http://stackoverflow.com/questions/978052/githow-can-i-make-my-local-repository-available-for-git-pull/978417#978417
  http://stackoverflow.com/questions/1173101/do-i-need-a-server-to-use-git/1173623#1173623

References about Git on Windows:
  http://www.lostechies.com/blogs/jason_meridth/archive/2009/06/01/git-for-windows-developers-git-series-part-1.aspx
  http://gitster.livejournal.com/24080.html (msysGit, not Cygwin)

-- 
Jakub Narebski
Poland
ShadeHawk on #git
