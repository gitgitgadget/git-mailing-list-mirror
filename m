From: Alex Chiang <achiang@hp.com>
Subject: Re: [StGit RFC PATCH 0/6] add support for git send-email
Date: Mon, 30 Nov 2009 17:02:58 -0700
Message-ID: <20091201000258.GM12733@ldl.fc.hp.com>
References: <20091128194056.949.88791.stgit@bob.kio> <b8197bcb0911291405i6f052216q8717c34063320592@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: catalin.marinas@gmail.com, git@vger.kernel.org
To: Karl Wiberg <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Dec 01 01:03:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFGD1-0006iT-QT
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 01:03:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754112AbZLAACw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 19:02:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754082AbZLAACw
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 19:02:52 -0500
Received: from g4t0017.houston.hp.com ([15.201.24.20]:48598 "EHLO
	g4t0017.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754035AbZLAACv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2009 19:02:51 -0500
Received: from g1t0038.austin.hp.com (g1t0038.austin.hp.com [16.236.32.44])
	by g4t0017.houston.hp.com (Postfix) with ESMTP id 8ECA6380B0;
	Tue,  1 Dec 2009 00:02:58 +0000 (UTC)
Received: from ldl (linux.corp.hp.com [15.11.146.101])
	by g1t0038.austin.hp.com (Postfix) with ESMTP id 6E39130035;
	Tue,  1 Dec 2009 00:02:58 +0000 (UTC)
Received: from localhost (ldl.fc.hp.com [127.0.0.1])
	by ldl (Postfix) with ESMTP id 48058CF000F;
	Mon, 30 Nov 2009 17:02:58 -0700 (MST)
Received: from ldl ([127.0.0.1])
	by localhost (ldl.fc.hp.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u72EwZGMzSkm; Mon, 30 Nov 2009 17:02:58 -0700 (MST)
Received: by ldl (Postfix, from userid 17609)
	id 340F8CF000D; Mon, 30 Nov 2009 17:02:58 -0700 (MST)
Content-Disposition: inline
In-Reply-To: <b8197bcb0911291405i6f052216q8717c34063320592@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134152>

* Karl Wiberg <kha@treskal.com>:
> On Sat, Nov 28, 2009 at 8:50 PM, Alex Chiang <achiang@hp.com> wrote:
> 
> > stg mail still has some nice features over git send-email, such
> > as the -v command line parameter and --prefix. Maybe at some point
> > in the future, we can migrate those features into git send-email and
> > continue thinning out stg mail.
> 
> Yes. But note that we tend to be conservative and not require a
> too-new git, so a patch adding such a dependency would have to wait a
> while. (I'm currently carrying two such patches in my experimental
> branch.)

Understood. For now, of course, all the changes that I'm
proposing should work with bog-standard, oldish git, since I
don't think the git send-email interface has changed in a while.

> > But I wanted to get some feedback first to make sure I'm going in the
> > right direction before going too much further.
> 
> I've read the patches, and it looks about right from where I stand.

Thank you very much for the review.

> Did you remember to run the regression tests? It's very helpful when
> reviewing to know that the regression suite passes at every point in
> the series.

Good idea. I've been running t/t1900-mail.sh at each stage since
my changes seem rather localized to sending mail.

Should I be running the entire suite?

/ac
