From: Bruce Korb <bruce.korb@gmail.com>
Subject: Re: Documentation problems
Date: Sun, 20 Sep 2009 11:37:25 -0700
Message-ID: <4AB67665.10402@gmail.com>
References: <4AB66D4C.70301@gmail.com> <vpqvdjdzd6x.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Sep 20 20:37:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MpRI2-0005pb-1l
	for gcvg-git-2@lo.gmane.org; Sun, 20 Sep 2009 20:37:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755343AbZITShZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Sep 2009 14:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754975AbZITShZ
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Sep 2009 14:37:25 -0400
Received: from mail-yw0-f173.google.com ([209.85.211.173]:63820 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754197AbZITShY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Sep 2009 14:37:24 -0400
Received: by ywh3 with SMTP id 3so2939095ywh.22
        for <git@vger.kernel.org>; Sun, 20 Sep 2009 11:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=caKqpzmvHtGMYCUPW6qvca5v/wQ2r/i3pvyeqPI85ak=;
        b=nJ0yjt++V4sBMnbnNYMMdM7TQxfm2KJpYBDJJSRksc5Xh+2C0tODcRLZi9BjpU09YW
         g2yj7AluN+Fd/QUPEGQ0KSqQGaC9+WoWqzFoZ3f+MQ3LGat0mw6/rMYoq5PEBDkTqD8/
         8V1YY/DADvlY/CAl95+Z+OcY4tmpT90lWo9s4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=djGADI+TsbGI/dou4FR3KMdzl9G70gGaeuSkQ2Plr5fiad38q6LsTEIYxaGpfaCwDw
         //7fcGVhEqktO4KJypJwzwUMitOr6kBF2K+47Fs73hEX4EHO97Bi9cnCmzyqJ02FbodJ
         Eq2Ubx8D9U5XwiN23wIGq6SvH/X8YaDTeb8AA=
Received: by 10.150.101.5 with SMTP id y5mr6983459ybb.85.1253471846903;
        Sun, 20 Sep 2009 11:37:26 -0700 (PDT)
Received: from ?10.10.1.101? (adsl-75-2-129-55.dsl.pltn13.sbcglobal.net [75.2.129.55])
        by mx.google.com with ESMTPS id 21sm1576568ywh.13.2009.09.20.11.37.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 20 Sep 2009 11:37:26 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090310)
In-Reply-To: <vpqvdjdzd6x.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128854>

Hi Matthieu,
>> I'm trying to figure out what a ``tree-ish''.

>> I need a translation.  :(  Thank you.  Regards, Bruce
> 
> tree = directory (with its content).
> 
> For example, the last commit in the current branch is a Git object of
> type "commit", which contains mostly a log message, a few headers, and
> a pointer to the tree object corresponding to the content of the
> directory in which you made the commit (modulo what you excluded from
> the commit of course). Therefore, the name of this commit, although
> not really a tree, is a tree-ish in that it talks about one and only
> one tree. You could name it HEAD, a sha1sum (like
> 5a2abc12d64a5e00daa6aebbb673715f365a564a), the name of the branch
> (like "master"), ...

Since I haven't created any any branches (to my knowledge), it seems
that "master" is the magic branch name.  My goal was just to get a
list of managed files.  Is "master" going to remain my "HEAD" now?
(Assuming I don't do something to make a new branch.  One branch
is enough for my little one person project....)

> Just type "git ls-tree --name-only".
Ah.  Thank you.
> git-ls-tree is the old way to
> refer to the command name. Normally, any reference to dashed names
> should have been removed from the documentation by now (so most likely
> you see it in your distro because it's an old enough version,
> otherwise, it's a bug in the doc).

$ git --version
git version 1.6.0.2

I guess the man pages and installation were out of sync for that release.

Thank you for the quick reply!  Regards, Bruce
