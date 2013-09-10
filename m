From: Andreas Krey <a.krey@gmx.de>
Subject: Re: [Proposal] Clonable scripts
Date: Tue, 10 Sep 2013 14:55:14 +0200
Message-ID: <20130910125514.GA22078@inner.h.apk.li>
References: <CADoiZqpec6rPOgPLPQFFfLdE+Cc4ZKtWs0Q0VSfKGm3b1Lai2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Niels Basjes <Niels@basjes.nl>
X-From: git-owner@vger.kernel.org Tue Sep 10 14:55:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJNTc-0006NR-64
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 14:55:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753928Ab3IJMzT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 08:55:19 -0400
Received: from continuum.iocl.org ([217.140.74.2]:55091 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751335Ab3IJMzS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 08:55:18 -0400
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id r8ACtEf23297;
	Tue, 10 Sep 2013 14:55:14 +0200
Content-Disposition: inline
In-Reply-To: <CADoiZqpec6rPOgPLPQFFfLdE+Cc4ZKtWs0Q0VSfKGm3b1Lai2g@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234432>

On Mon, 09 Sep 2013 22:48:42 +0000, Niels Basjes wrote:
...
> However I can imagine that a malicious opensource coder can create a
> github repo and try to hack the computer of a contributer via those
> scripts. So having such scripts is a 'bad idea'.

Given that half the repos out there are cloned to 'make install' in
them...it's still a bad idea.

> If those scripts were how ever written in a language that is build
> into the git program and the script are run in such a way that they
> can only interact with the files in the local git (and _nothing_
> outside of that) this would be solved.

I still think this is a nightmare of maintenance. You'd need a restricted
version of a language that doesn't allow access outside the repo (and
no TCP either), and someone will always miss some module...

Not that it wouldn't be cool, yet.

...
> Like I said, this is just a proposal and I would like to know what you
> guys think.

I think there are generally two use cases:

- Many people working on repos in an organization. Give them a wrapper
  script that does the clone (and also knows the clone URL already),
  that will set up hooks and configuration as needed.

- github-style cooperation. Add a make hooks to your Makefile that sets
  up the hooks your project seems to want. After all, this is for the
  developers to pre-check what they will submit, so it is in their own
  interest to have (and cross-read) the hooks.

Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
