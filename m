From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] git-rebase.sh: Update USAGE string (No. 1)
Date: Sun, 03 Feb 2008 15:52:23 -0800 (PST)
Message-ID: <m3lk6161jo.fsf@localhost.localdomain>
References: <prvd3i9e.fsf@blue.sea.net> <ir15399p.fsf@blue.sea.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Mon Feb 04 00:53:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLodv-00076U-MD
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 00:53:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753557AbYBCXw2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 18:52:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753516AbYBCXw2
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 18:52:28 -0500
Received: from fk-out-0910.google.com ([209.85.128.184]:38627 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753471AbYBCXw1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 18:52:27 -0500
Received: by fk-out-0910.google.com with SMTP id z23so1749861fkz.5
        for <git@vger.kernel.org>; Sun, 03 Feb 2008 15:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=1WRvvIHSiDpOAOh+r3yzboSXdSC6aDWV/CCwv3CZ1zM=;
        b=Al42Ush7E1JUbEFz7jsLwY/Kl1uzJtza7K9k68hvi0ylF9j8uiivqdc0JrF6Hr0WRZ7pPBvvcCDdEl/U80EAwK8F/Jgyeua6Y3DvYBKfaLgpslz2nPTjwNOCkrSQ34nnDVNQYplQCii6c+V7/762NzYkx3plSZ1aP0e0tzmcAvo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=PCqz50/QGgaOFpGTYKB4/Bp2k20zsdyIbh36bjqJEC8oOEajAxv3iTHyjw3cC8eniY6ULrIvtmLPjxIMsXDEXNwKrDWjfNqqKKNuk+mG/GYvdT5i8w3niohFeicC3A1HXQKBZw2db8jwpWL2za/30za4KonOEHo2MkdhPF7Dikg=
Received: by 10.82.187.2 with SMTP id k2mr11777758buf.16.1202082746031;
        Sun, 03 Feb 2008 15:52:26 -0800 (PST)
Received: from localhost.localdomain ( [83.8.194.5])
        by mx.google.com with ESMTPS id g17sm18006002nfd.10.2008.02.03.15.52.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 03 Feb 2008 15:52:23 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m13NqELi008538;
	Mon, 4 Feb 2008 00:52:16 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m13NqBgp008535;
	Mon, 4 Feb 2008 00:52:11 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <ir15399p.fsf@blue.sea.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72424>

Jari Aalto <jari.aalto@cante.net> writes:

> Subject: Re: [PATCH] git-rebase.sh: Update USAGE string (No. 1)

What's with the "(No. 1)" here? If you want to add some comment that
should *not* be part of commit message, put it in brackets beside
PATCH, for example "[PATCH/RFC]", "[PATCH (resend)]", 
"[PATCH (amend)]", "[PATCH v2]" etc.

> Present the options in -s|--long (short, long) order.
> Mention merge and new whitespace option.
> 
> ed-off-by: Jari Aalto <jari.aalto AT cante.net>

I guess that it is copy'n'paste error, and it should be
Signed-off-by: Jari Aalto <jari.aalto@cante.net>

>  
> -USAGE='[--interactive | -i] [-v] [--onto <newbase>] <upstream> [<branch>]'
> +USAGE='[-i|--interactive] [-v|--verbose]
> +[--whitespace={nowarn|warn|error|error-all|strip}]

I would say "[--whitespace=<option>]" or "[--whitespace=<action>]"
instead of introducing yet not agreed upon notation (this has the
advantage of shortening synopisis, which should be short IMHO).

Besides here the mutually exclusive options are naturelly delimited,
so you can say just (I think):
   [--whitespace=nowarn|warn|error|error-all|strip]

> +[-m|--merge] [--onto <newbase>] <upstream> [<branch>]'
> +

-- 
Jakub Narebski
Poland
ShadeHawk on #git
