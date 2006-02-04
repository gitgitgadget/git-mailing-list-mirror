From: Mark Wooding <mdw@distorted.org.uk>
Subject: Re: [PATCH] config: Rummage through ~/.gitrc as well as the repository's config.
Date: Sat, 4 Feb 2006 10:22:58 +0000 (UTC)
Organization: Straylight/Edgeware development
Message-ID: <slrndu9042.2i8.mdw@metalzone.distorted.org.uk>
References: <20060203203332.2718.13451.stgit@metalzone.distorted.org.uk> <7vacd7c4bm.fsf@assigned-by-dhcp.cox.net>
X-From: git-owner@vger.kernel.org Sat Feb 04 11:23:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F5KZQ-0006CF-Nq
	for gcvg-git@gmane.org; Sat, 04 Feb 2006 11:23:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946100AbWBDKXA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Feb 2006 05:23:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946099AbWBDKXA
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Feb 2006 05:23:00 -0500
Received: from excessus.demon.co.uk ([83.105.60.35]:48171 "HELO
	metalzone.distorted.org.uk") by vger.kernel.org with SMTP
	id S1946100AbWBDKW7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Feb 2006 05:22:59 -0500
Received: (qmail 22321 invoked by uid 110); 4 Feb 2006 10:22:58 -0000
To: git@vger.kernel.org
Received: (qmail 22307 invoked by uid 9); 4 Feb 2006 10:22:58 -0000
Path: not-for-mail
Newsgroups: mail.vger.git
NNTP-Posting-Host: metalzone.distorted.org.uk
X-Trace: metalzone.distorted.org.uk 1139048578 21065 172.29.199.2 (4 Feb 2006 10:22:58 GMT)
X-Complaints-To: usenet@distorted.org.uk
NNTP-Posting-Date: Sat, 4 Feb 2006 10:22:58 +0000 (UTC)
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15584>

Junio C Hamano <junkio@cox.net> wrote:
> Mark Wooding <mdw@distorted.org.uk> writes:
>
>> I'm fed up of setting user.email in every repository I own.
>
> That is what --template-dir to init-db is for (it works in an
> already initialized git repository, but it does not overwrite
> files).

Except that git-clone has already made a .git/config file, so it won't
be overwritten by git-init-db --template-dir.  git-init-db doesn't do
merging of config file lines, and rightly so -- it'd just get too
confusing.

>> I want to put this somewhere central, and I shouldn't have to
>> log in again to make it take effect.
>
> I do not understand about logging in again.  If you are talking
> about environment variables, ". ~/.env" would work nicely.

Argh.  In every terminal and screen window, restart Emacs, ...  Logging
out looks like the better plan.

What's the objection to a ~/.gitrc?  (If it's just new-feature
resistance, I can live with that; I'm just interested.)

-- [mdw]
