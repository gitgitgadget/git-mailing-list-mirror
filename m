From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Feature Enhancement Idea.
Date: Wed, 23 Sep 2009 22:56:52 -0700 (PDT)
Message-ID: <m3bpl0c2cf.fsf@localhost.localdomain>
References: <5b5e291e0909222317q47ae36d4la470f17ec3902124@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Deon George <deon.george@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 24 07:57:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MqhKA-0006CT-S9
	for gcvg-git-2@lo.gmane.org; Thu, 24 Sep 2009 07:57:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752688AbZIXF4x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2009 01:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752518AbZIXF4x
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Sep 2009 01:56:53 -0400
Received: from mail-bw0-f210.google.com ([209.85.218.210]:55463 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752492AbZIXF4w (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2009 01:56:52 -0400
Received: by bwz6 with SMTP id 6so1059292bwz.37
        for <git@vger.kernel.org>; Wed, 23 Sep 2009 22:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=MIHvEpeEfTM8zh5lWB1tLmimtdpqKiReJ4t75qkYO04=;
        b=nHzH6576LETIH+zZFOdGJPvi/OyYb3WaSjoNobSng7m0lTC0DGNczkpEgLRAFDwDQO
         A5y9g6hzwsYQKE8q/zxA0IUXLIXf7G2/Fy77nhFUpWG2fY2FXCRfNlIr2GzFJwNowuw+
         ALd82rgk3ybm4icvIuqXIgCuoEiZNBnasxJsk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=t0ctaw+GRMHh64ChLV+SyY+RnAG7KCyzLRTJ6MAFJ2FWDgboGro0iLGFoO4GEZInuv
         FP+51EF3QY5CNoBgPF4qfUK0//vkBfwqtyMFQXE+pTa6iSzGOsz4kE/9KkddkSS5Lfyu
         RzRAqnJ6cuo1pDgqNkR+XOP7ewXTwOWNQTEFg=
Received: by 10.204.23.203 with SMTP id s11mr2676888bkb.17.1253771813608;
        Wed, 23 Sep 2009 22:56:53 -0700 (PDT)
Received: from localhost.localdomain (abvp218.neoplus.adsl.tpnet.pl [83.8.213.218])
        by mx.google.com with ESMTPS id 2sm2481914fks.3.2009.09.23.22.56.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 23 Sep 2009 22:56:52 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n8O5unxD006199;
	Thu, 24 Sep 2009 07:56:50 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n8O5umOV006196;
	Thu, 24 Sep 2009 07:56:48 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <5b5e291e0909222317q47ae36d4la470f17ec3902124@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129019>

Deon George <deon.george@gmail.com> writes:

> I'm not sure if this is the right place, but I thought I'd post my
> idea and maybe somebody will either redirect me to the right place, or
> give me that "that won't happen".
> 
> Im fairly new to GIT (wish I had discovered it long ago), and I really
> like using it - great work guys/garls :)
> 
> My idea is to enhance GIT to support (I'll call it) development
> "layers". The current design of GIT is that the working repository and
> working directory assume that all files belong together in the same
> project. I would like to see GIT go 3D and support layers, so that
> files (and/or file content) can belong to multiple repositories (or
> considered unique projects), even though the working tree presents all
> files as if they were one.

[cut very long description]

> Could this be included as part of GITs functionality (or is it
> possible already) ?

First, I assume there that you do not allow for the same file to
belong to different repositories.

Second, if all parts that you want to belong to other repository are
in separate subdirectories, and all files in those subdirectories
belong to this other repository, you can try either submodules 
(git-submodule), or subtree (subtree merge, or third-party git-subtree
helper).  Note also that this assume that you want to have 'master'
repository which indirectly or directly has al the files.


Third, if the above isn't what you want, then you can manually
intermingle working directories of different git repositories
(probably requiring decouplig of bare git repository (git-dir)
from working area (work-tree)).  Git repository know what files
it tracks, so you would only need to take care to ignore files
that belong to other repositories.

If it is to manual for you, and to error prone, you are welcome
to come up with set of scripts implementing "layers" feature you
want.  That is how initial version of submodule feature was done...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
