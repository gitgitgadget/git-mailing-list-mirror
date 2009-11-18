From: Jonathan del Strother <maillist@steelskies.com>
Subject: Re: Hey - A Conceptual Simplication....
Date: Wed, 18 Nov 2009 13:18:29 +0000
Message-ID: <57518fd10911180518y4dbb65e2kf28d8ccc88bfb13b@mail.gmail.com>
References: <005a01ca684e$71a1d710$54e58530$@com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, torvalds@osdl.org
To: George Dennie <gdennie@pospeople.com>
X-From: git-owner@vger.kernel.org Wed Nov 18 15:03:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAl7z-0004Y9-8H
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 15:03:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757096AbZKRODL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Nov 2009 09:03:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757083AbZKRODK
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Nov 2009 09:03:10 -0500
Received: from juliet.asmallorange.com ([207.210.105.70]:47126 "EHLO
	juliet.asmallorange.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757080AbZKRODK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Nov 2009 09:03:10 -0500
X-Greylist: delayed 2660 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Nov 2009 09:03:09 EST
Received: from mail-gx0-f226.google.com ([209.85.217.226]:45067)
	by juliet.asmallorange.com with esmtpsa (TLSv1:RC4-MD5:128)
	(Exim 4.69)
	(envelope-from <maillist@steelskies.com>)
	id 1NAkQv-0003qB-CI
	for git@vger.kernel.org; Wed, 18 Nov 2009 08:18:53 -0500
Received: by gxk26 with SMTP id 26so980316gxk.1
        for <git@vger.kernel.org>; Wed, 18 Nov 2009 05:18:49 -0800 (PST)
Received: by 10.150.32.1 with SMTP id f1mr2281370ybf.96.1258550329123; Wed, 18 
	Nov 2009 05:18:49 -0800 (PST)
In-Reply-To: <005a01ca684e$71a1d710$54e58530$@com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - juliet.asmallorange.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - steelskies.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133176>

2009/11/18 George Dennie <gdennie@pospeople.com>:
> A Clean checkout command might be...
>
> The Git model does not seem to go far enough conceptually, for some
> unexplainable reason...
>
> In particular, why is Git not treating the entire working tree as the
> versioned document (qualified of course by the .gitignore file).
>
> Instead, Git is treating a manually maintained list of files within t=
he
> working tree as the versioned document, this list being initialized a=
nd
> manually amended by the "Git add/rm/mv" commands, etc.
>
> The result is conceptual complexity and rather counter-intuitive beha=
vior.
> For example, adding and renaming files outside of Git is not consider=
ed
> editing the version until you subsequently do a "Git Add ." Contrast =
that
> with editing or deleting files outside of Git. Yet adding and renamin=
g files
> and folders is a significant part of substantive projects, especially=
 in the
> early stages and experimental branches.
>
> Granted, this is not a big deal functionally, but what is being lost =
is
> conceptual simplicity (and consistency, in my book) and conceptual
> simplicity is a key value point, if not THE key.
>
> Also can we augment checkout to totally CLEAN the working directory p=
rior to
> a restore. If necessary we can augment .gitignore to stipulate those =
files
> or folders that should be excluded from the cleaning. This suggestion=
 is in
> recognition of the fact that if you =C2=A0are not versioning the file=
, it is
> typically trash; which becomes the case when the entire working treat=
 is
> treated as the versioned document.
>
> Consequently, I recommend the following new commands:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0"Git commit -x" =C2=A0 -- performs a "Git =
add ." then a "Git commit"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0"Git checkout -x" -- that clean the workin=
g tree prior to perform a
> checkout
>


Perhaps try 'git commit -a' and 'git checkout -f' ?
