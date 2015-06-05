From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] receive-pack: Create a HEAD ref for ref namespace
Date: Fri, 05 Jun 2015 14:55:35 +0200
Message-ID: <55719C47.6030600@drmicha.warpmail.net>
References: <1433193883-11577-1-git-send-email-johannes@kyriasis.com> <ef4dae3e-3ae8-4727-9448-80f801e1dbdf@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?UTF-8?B?Sm9oYW5uZXMgTMO2dGhiZXJn?= <johannes@kyriasis.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 05 14:56:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0rA8-0000WO-Ve
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jun 2015 14:55:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754700AbbFEMzm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Jun 2015 08:55:42 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:58645 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753110AbbFEMzh (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Jun 2015 08:55:37 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id E8AF5219AF
	for <git@vger.kernel.org>; Fri,  5 Jun 2015 08:55:36 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute4.internal (MEProxy); Fri, 05 Jun 2015 08:55:36 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=9Eo/LaHqP19grx+Ww0AJjSd/07Y=; b=VizBuD
	YgC0rNzLRGX+lFcfl+1RTPFRCzq6Ni3JMy38PeUJje2RYNr1T/MmeOgSci89K/RP
	SyB9d8Ik2XjuKXaL2hvsqeKDVV4rZVy2M19bKNGH6BHzAL3TS/8qCMDIvkAWH+I1
	qAhoERj7f7iGrjlWL/RU7O5fo1XuaYD1l5u88=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=9Eo/LaHqP19grx+
	Ww0AJjSd/07Y=; b=MSHNYrdv4j6gCWaojHXdF4fi1BYpOX5Mtvlrfd7WIhZN/i6
	IfSlk1n9QPaBURhCj4ExRvB9OadGkVW8gW4T5CflqNh+l0zmvgfoVVPmkrbXrFCi
	voAxn8fBLUlDd/MnAAFebWBYUbH8l8exA4QX6OUsAw1r/dQQjsi/kJPdrLaI=
X-Sasl-enc: H0oyNUJKClnIMKjln2zKB+2VhCs+rwmVYMBwHh9d+PCo 1433508936
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 7035C68009B;
	Fri,  5 Jun 2015 08:55:36 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <ef4dae3e-3ae8-4727-9448-80f801e1dbdf@email.android.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270831>

Johannes L=C3=B6thberg venit, vidit, dixit 05.06.2015 13:53:
> Ping.
>=20
> --
> Sincerely,=20
> Johannes L=C3=B6thberg=20
> (Sent from my phone.)
>=20

It appears your patch proposes to fix a problem. It's a good idea to
expose the problem by writing a test so that one can check that the fix
actually fixes the problem.

(Also, your patch duplicates the line "struct strbuf namespaced_head_bu=
f
=3D STRBUF_INIT;")

Michael
