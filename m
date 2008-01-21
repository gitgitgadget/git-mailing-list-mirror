From: =?UTF-8?B?R3LDqWdvaXJlIEJhcmJpZXI=?= <devel@gbarbier.org>
Subject: Re: [PATCH] http-push: making HTTP push more robust and more user-friendly
Date: Mon, 21 Jan 2008 11:09:43 +0100
Message-ID: <47946F67.5060601@gbarbier.org>
References: <1200250979-19604-1-git-send-email-gb@gbarbier.org> <7vbq7ppbyh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 21 11:11:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGtcQ-0000FK-2h
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 11:11:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762922AbYAUKJy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Jan 2008 05:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762080AbYAUKJx
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 05:09:53 -0500
Received: from relay2-v.mail.gandi.net ([217.70.178.76]:34697 "EHLO
	relay2-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761063AbYAUKJw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 05:09:52 -0500
Received: from localhost (mfilter4-v.gandi.net [217.70.178.38])
	by relay2-v.mail.gandi.net (Postfix) with ESMTP id D3468135D7;
	Mon, 21 Jan 2008 11:09:48 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mfilter4-v.mgt.gandi.net
Received: from relay2-v.mail.gandi.net ([217.70.178.76])
	by localhost (mfilter4-v.mgt.gandi.net [217.70.178.38]) (amavisd-new, port 10024)
	with ESMTP id nSQupP3ZqiDk; Mon, 21 Jan 2008 10:38:31 +0100 (CET)
Received: from [192.168.79.1] (soy95-1-82-229-96-169.fbx.proxad.net [82.229.96.169])
	by relay2-v.mail.gandi.net (Postfix) with ESMTP id 1852C135BD;
	Mon, 21 Jan 2008 11:09:43 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <7vbq7ppbyh.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71250>

Junio C Hamano a =C3=A9crit :
> Also http-push being unusable without CURL_MULTI was also a news
> to me.  Is this something that came up on #git perhaps?
>=20
> This change means people need curl 7.10 or newer (post May 2003,
> that is).  I do not think it is too new a version to require,
> but then it makes me wonder if it makes much sense for us to
> keep supporting non CURL_MULTI build these days.  Perhaps we
> should schedule such a move to drop non MULTI build in the
> future?

In fact, it's not curl 7.10 but curl 7.16 (those guys working on curl=20
speak hexa).
See commit 9cf04301b182c4c57d62ea63554d109db613f9d3

However... http-push is anyway broken without USE_CURL_MULTI.

--=20
Gr=C3=A9goire Barbier - gb =C3=A0 gbarbier.org - +33 6 21 35 73 49
