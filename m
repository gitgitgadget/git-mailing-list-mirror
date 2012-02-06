From: Miles Bader <miles@gnu.org>
Subject: Re: Specifying revisions in the future
Date: Mon, 06 Feb 2012 13:28:25 +0900
Message-ID: <buosjiozity.fsf@dhlpc061.dev.necel.com>
References: <jgjkk0$qrg$1@dough.gmane.org>
 <m3ehu9kknw.fsf@localhost.localdomain> <m2wr81vsdv.fsf@igel.home>
 <201202052324.59941.jnareb@gmail.com>
 <178AA8FDB02246D9AA9416C0D54E51A8@PhilipOakley> <m2obtcx4i2.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Philip Oakley <philipoakley@iee.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, jpaugh@gmx.us,
	git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Mon Feb 06 05:28:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuGBv-0001y3-Lc
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 05:28:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753685Ab2BFE2b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Feb 2012 23:28:31 -0500
Received: from relmlor4.renesas.com ([210.160.252.174]:38725 "EHLO
	relmlor4.renesas.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753565Ab2BFE2a (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Feb 2012 23:28:30 -0500
Received: from relmlir3.idc.renesas.com ([10.200.68.153])
 by relmlor4.idc.renesas.com ( SJSMS)
 with ESMTP id <0LYY00468F3HZF40@relmlor4.idc.renesas.com> for
 git@vger.kernel.org; Mon, 06 Feb 2012 13:28:29 +0900 (JST)
Received: from relmlac1.idc.renesas.com ([10.200.69.21])
 by relmlir3.idc.renesas.com ( SJSMS)
 with ESMTP id <0LYY00BJOF3GU5G0@relmlir3.idc.renesas.com> for
 git@vger.kernel.org; Mon, 06 Feb 2012 13:28:29 +0900 (JST)
Received: by relmlac1.idc.renesas.com (Postfix, from userid 0)
	id C99F78015B; Mon, 06 Feb 2012 13:28:28 +0900 (JST)
Received: from relmlac1.idc.renesas.com (localhost [127.0.0.1])
	by relmlac1.idc.renesas.com (Postfix) with ESMTP id C564580030; Mon,
 06 Feb 2012 13:28:28 +0900 (JST)
Received: from relmlii2.idc.renesas.com [10.200.68.66]	by
 relmlac1.idc.renesas.com with ESMTP id PAM11289; Mon,
 06 Feb 2012 13:28:28 +0900
X-IronPort-AV: E=Sophos;i="4.73,368,1325430000";   d="scan'208";a="66712318"
Received: from unknown (HELO relay41.aps.necel.com) ([10.29.19.9])
 by relmlii2.idc.renesas.com with ESMTP; Mon, 06 Feb 2012 13:28:28 +0900
Received: from dhlpc061 (dhlpc061.dev.necel.com [10.114.97.40])
	by relay41.aps.necel.com (8.14.4+Sun/8.14.4) with ESMTP id q164SREY006857;
 Mon, 06 Feb 2012 13:28:27 +0900 (JST)
Received: by dhlpc061 (Postfix, from userid 31295)	id 8FBB752E241; Mon,
 06 Feb 2012 13:28:26 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-reply-to: <m2obtcx4i2.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190008>

Andreas Schwab <schwab@linux-m68k.org> writes:
> The rule should be to follow the leftmost parent as far as possible.
> That means that X+2->D is B.

It might also be reasonable (and safer -- the user may not actually
realize when there's an ambiguating branch-point) to simply have it
abort with an error ("ambiguous future-ref specification") when
there's any doubt...  I suspect most uses would be very simple "+1"
etc., and not crossing branch points.

-miles

-- 
`There are more things in heaven and earth, Horatio,
 Than are dreamt of in your philosophy.'
