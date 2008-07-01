From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [OT] Your branch is ahead of the tracked remote branch 'origin/master' by 50 commits.
Date: Tue, 01 Jul 2008 05:47:36 -0700 (PDT)
Message-ID: <m38wwlhinq.fsf@localhost.localdomain>
References: <20080701091347.GA11817@elte.hu> <80iqvq2bw0.fsf@tiny.isode.net>
	<20080701101414.GG31309@elte.hu> <20080701114149.GB6662@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ingo Molnar <mingo@elte.hu>,
	Bruce Stephens <bruce.stephens@isode.com>, git@vger.kernel.org
To: =?iso-8859-15?q?SZEDER_G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Jul 01 14:48:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDfHi-00067X-D5
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 14:48:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754989AbYGAMrl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Jul 2008 08:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753230AbYGAMrk
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jul 2008 08:47:40 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:33829 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756619AbYGAMrj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Jul 2008 08:47:39 -0400
Received: by ug-out-1314.google.com with SMTP id h2so391775ugf.16
        for <git@vger.kernel.org>; Tue, 01 Jul 2008 05:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding:date;
        bh=ol1hcRgSZt+WqBXAxNCaEPBlWUkVK3lNYEtxLhLY9Z4=;
        b=Qu0sQxxbxBS7TBntt6exDG1VORU+MCNYQgJ/zQrRv6gX8S9N3x8Vj5KAQd3MGqe3Ei
         gdmUA6FPQOSl4zYU5zh+NCCYWYZqbFsyx8s4sGLJ/cVKTE/lz9JaRS4bDGpyrEZsFZhX
         kYRp4wnBsfW0fxg+q+5kxwNOkARkk4FRsmaeQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding:date;
        b=tgsu5+N+NCDgPtfW5CCIBKByh/Ik1i3LEhQvmvSRiBb5/OHOwi70nsiRRHYcZ3t78V
         9i+RvPQXEm09S3DdpTGud/dg8kFrkXYWJ5h30C9xrug4W291f75U5tYRNxYWLemSdr6r
         UnAUGsmPZIuiSKDgHoE3t8Kk9Pg8oDTXXGCnA=
Received: by 10.67.96.9 with SMTP id y9mr316998ugl.24.1214916457864;
        Tue, 01 Jul 2008 05:47:37 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.248.226])
        by mx.google.com with ESMTPS id p34sm2102857ugc.41.2008.07.01.05.47.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Jul 2008 05:47:36 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m61CpN0K029834;
	Tue, 1 Jul 2008 14:51:23 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m61CpLj1029830;
	Tue, 1 Jul 2008 14:51:21 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20080701114149.GB6662@neumann>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87032>

SZEDER G=E1bor <szeder@ira.uka.de> writes:

> how about displaying the current branch in the command prompt?
>=20
> >From contrib/completion/git-completion.bash:
>=20
>   #    4) Consider changing your PS1 to also show the current branch:
>   #        PS1=3D'[\u@\h \W$(__git_ps1 " (%s)")]\$ '
>   #
>   #       The argument to __git_ps1 will be displayed only if you
>   #       are currently in a git repository.  The %s token will be
>   #       the name of the current branch.

Because I alos use StGit, I have added to my prompt visual
differentiation if the branch is under StGit control.

But I have my own git prompt function, based on git-completion.bash
but different.  It shows current branch (or "HEAD" if on detached
HEAD), current repository, and current working directory.  It laso has
number of command in history, the same as in my ordinary prompt.

--=20
Jakub Narebski
Poland
ShadeHawk on #git
