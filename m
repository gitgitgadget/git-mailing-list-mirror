From: =?ISO-8859-1?Q?Ingo=20Br=FCckl?= <ib@wupperonline.de>
Subject: Re: [PATCH] stash: Don't paginate by default with list command
Date: Tue, 30 Aug 2011 20:24:04 +0200
Message-ID: <4e5d2ac6.64676448.bm000@wupperonline.de>
References: <1314726104-sup-5174@pinkfloyd.chass.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 30 20:24:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QySzL-0002oc-Eq
	for gcvg-git-2@lo.gmane.org; Tue, 30 Aug 2011 20:24:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755943Ab1H3SYi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Aug 2011 14:24:38 -0400
Received: from smtp-a.tal.de ([81.92.1.9]:48160 "EHLO smtp-a.tal.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755515Ab1H3SYh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Aug 2011 14:24:37 -0400
Received: from point.localnet (mue-88-130-110-172.dsl.tropolys.de [88.130.110.172])
	(Authenticated sender: ib@wtal.de)
	by smtp-a.tal.de (Postfix) with ESMTP id 3897C11E36A5
	for <git@vger.kernel.org>; Tue, 30 Aug 2011 20:24:35 +0200 (CEST)
Received: from ib by point.localnet with local (masqmail 0.2.21) id
 1QySzF-2wV-00 for <git@vger.kernel.org>; Tue, 30 Aug 2011 20:24:37 +0200
In-Reply-To: <1314726104-sup-5174@pinkfloyd.chass.utoronto.ca>
X-Mailer: blueMail/Linux 1.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180430>

Ben Walton wrote on Tue, 30 Aug 2011 13:43:46 -0400:

> Excerpts from Ingo Br=FCckl's message of Tue Aug 30 13:21:18 -0400 20=
11:

>> The output of "stash list" is such that piping into a pager
>> normally isn't necessary but annoying, so disable it by default.

> If you $PAGER is less and you use the default LESS environment value
> FRXS, this shouldn't be annoying at all.  Are you using either a
> different pager or a different value for LESS?

=46or some reason I have '-c' in LESS which must be convenient for a ca=
se
I currently don't remember.

Ingo
