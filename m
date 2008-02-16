From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: looking for example of following code across files
Date: Sat, 16 Feb 2008 01:16:56 -0800 (PST)
Message-ID: <m3pruxb6rh.fsf@localhost.localdomain>
References: <57E76010-D0F8-420C-A11D-8884832FD00D@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Rhodes, Kate" <masukomi@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 16 10:18:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQJBN-0007Bs-Et
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 10:18:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752278AbYBPJRE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Feb 2008 04:17:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752326AbYBPJRE
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Feb 2008 04:17:04 -0500
Received: from fg-out-1718.google.com ([72.14.220.155]:43443 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752137AbYBPJQ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Feb 2008 04:16:59 -0500
Received: by fg-out-1718.google.com with SMTP id e21so753576fga.17
        for <git@vger.kernel.org>; Sat, 16 Feb 2008 01:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=4UxKhntJSYJ/rAYyvRFk5439ppX3pmtmW37iDRKGbXw=;
        b=OubJbIEK6VwhBsRu7oKTY+bgwyVyFUTnyuQSmncz9zQ3CDQowr8/xsXocR5t8cz4nSRHLfcHLo9G3jGK5BGaiaAr4pDBjP7LaqOX/oEQ8lZgrUwFb8YlxSIlQAcRYvv9H3Uw6cfqoVJuY/zDsLj4GwG6AQmUjyR+ZbIiCAR2Qyg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=lEGyB63/XfIw5mkmT4OA20aH9OZSJoX1K1wbly3JKBi9ibFOqUboviQCbZkKFeg39HELcBMV7a9KuYQIp+bYqYsHT1+5R9ZKAnFZcTqibrf3pAlDEyEn0Zf24Ka0+7oDrFe0D9Dp8ga2jBNi9wMu0lQDzU5THIr59g6HvKyD28U=
Received: by 10.82.174.20 with SMTP id w20mr6964509bue.21.1203153417841;
        Sat, 16 Feb 2008 01:16:57 -0800 (PST)
Received: from localhost.localdomain ( [83.8.221.186])
        by mx.google.com with ESMTPS id z40sm8124047ikz.4.2008.02.16.01.16.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 16 Feb 2008 01:16:56 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m1G9GqBJ010050;
	Sat, 16 Feb 2008 10:16:52 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m1G9GpQd010047;
	Sat, 16 Feb 2008 10:16:51 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <57E76010-D0F8-420C-A11D-8884832FD00D@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74033>

"Rhodes, Kate" <masukomi@gmail.com> writes:

> I seem to remember that when Linus was giving the tech-talk to the
> folks at Google he mentioned Git being able to follow a block of code
> as it was moved from file to file, but I'm having a hard time finding
> an actual example of how that plays out. I'd love to be able to
> demonstrate this to people but I'm not quite sure of the steps I'd
> need to do to accomplish this.
> 
> I've gotten as far as using git ls-tree to track down the sha1 of the
> blob I want to follow, which I'm assuming is the key to making this
> happen but I'm not sure where to go from there. :(
> 
> Can someone please point me to an example showing how to go about this?

For example in git.git repository, try "git gui blame revision.c".
The 9th fragment, the 'path_name' function, was moved there from the
file "rev-list.c".

This is the commit that added the code:

  commit e646de0d14bac20ef6e156c1742b9e62fb0b9020
  Author:	Junio C Hamano <junkio@cox.net>  czw lut 23 07:10:24 2006
  Committer:	Junio C Hamano <junkio@cox.net>  pi? lut 24 08:44:42 2006
  Original File:	rev-list.c

  rev-list --objects: use full pathname to help hashing.

  This helps to group the same files from different revs together,
  while spreading files with the same basename in different
  directories, to help pack-object.

  Signed-off-by: Junio C Hamano <junkio@cox.net>

This is the commit that moved the code

  commit ae563542bf10fa8c33abd2a354e4b28aca4264d7
  Author:	Linus Torvalds <torvalds@osdl.org>  nie lut 26 01:19:46 2006
  Committer:	Junio C Hamano <junkio@cox.net>  pon lut 27 00:33:27 2006

  First cut at libifying revlist generation

  This really just splits things up partially, and creates the
  interface to set things up by parsing the command line.

  No real code changes so far, although the parsing of filenames is a bit
  stricter. In particular, if there is a "--", then we do not accept any
  filenames before it, and if there isn't any "--", then we check that _all_
  paths listed are valid, not just the first one.

  The new argument parsing automatically also gives us "--default" and
  "--not" handling as in git-rev-parse.

  Signed-off-by: Linus Torvalds <torvalds@osdl.org>
  Signed-off-by: Junio C Hamano <junkio@cox.net>

You can check the commits using gitweb; unfortunately blame in gitweb
is usually disabled, and it dies not have fancy "git gui blame"
showing of code movements.

P.S. Sorry, I've just noticed that the dates are in my locale...
-- 
Jakub Narebski
Poland
ShadeHawk on #git
