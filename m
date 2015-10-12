From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH v2] filter-branch: remove multi-line headers in msg filter
Date: Mon, 12 Oct 2015 09:26:41 +0200
Message-ID: <561B60B1.10003@drmicha.warpmail.net>
References: <20151009002113.GA329@freya.jamessan.com>
 <561767AC.6060503@drmicha.warpmail.net>
 <xmqqpp0oormv.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: James McCoy <vega.james@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 12 09:26:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZlXVT-0007z8-NG
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 09:26:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751850AbbJLH0s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Oct 2015 03:26:48 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:47527 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751778AbbJLH0p (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Oct 2015 03:26:45 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id DD44E20A6A
	for <git@vger.kernel.org>; Mon, 12 Oct 2015 03:26:42 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute4.internal (MEProxy); Mon, 12 Oct 2015 03:26:42 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=9+2toaIJb/FyEODlAKZiMzIhFyE=; b=bWOlqq
	Wd3WW4CWXoTqqKnRqCtw3W1SI8ig+qJNCn1fovZYTIwqqKkiLmGEVpEUwk68Fmo9
	VAawEB9j20XnStLO4iypw4y6J7DmQYwv29aEmKy90It5TrXFwFMwJJpxRRG1sj39
	LyDAetUAbGsZAX4bysO0PPGxJL48cPvLkTii8=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=9+2toaIJb/FyEOD
	lAKZiMzIhFyE=; b=PPZbR53H9tUHclqgmeX9RwoCaCgY5daPMbiRf8ysk2wfKaI
	02gWPM5sHLLZbKB0JIAvbAtnvgUegLFkB+LLWwG7Ng6iQUex6A1XKKO09FUO60CM
	Cb46ZyXSqVT6I7vQm4qZGob2C/FK1uZ7TwOFSgxe7dVIN7Ci3LHwLldpPubE=
X-Sasl-enc: 7+ZCBkDEmHiK99EySLZb3zavdWj+Bl6s34Q3++KqqU8K 1444634802
Received: from dickson.math.uni-hannover.de (dickson.math.uni-hannover.de [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 24137680154;
	Mon, 12 Oct 2015 03:26:42 -0400 (EDT)
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <xmqqpp0oormv.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279363>

Junio C Hamano venit, vidit, dixit 09.10.2015 19:53:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
>=20
>>> Set IFS to an empty string for the =E2=80=9Cread=E2=80=9D call, thu=
s disabling the word
>>> splitting, which causes $header_line to be set to the non-empty val=
ue '
>>> '.  This allows the loop to fully consume the header lines before
>>> emitting the original, intact commit message.
>>>
>>> Signed-off-by: James McCoy <vega.james@gmail.com>
>>> ---
>>
>> Thanks for hanging in :)
>>
>> Reviewed-by: Michael J Gruber <git@drmicha.warpmail.net>
>=20
> As long as you are fine with giving authorship to James, I am fine
> with that.  I'll amend what is queued with your reviewed-by above
> and will merge to 'next'.

Yep, I'm fine with "mini-mentoring", and just to be safe, the 7 new
characters in git-filter-branch.sh are (also)

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>

in case that is needed or preferred.

Michael
