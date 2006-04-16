From: Seth Falcon <sethfalcon@gmail.com>
Subject: Re: git-svn and Author files question
Date: Sat, 15 Apr 2006 18:57:27 -0700
Message-ID: <m2ejzys2ns.fsf@ziti.fhcrc.org>
References: <m21wvzx5e6.fsf@ziti.fhcrc.org>
	<20060415215850.GB20468@hand.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Apr 16 03:57:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUwWH-0000R4-MG
	for gcvg-git@gmane.org; Sun, 16 Apr 2006 03:57:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbWDPB5a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 15 Apr 2006 21:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932188AbWDPB5a
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Apr 2006 21:57:30 -0400
Received: from nz-out-0102.google.com ([64.233.162.200]:34243 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932189AbWDPB5a (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Apr 2006 21:57:30 -0400
Received: by nz-out-0102.google.com with SMTP id o37so339338nzf
        for <git@vger.kernel.org>; Sat, 15 Apr 2006 18:57:29 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:subject:references:from:date:in-reply-to:message-id:user-agent:mime-version:content-type;
        b=RmgMIHZ3pRb3BYGo2jVX0QbMqi2/YkTDF4v3YlsYtfaCMVwdBR+5h/A8UrT+iYxsnQNBerpj3jn0r3tE78F4Qm7uTzgPbsYy2MxxYQVwDe5TLtCKgTXwvxmmboxFXLdbPbvS5Y3vtXakQxi1kmNOD6CvcJTamF7YkHZLE5cKgog=
Received: by 10.36.145.2 with SMTP id s2mr4428605nzd;
        Sat, 15 Apr 2006 18:57:29 -0700 (PDT)
Received: from ziti.fhcrc.org ( [67.171.24.140])
        by mx.gmail.com with ESMTP id 36sm1925146nzk.2006.04.15.18.57.28;
        Sat, 15 Apr 2006 18:57:28 -0700 (PDT)
To: git@vger.kernel.org
In-Reply-To: <20060415215850.GB20468@hand.yhbt.net> (Eric Wong's message of "Sat, 15 Apr 2006 14:58:50 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (darwin)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18769>

Eric Wong <normalperson@yhbt.net> writes:
> There were some embarassing bugs between the git-svn in rc1 and rc2.
> Current versions should work.  Rutger was right about the file format,
> same as the other importers.

Thanks for the explanation (and thanks to Rutger as well for the
reply!).

I managed to get git-svn fetch to work by specifying an author file
with -A.

I'm a bit confused about why I have to do this.  Is there a way around
this?  Or perhaps a way to force a bogus email address based on svn
user name?

[ok, maybe I'm less confused than I'm letting on: the email
requirement is, I think, because that's what suits the main git
"customers".  If I was using git for a project's primary SCM, I would
have no problem with this.  In fact, we started using email addresses
as user names in svn a long time ago.  

But it seems to me that (1) using git to track a project that uses a
less featureful SCM is way cool, and (2) having to manually muck with
an authors file is kinda uncool.]

> Sorry about so long to reply to questions this week, left hand/wrist is
> wrecked.

Hope it heals quickly!


Thanks for listening and again for the help,

+ seth
