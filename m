From: Marco Craveiro <marco.craveiro@gmail.com>
Subject: Ignore on commit
Date: Thu, 4 Oct 2012 17:45:50 +0100
Message-ID: <CAKRNd4w4Z-LS9O5ffkbTSZ0Guv4KCmWR=AtW3EpxQ2sSgazG=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 05 00:35:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtdj-00033L-92
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 00:11:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933454Ab2JDQpv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2012 12:45:51 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:36103 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932263Ab2JDQpu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 12:45:50 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so681196oag.19
        for <git@vger.kernel.org>; Thu, 04 Oct 2012 09:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=oh7scFGvtO6C9dXPketE6uHgVt+KKFrizh8Z+mwd39A=;
        b=fX5snJ7HZtuC96HQUShIuaCf2NaCQW65AG28RiV6/n8XpObzubsa0eWvXL7FZRAvxg
         /Ct79RcUIf3qu+FsMHfce8BnAU7AuiMLVPpnyl5GJ8vRdb3Z7IeLPiYMCv6lvfnEDguK
         3TiPw4mi6oU0jm8t+QWnVehhgpWDi+uTgDRIFXfIyUL560mba1ucOzghBViOwizf2WUA
         wz4Znrv8mnrl8nHoF6Dqi+tLQUg/U2AUNG5/wX0+ihrh9rvNgT9BQeSBzzJuYTxixMpK
         MYHX8jCBJzGhslCsFX4MNEUvZmOMs0mxOwaMybmmHZpsEDlTIhxiqjoURrhhO9BcIPos
         PBww==
Received: by 10.182.218.37 with SMTP id pd5mr4856918obc.24.1349369150120; Thu,
 04 Oct 2012 09:45:50 -0700 (PDT)
Received: by 10.76.102.20 with HTTP; Thu, 4 Oct 2012 09:45:50 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207010>

Hello gitters,

One of the very (very) few features I miss in svn is "ignore on
commit" (or, more generally, changelists). I'm not sure if this has
been discussed in the past - google failed me a bit due to spurious
matches - but I personally find it quite useful. The feature is
described here [1] (and graphically, here [2]).

The gist of it is, one can mark certain files as "ignore on commit"
and they get placed on a "special list" which shows up on status.
These lists are effectively a sub-division of modified (but not
staged). Up till now I have found the staging area to be quite
sufficient, but recently I hit a use case where I was modifying a
large number of files; some modifications were hacks required to get
the build to work but were not meant to ever get checked in, most
other files had real work. In cases like this its really useful to
mark the hacked files as "ignore on commit", so that a) we don't lose
track of them (as one would with git ignore, or with [4]) but b) we
won't check them in by mistake.

I found some tips on how to survive without change lists ([3], [4])
but they are a bit more cumbersome. Has this feature been discussed?

Thanks a lot for an amazing piece of software, and thanks for your time.

Cheers

Marco
-- 
So young, and already so unknown -- Pauli

blog: http://mcraveiro.blogspot.com

[1] http://svnbook.red-bean.com/en/1.6/svn.ref.svn.c.changelist.html
[2] http://blog.baljeetsingh.net/2009/02/tips-tricks-svn-ignore-on-commit.html
[3] http://stackoverflow.com/questions/10606809/git-equivalence-of-svn-changelist
[4] http://gitready.com/intermediate/2009/02/18/temporarily-ignoring-files.html
