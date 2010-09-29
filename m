From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 14/18] git notes merge: Manual conflict resolution, part 2/2
Date: Thu, 30 Sep 2010 01:37:10 +0200
Message-ID: <201009300137.10291.johan@herland.net>
References: <1285719811-10871-1-git-send-email-johan@herland.net>
 <1285719811-10871-15-git-send-email-johan@herland.net>
 <AANLkTimzii1TEqRY40idz_i8qXHGFnoCZa29eH31U6n7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jrnieder@gmail.com, bebarino@gmail.com,
	gitster@pobox.com
To: =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 30 01:37:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P16Dk-0003re-Ve
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 01:37:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751412Ab0I2XhO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Sep 2010 19:37:14 -0400
Received: from smtp.getmail.no ([84.208.15.66]:57259 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750927Ab0I2XhN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Sep 2010 19:37:13 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L9J00JAX89Z8A50@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Thu, 30 Sep 2010 01:37:11 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 2CB7C1EA54B4_CA3CDA7B	for <git@vger.kernel.org>; Wed,
 29 Sep 2010 23:37:11 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 0D6F11EA27A1_CA3CDA7F	for <git@vger.kernel.org>; Wed,
 29 Sep 2010 23:37:11 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L9J007IZ89Y1E10@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 30 Sep 2010 01:37:10 +0200 (MEST)
User-Agent: KMail/1.13.5 (Linux/2.6.35-ARCH; KDE/4.5.1; x86_64; ; )
In-reply-to: <AANLkTimzii1TEqRY40idz_i8qXHGFnoCZa29eH31U6n7@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157621>

On Wednesday 29 September 2010, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =
wrote:
> On Wed, Sep 29, 2010 at 00:23, Johan Herland <johan@herland.net> wrot=
e:
> > +--commit::
> > +       Finalize an in-progress 'git notes merge', i.e. a notes mer=
ge
> > with +       conflicts. When 'git notes merge' encounters conflicts=
,
> > it s +       which returned one or more conflicts (that you have no=
w
> > resolved)
>=20
> This "it s ..." sentence doesn't make sense.

Indeed. Will be fixed in the next iteration. Here's the updated text:

--commit::
	Finalize an in-progress 'git notes merge'. Use this option
	when you have resolved the conflicts that 'git notes merge'
	stored in .git/NOTES_MERGE_WORKTREE. This amends the partial
	merge commit created by 'git notes merge' (stored in
	.git/NOTES_MERGE_PARTIAL) by adding the notes in
	.git/NOTES_MERGE_WORKTREE. The notes ref stored in the
	.git/NOTES_MERGE_REF symref is updated to the resulting commit.


=2E..Johan

--=20
Johan Herland, <johan@herland.net>
www.herland.net
