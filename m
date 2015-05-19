From: Philippe De Muyter <phdm@macq.eu>
Subject: Re: identical hashes on two branches, but holes in git log
Date: Tue, 19 May 2015 23:47:20 +0200
Message-ID: <20150519214719.GA12732@frolo.macqel>
References: <20150519132958.GA21130@frolo.macqel> <xmqq617oa75l.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 19 23:47:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YupMH-0001wL-M2
	for gcvg-git-2@plane.gmane.org; Tue, 19 May 2015 23:47:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752153AbbESVr0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 17:47:26 -0400
Received: from smtp2.macqel.be ([109.135.2.61]:52062 "EHLO smtp2.macqel.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751353AbbESVrY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 17:47:24 -0400
Received: from localhost (localhost [127.0.0.1])
	by smtp2.macqel.be (Postfix) with ESMTP id CEFB0130D37;
	Tue, 19 May 2015 23:47:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at macqel.be
Received: from smtp2.macqel.be ([127.0.0.1])
	by localhost (mail.macqel.be [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id a9vgUlweyL2G; Tue, 19 May 2015 23:47:20 +0200 (CEST)
Received: from frolo.macqel.be (frolo.macqel [10.1.40.73])
	by smtp2.macqel.be (Postfix) with ESMTP id 3D87D130D12;
	Tue, 19 May 2015 23:47:20 +0200 (CEST)
Received: by frolo.macqel.be (Postfix, from userid 1000)
	id 22914DF06BC; Tue, 19 May 2015 23:47:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <xmqq617oa75l.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269411>

On Tue, May 19, 2015 at 09:01:10AM -0700, Junio C Hamano wrote:
> Philippe De Muyter <phdm@macq.eu> writes:
> 
> > Trying to understand, I have eventually done "git log" on my branch and
> > on v3.15 with the following commands :
> >
> > git log v3.15 --full-history --decorate=short | grep '^commit' > /tmp/3.15.commits
> > git log --full-history --decorate=short | grep '^commit' > /tmp/mybranch.commits
> 
> Either
> 
>     git log --oneline v3.15..HEAD ;# show what I have not in theirs
> 
> or
> 
>     gitk v3.15...HEAD ;# show our differences graphically

This shows the commits in my branch starting from the most recent common point,
thus my commits, but I see differences in the files not explained by my commits,
but by the fact that many older commits (between v3.13 and v3.14) are missing on
my branch, but still in both branches I have a commit called v3.14 with the
same hash.  Is that normal ?

Philippe
