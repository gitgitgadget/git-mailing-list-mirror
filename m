From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [PATCH 1/2] Command names should not be translated.
Date: Mon, 13 Sep 2010 07:07:58 +0200 (CEST)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1009130706450.29710@perkele.intern.softwolves.pp.se>
References: <20100912202105.DA51D2FC00@perkele>
 <AANLkTinN_fDAVVuT1ygCe7gMpHqAhL4GGjrZ98igbbP3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 13 07:08:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ov1H0-0000y5-Th
	for gcvg-git-2@lo.gmane.org; Mon, 13 Sep 2010 07:08:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240Ab0IMFID convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Sep 2010 01:08:03 -0400
Received: from smtp.getmail.no ([84.208.15.66]:64009 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750874Ab0IMFIC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Sep 2010 01:08:02 -0400
Received: from get-mta-scan01.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L8O007DB69BVY40@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Mon, 13 Sep 2010 07:07:59 +0200 (MEST)
Received: from get-mta-scan01.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 462C5179926B_C8DB1AFB	for <git@vger.kernel.org>; Mon,
 13 Sep 2010 05:07:59 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan01.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 2AED717968A3_C8DB1AFF	for <git@vger.kernel.org>; Mon,
 13 Sep 2010 05:07:59 +0000 (GMT)
Received: from perkele ([84.215.142.63]) by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L8O00EEC69BY600@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Mon, 13 Sep 2010 07:07:59 +0200 (MEST)
Received: by perkele (Postfix, from userid 501)	id EBB372FC00; Mon,
 13 Sep 2010 07:07:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])	by perkele (Postfix)
 with ESMTP id E85812FBEE; Mon, 13 Sep 2010 07:07:58 +0200 (CEST)
In-reply-to: <AANLkTinN_fDAVVuT1ygCe7gMpHqAhL4GGjrZ98igbbP3@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156069>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:

> I disagree with all those. These don't end up being used in a context=
 like:
>
>    die("git-%s: error ...", command);
>
> But:
>
>    die(_("Refusing to %s notes in %s (outside of refs/notes/)"),
>        _(subcommand), t->ref);

You are right. I saw the first as a duplicate source of the wt-status.c=
=20
command name that I got for translation. Drop these, then.

Still the construct is a bit awkward, but possibly doable, at least for=
 my=20
language.

> These however are good, because here it gets used as:
>
>    color_fprintf_ln(s->fp, c, _("#   (use \"git %s <file>...\" to
> include in what will be committed)"), how);
>
> I.e. this is purely a hardcoded command name.

Indeed.

--=20
\\// Peter - http://www.softwolves.pp.se/
