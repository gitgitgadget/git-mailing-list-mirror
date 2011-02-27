From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git diff: add option for omitting the contents of deletes
Date: Sun, 27 Feb 2011 15:41:21 +0100
Message-ID: <4D6A6291.8050206@drmicha.warpmail.net>
References: <AANLkTi=++gcw5CDQnTRbhUGkvWc9Zm+Ct4Zm5oGGYKUh@mail.gmail.com> <7vk4gm7dz3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?TWFydCBTw7VtZXJtYWE=?= <mrts.pydev@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 27 15:40:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PthnF-0002ne-Jf
	for gcvg-git-2@lo.gmane.org; Sun, 27 Feb 2011 15:40:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751984Ab1B0OkL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Feb 2011 09:40:11 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:58994 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751795Ab1B0OkL (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Feb 2011 09:40:11 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 9D8F320A56;
	Sun, 27 Feb 2011 09:40:10 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Sun, 27 Feb 2011 09:40:10 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=beeP5sNDieBbtyHW3YvJYfDJQHY=; b=jkgrOrHPdP82YzLWkDwI6GSmfP3XIv+3MrHozUBqQQ/k/8HbTtPvE1F8SSHrLUX4hIncBvGNt9X8ZAbkEMObqqNq1V6hcAk6uEWdidYAsoUttcA/HKnKuN12SO5X7xiP3O0JHQOeWgelRQhPNNwvP+vMyMz4eZSr0UPSJptbvs0=
X-Sasl-enc: TFbd7jnHTxbU3TbkEBb9xcb5RyFOa1o7OI7Mm65lVdOj 1298817610
Received: from localhost.localdomain (p5485925B.dip0.t-ipconnect.de [84.133.146.91])
	by mail.messagingengine.com (Postfix) with ESMTPSA id DC824401736;
	Sun, 27 Feb 2011 09:40:09 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <7vk4gm7dz3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168034>

Junio C Hamano venit, vidit, dixit 26.02.2011 21:11:
> Mart S=C3=B5mermaa <mrts.pydev@gmail.com> writes:
>=20
>> Paging through deletes adds a cognitive burden when reviewing code.
>=20
> Wasn't the ability to say '/^diff --git ' in your pager invented for
> exactly for that?

Wasn't the pager invented for sifting through output which has to be
several pages, but not not for that which could be more concise? ;)

In fact, -D would be quite analogous to -M and -C in that respect.

Michael
