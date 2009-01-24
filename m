From: malc@pulsesoft.com
Subject: Re: [PATCH v2] Change octal literals to be XEmacs friendly
Date: Sat, 24 Jan 2009 05:01:21 +0300
Message-ID: <878wp1mphq.fsf@linmac.oyster.ru>
References: <Pine.LNX.4.64.0901240219530.19590@linmac.oyster.ru> <874ozp79y4.fsf@Astalo.kon.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 24 03:02:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQXrJ-0003eL-J2
	for gcvg-git-2@gmane.org; Sat, 24 Jan 2009 03:02:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754138AbZAXCBb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 21:01:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753959AbZAXCBa
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 21:01:30 -0500
Received: from main.gmane.org ([80.91.229.2]:36093 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753883AbZAXCB3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 21:01:29 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LQXpr-0000ma-PC
	for git@vger.kernel.org; Sat, 24 Jan 2009 02:01:23 +0000
Received: from 83.167.112.74 ([83.167.112.74])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 24 Jan 2009 02:01:23 +0000
Received: from malc by 83.167.112.74 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 24 Jan 2009 02:01:23 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 83.167.112.74
User-Agent: Gnus/5.1008 (Gnus v5.10.8) XEmacs/21.4.20 (linux)
Cancel-Lock: sha1:sG61N3CeV231fdVS2z8hQxUC4IQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106947>

Kalle Olavi Niemitalo <kon@iki.fi> writes:

> Vassili Karpov <av1474@comtv.ru> writes:
>
>> #ooctal syntax on the other hand produces integers everywhere.
>
> GNU Emacs 20.7 doesn't support #o, but neither does it include

Bummer

> the ewoc and log-edit libraries required by the current git.el.

ewoc and log-edit are not part of XEmacs 21.4.20 (the version i am
using), furthermore make-temp-file is not available either, but those
problems, unlike the case/eql/literals issue, can be resolved without
touching git.el (One might argue that case can be fixed with defadvice
or other hackery, but that's a bit too much)

> It would be nice to have a comment in git.el saying which
> versions of Emacs and XEmacs it is supposed to support, but I
> guess people wouldn't bother testing those on every commit.

Well it doesn't "support" XEmacs at all.

-- 
mailto:av1474@comtv.ru
