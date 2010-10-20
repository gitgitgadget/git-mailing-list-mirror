From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: Re: bash completion broken on ubuntu 10.10?
Date: Wed, 20 Oct 2010 19:33:17 -0400
Message-ID: <0BBE4478-48AB-460E-A2D5-2121FC589886@gernhardtsoftware.com>
References: <20101020230409.GB1767@neumann>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu Oct 21 01:33:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8i9z-0003Ju-0Y
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 01:33:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267Ab0JTXdZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Oct 2010 19:33:25 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:41461 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751090Ab0JTXdY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Oct 2010 19:33:24 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id AEDD51FFC05B; Wed, 20 Oct 2010 23:33:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [10.10.10.10] (cpe-74-67-185-155.rochester.res.rr.com [74.67.185.155])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id 164AD1FFC057;
	Wed, 20 Oct 2010 23:33:13 +0000 (UTC)
In-Reply-To: <20101020230409.GB1767@neumann>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159450>


On Oct 20, 2010, at 7:04 PM, SZEDER G=E1bor wrote:

> Hi,
>=20
> Git's bash completion script offers possible arguments to some
> options, e.g. it lists pretty formats after 'git log --pretty=3D<TAB>=
',
> merge tools after 'git mergetool --tool=3D<TAB>', refs after 'git com=
mit
> --reuse-message=3D<TAB>', etc.
>=20
> On a three day old ubuntu 10.10 install these don't work anymore; the
> completion script offers the list of files in all those cases.

> I don't have any ideas what could possibly be wrong here (but it's to=
o
> late here for any bright ideas anyway...).  Could someone confirm or
> deny this behaviour on ubuntu 10.10?

Confirmed.  Completion works properly on OS X, but fails on Ubuntu 10.1=
0

OS X 10.6.4:
  bash: 3.2.48
  git:  1.7.3.1.209.g52408 (next + my t/gitweb-lib patch)
  output:
$ git log --pretty=3D<tab><tab>
email     full      medium    raw      =20
format:   fuller    oneline   short =20

Ubuntu 10.10:
  bash: 4.1.5
  git:  1.7.1 (from apt)
  output:
$ git log --pretty=3D<tab><tab>
=2Ebash/               .irbrc
=2Ebash_history        .less
=2Ebash_logout         .local/
=2Ebash_profile        Music/
--More--

~~ Brian