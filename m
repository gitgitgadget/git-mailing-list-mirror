From: =?ISO-8859-1?Q?Ingo=20Br=FCckl?= <ib@wupperonline.de>
Subject: Re: [PATCH] stash: Don't paginate by default with list command
Date: Wed, 31 Aug 2011 20:18:13 +0200
Message-ID: <4e5e7b19.1b946de8.bm000@wupperonline.de>
References: <4e5d2ac6.64676448.bm000@wupperonline.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 31 20:20:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QypON-0000Vi-H2
	for gcvg-git-2@lo.gmane.org; Wed, 31 Aug 2011 20:20:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196Ab1HaST6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 31 Aug 2011 14:19:58 -0400
Received: from smtp-a.tal.de ([81.92.1.9]:41585 "EHLO smtp-a.tal.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757027Ab1HaST5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Aug 2011 14:19:57 -0400
Received: from point.localnet (mue-88-130-112-016.dsl.tropolys.de [88.130.112.16])
	(Authenticated sender: ib@wtal.de)
	by smtp-a.tal.de (Postfix) with ESMTP id 1435411E450C
	for <git@vger.kernel.org>; Wed, 31 Aug 2011 20:19:54 +0200 (CEST)
Received: from ib by point.localnet with local (masqmail 0.2.21) id
 1QypOB-5ti-00 for <git@vger.kernel.org>; Wed, 31 Aug 2011 20:19:51 +0200
In-Reply-To: <4e5d2ac6.64676448.bm000@wupperonline.de>
X-Mailer: blueMail/Linux 1.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180500>

I wrote on Tue, 30 Aug 2011 20:24:04 +0200:

> Ben Walton wrote on Tue, 30 Aug 2011 13:43:46 -0400:

>> Excerpts from Ingo Br=FCckl's message of Tue Aug 30 13:21:18 -0400 2=
011:

>>> The output of "stash list" is such that piping into a pager
>>> normally isn't necessary but annoying, so disable it by default.

>> If you $PAGER is less and you use the default LESS environment value
>> FRXS, this shouldn't be annoying at all.  Are you using either a
>> different pager or a different value for LESS?

> For some reason I have '-c' in LESS which must be convenient for a ca=
se
> I currently don't remember.

Now I know again. '-c' is within my LESS because I like small "git diff=
"
output printed on an erased terminal. I think it is easier to overview =
that
way.

With "git stash list" I'd like it the other way, because that output is
just a simple list (and usually very small in my case).

Ingo
