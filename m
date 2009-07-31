From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Feature Request: Capability to save and load the workspace
Date: Fri, 31 Jul 2009 02:20:25 -0700 (PDT)
Message-ID: <m3prbhryn7.fsf@localhost.localdomain>
References: <4A72AF1C.1020500@ubicom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Yakup Akbay <yakbay@ubicom.com>
X-From: git-owner@vger.kernel.org Fri Jul 31 11:20:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWoHy-0006q7-Bv
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 11:20:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751527AbZGaJU1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2009 05:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751315AbZGaJU1
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Jul 2009 05:20:27 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:61836 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751003AbZGaJU0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2009 05:20:26 -0400
Received: by ewy10 with SMTP id 10so1364521ewy.37
        for <git@vger.kernel.org>; Fri, 31 Jul 2009 02:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=1rpSAJhMAS5EaQjidKpEgSE2PhFL/m+jg+VSAMCen1A=;
        b=nU8qnN4NG7ycb7gusXE9oX2LJJwIL4xRyX69Smdhx7wmddZeEJeNOy8nbwyZzRUgj3
         Fjw33Td52/ojtPo7LxqHom9x83N8H/sM1ZC8DN9se5NIgxw6WuGsdJqFVWwbfX9f1T6O
         UhJkJLkjIUhgXaLyiw/tLSwN+UygDba+SvbME=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=nR1ZsylZWEqa6JsU9PVrzvZ5kFdpolSwQT+HSJO5/jvYIKjJ8pLyzDIR0kKVHXibrL
         SbZPS6PmNP3Lhs8bIYktiK7bdbhXKOVxHwa+KostwCkXzPqbyiPc/2oyH8SUtoaGsl1h
         923OIWbIFszLqlJSnaHw0DCH+uSbf2gc7oJYI=
Received: by 10.210.104.16 with SMTP id b16mr546886ebc.70.1249032026093;
        Fri, 31 Jul 2009 02:20:26 -0700 (PDT)
Received: from localhost.localdomain (abvk103.neoplus.adsl.tpnet.pl [83.8.208.103])
        by mx.google.com with ESMTPS id 5sm2523165eyf.18.2009.07.31.02.20.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 31 Jul 2009 02:20:25 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n6V9QtRN022344;
	Fri, 31 Jul 2009 11:26:55 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n6V9QqGt022341;
	Fri, 31 Jul 2009 11:26:52 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4A72AF1C.1020500@ubicom.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124517>

Yakup Akbay <yakbay@ubicom.com> writes:

> I'm not sure whether such a feature exists or not. But let me explain my
> concern.
> 
> Say, we have different profiles for different products. When I work on a
> profile (edit, configure, build etc.) I can't switch to another profile
> before I distclean the existing one. So, when I have to work on 2
> projects at the same time, I have to have 2 copies of the same source
> tree. This might be OK for 2, but if the repository is around 3 gigs
> this is not quite suitable for more than 2 profiles.
> 
> IT WOULD BE NICE to have a feature in git that allows us to save the
> current workspace then work on a different profile on a clean
> environment. Then save that profile and switch back to the previous
> profile at any time without losing the environment.

First, if the problem is repository size, you can use git-new-workdir
script from contrib/ to have multiple checkouts for a single
repository (but each checkout better be on different branch).

As to "save current state": take a look at 'git stash' command, which
saves state of working directory (and index).

-- 
Jakub Narebski
Poland
ShadeHawk on #git
