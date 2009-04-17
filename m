From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 2/5] attr: add GIT_ATTR_INDEX "direction"
Date: Fri, 17 Apr 2009 22:33:36 +0200
Message-ID: <49E8E7A0.5020707@lsrfire.ath.cx>
References: <1239848917-14399-1-git-send-email-gitster@pobox.com> <1239848917-14399-2-git-send-email-gitster@pobox.com> <1239848917-14399-3-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 17 22:35:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuumI-00005M-Jx
	for gcvg-git-2@gmane.org; Fri, 17 Apr 2009 22:35:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754133AbZDQUdl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Apr 2009 16:33:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753734AbZDQUdl
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Apr 2009 16:33:41 -0400
Received: from india601.server4you.de ([85.25.151.105]:41315 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752982AbZDQUdk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2009 16:33:40 -0400
Received: from [10.0.1.101] (p57B7F146.dip.t-dialin.net [87.183.241.70])
	by india601.server4you.de (Postfix) with ESMTPSA id 195BF2F8044;
	Fri, 17 Apr 2009 22:33:39 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <1239848917-14399-3-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116786>

Junio C Hamano schrieb:
> @@ -674,6 +676,10 @@ int git_checkattr(const char *path, int num, str=
uct git_attr_check *check)
>  void git_attr_set_direction(enum git_attr_direction new, struct inde=
x_state *istate)
>  {
>  	enum git_attr_direction old =3D direction;
> +
> +	if (is_bare_repository() && new !=3D GIT_ATTR_INDEX)
> +		die("BUG: non-INDEX att direction in a bare repo");

It's just a message that is probably never shown, but "[...] attr
direction [...]" (with r) would still look better.

Ren=C3=A9
