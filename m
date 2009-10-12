From: Israel Garcia <igalvarez@gmail.com>
Subject: Re: backup git repo on every commit
Date: Mon, 12 Oct 2009 09:25:44 -0500
Message-ID: <194a2c240910120725u72cdb588p3c66bc730e6953d@mail.gmail.com>
References: <194a2c240910120641sccf0e55xef4226269df78864@mail.gmail.com>
	 <20091012141544.GF9261@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Oct 12 16:40:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxM4D-0002uT-J0
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 16:40:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756821AbZJLO0W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 10:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756769AbZJLO0W
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 10:26:22 -0400
Received: from mail-bw0-f210.google.com ([209.85.218.210]:38755 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756715AbZJLO0V (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 10:26:21 -0400
Received: by bwz6 with SMTP id 6so3138519bwz.37
        for <git@vger.kernel.org>; Mon, 12 Oct 2009 07:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=f40FPGBe9ZMTIIFVkcZsNe7gdxEhjmkTWQoWUq3yew0=;
        b=PemKZvgdtq4gdgSvsAW2wDdlVGiQoSCrJGNg5wGr3Sr3q8EYr4/VeP1oprgVElGQuA
         8Rafo0lpGgXjMbzweUucedbaAPVdbFrK+9b5ss39l7zn/xbwgV5SIHVlZi2z9hMDU0GV
         mW8nIUKtRkRfOlyazpkGsY3OmBffi56RjoU9I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=VGVjKipGQkTrXs0JENn68D0a1CQLv2N8cLPHaupA0yXQ7rfMCCzDoacmXTHO1fpdcn
         gL41aUJIDUlIyoYOXv04QRSbht9VDehwKHLn2UTQeLl0FqrWijLyvFSIA1Uf1Yw5ajcR
         K9wdqUwOyRwBHApZMiTt9Mf9X9yh7QAbhU3zs=
Received: by 10.204.174.209 with SMTP id u17mr5187145bkz.7.1255357544654; Mon, 
	12 Oct 2009 07:25:44 -0700 (PDT)
In-Reply-To: <20091012141544.GF9261@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130018>

Hi Shawn,

That's OK, but I want to backup my git repo locally because I don't
have another remote git server. Can you modify your post-commit code
to backup the repo to /backups/git folder instead of using another
external git repo?

thanks in advance.
regards
Israel.

On 10/12/09, Shawn O. Pearce <spearce@spearce.org> wrote:
> Israel Garcia <igalvarez@gmail.com> wrote:
>> Which is the simplest  way to backup a git repository after every commit?
>
> Add a commit hook to push to another location, e.g.:
>
>   git remote add --mirror backup you@another.host:path/to/backup.git
>
>   cat >.git/hooks/post-commit
>   #!/bin/sh
>   git push backup
>   ^D
>
>   chmod a+x .git/hooks/post-commit
>
> --
> Shawn.
>


-- 
Regards;
Israel Garcia
