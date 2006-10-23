From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] git-send-email: do not pass custom Date: header
Date: Mon, 23 Oct 2006 10:41:10 +0200
Organization: At home
Message-ID: <ehhv6g$4js$1@sea.gmane.org>
References: <11615895973387-git-send-email-normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Mon Oct 23 10:41:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbvMs-0001of-BA
	for gcvg-git@gmane.org; Mon, 23 Oct 2006 10:41:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751828AbWJWIlF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 23 Oct 2006 04:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751827AbWJWIlF
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 04:41:05 -0400
Received: from main.gmane.org ([80.91.229.2]:11686 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751828AbWJWIlC (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Oct 2006 04:41:02 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GbvMj-0001nm-Ch
	for git@vger.kernel.org; Mon, 23 Oct 2006 10:41:01 +0200
Received: from host-81-190-23-110.torun.mm.pl ([81.190.23.110])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 23 Oct 2006 10:41:01 +0200
Received: from jnareb by host-81-190-23-110.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 23 Oct 2006 10:41:01 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-23-110.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29822>

Eric Wong wrote:

> We already generate a Date: header based on when the patch was
> emailed. =A0git-format-patch includes the Date: header of the
> patch. =A0Having two Date: headers is just confusing, so we
> just use the current Date:
>=20
> Often the mailed patches in a patch series are created over a
> series of several hours or days, so the Date: header from the
> original commit is incorrect for email, and often far off enough
> for spam filters to complain.

But that makes us lose original commit date. And git format-patch
is if I remember correctly together with git-am used in git-rebase.
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
