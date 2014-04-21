From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: What is missing from Git v2.0
Date: Mon, 21 Apr 2014 16:45:06 -0400
Message-ID: <20140421204506.GD5105@thunk.org>
References: <CAMP44s17h4Tjg+VaMF0atLep8t-0HVp4UDr1WE2wYnEuZ07eaQ@mail.gmail.com>
 <53557071.5040500@gmail.com>
 <535572b73183b_414c80b30863@nysa.notmuch>
 <CAHGBnuM3TVMbow7Zbb9QnEeJOR9aZY1dwj2CWqs-Ti_HDppE1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 21 22:45:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcL5W-0006sT-Qq
	for gcvg-git-2@plane.gmane.org; Mon, 21 Apr 2014 22:45:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754482AbaDUUpK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2014 16:45:10 -0400
Received: from imap.thunk.org ([74.207.234.97]:52338 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754456AbaDUUpI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2014 16:45:08 -0400
Received: from root (helo=closure.thunk.org)
	by imap.thunk.org with local-esmtp (Exim 4.80)
	(envelope-from <tytso@thunk.org>)
	id 1WcL5P-0002V4-8E; Mon, 21 Apr 2014 20:45:07 +0000
Received: by closure.thunk.org (Postfix, from userid 15806)
	id 828365804E2; Mon, 21 Apr 2014 16:45:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=thunk.org; s=ef5046eb;
	t=1398113106; bh=Tfb9nO6GCjbqz3a5g64OTDilVX9PGOSjY+9J+KmXJMY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gGvso97F8NZsNSfwIEPgNbnJMGDOUs71TFoKa+Wa6luPZ6PgMGgRIhdh3ArYYdrGw
	 MiA5LQjxOoQAgwnU890YSWx4vDa3krIxc2b7CRGoJRXabJvjc64o6H1qMiyenAk+Lo
	 vzRom2vm278V+8jwuU5ko7/hmjjEZoR2S0GnxpiA=
Content-Disposition: inline
In-Reply-To: <CAHGBnuM3TVMbow7Zbb9QnEeJOR9aZY1dwj2CWqs-Ti_HDppE1w@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246632>

On Mon, Apr 21, 2014 at 09:47:57PM +0200, Sebastian Schuberth wrote:
> On Mon, Apr 21, 2014 at 9:34 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> 
> > I have these aliases as well, except br => b, and cp => pi. 'br' is probably
> > better, but not sure as 'cp' which can be confusing.
> 
> If by confusing you refer to "cp" to copy files, that's actually what
> I like about it: cherry-pick is somewhat like copying commits, thus
> "cp" makes much sense to me.

The problem is that between "git rm" and "git mv", if we default "git
cp" to mean "cherry-pick" there could easily be user confusion.

I'm not sure that cherry-pick is used that often it really needs a two
character shortcut.  Maybe just "git pick"?

Personally, "git branch" and "git checkout" are finger macros that I
type very quickly, so creating two character alias probably wouldn't
save me that much time.  But I do appreicate that there are folks for
which such aliases might be useful.

						- Ted
