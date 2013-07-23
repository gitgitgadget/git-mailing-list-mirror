From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v3 0/6]
Date: Tue, 23 Jul 2013 09:33:02 +0000 (UTC)
Message-ID: <loom.20130723T113216-324@post.gmane.org>
References: <1374561800-938-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 23 11:33:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1YyD-0008CL-Gq
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jul 2013 11:33:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756124Ab3GWJdV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Jul 2013 05:33:21 -0400
Received: from plane.gmane.org ([80.91.229.3]:49258 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755728Ab3GWJdU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jul 2013 05:33:20 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1V1Yy7-00083F-2d
	for git@vger.kernel.org; Tue, 23 Jul 2013 11:33:19 +0200
Received: from eim39.neoplus.adsl.tpnet.pl ([83.21.128.39])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 23 Jul 2013 11:33:19 +0200
Received: from jnareb by eim39.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 23 Jul 2013 11:33:19 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 83.21.128.39 (Mozilla/5.0 (X11; Linux i686) AppleWebKit/537.22 (KHTML, like Gecko) Ubuntu Chromium/25.0.1364.160 Chrome/25.0.1364.160 Safari/537.22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231033>

Junio C Hamano <gitster <at> pobox.com> writes:

>=20
> This is mostly unchanged since the previous round, except that
>=20
>  * The option is spelled "--force-with-lease=3D<ref>:<expect>".
>    Nobody liked "cas" as it was too technical, many disliked
>    "lockref" because "lock" sounded as if push by others were
>    excluded by it while in fact this is to fail us.

Perhaps "--force-gently" ? :-)

--=20
Jakub Nar=C4=99bski
