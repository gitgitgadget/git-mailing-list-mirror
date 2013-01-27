From: Sven Strickroth <sven.strickroth@tu-clausthal.de>
Subject: Re: [PATCH 2/2] mergetools: Make tortoisemerge work with
Date: Sun, 27 Jan 2013 10:14:49 +0100
Message-ID: <5104F009.5020606@tu-clausthal.de>
References: <50FBD4AD.2060208@tu-clausthal.de> <7v4nibjrg0.fsf@alter.siamese.dyndns.org> <50FCFBBB.2080305@tu-clausthal.de> <7vfw1qbbr4.fsf@alter.siamese.dyndns.org> <5101B0A5.1020308@tu-clausthal.de> <51024B02.9020400@tu-clausthal.de> <CAJDDKr7eNyJp1ffBYEJaZkmnVWqd0AMpnm1kdjnrrhPtuGNL_w@mail.gmail.com> <5102837C.9000608@tu-clausthal.de> <7v622l5d87.fsf@alter.siamese.dyndns.org> <51032E96.2040209@tu-clausthal.de> <CAJDDKr6OhZOitTdDkHWnhVhdAis0U+95xUtaNn6nwkQ-k+bA+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: David Aguilar <davvid@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 27 10:15:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzOKe-00019o-UW
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 10:15:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756287Ab3A0JOy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 04:14:54 -0500
Received: from mailrelay2.rz.tu-clausthal.de ([139.174.2.43]:11552 "EHLO
	mailrelay2.rz.tu-clausthal.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756259Ab3A0JOw (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Jan 2013 04:14:52 -0500
Received: from poseidon.rz.tu-clausthal.de (poseidon.rz.tu-clausthal.de [139.174.2.21])
	by mailrelay2.rz.tu-clausthal.de (Postfix) with ESMTP id 27378289CD9;
	Sun, 27 Jan 2013 10:14:50 +0100 (CET)
Received: from poseidon.rz.tu-clausthal.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id 0A94829AAE4;
	Sun, 27 Jan 2013 10:14:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; s=dkim1;
	 bh=wSplKy1GijnsH6wRWHz1mg+v/gA=; b=mTgcX7s6JIFZWFVjvBMdq8by2FjY
	P/f1QmCN+ZZafEgSmcOQm9Xw+Lhfx3Li+MyP0aVVo+Myn37A7FcD5IAn/bQmEMnB
	9ad79iDrCru21dziSQ7jJikBR1bQjMfMtV8GJfT0DcYu5mKOerkWKhIhX5WBRbwF
	vYcDfqgA+HoKYjw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; q=dns; s=
	dkim1; b=6vQEJAqc3bgF7MtnfEJ521hhxfO7GTn/eMOZgXli4jtrPnXlTTtqQ4D
	BjxnfUhrvJ57Re+uPoHYlAUuNV/FU32I9InLbVWBckQcCoUVbGEp7uwlzgX6Bhnv
	T2kwvuCNEr8WqbR/mpgKSr/rhnDYdEhAKOaaVWuzZrVuM/sdwAz8=
Received: from tu-clausthal.de (hathor.rz.tu-clausthal.de [139.174.2.1])
	by poseidon.rz.tu-clausthal.de (Postfix) with ESMTP id CB2C029A9F1;
	Sun, 27 Jan 2013 10:14:49 +0100 (CET)
Received: from [79.193.82.210] (account sstri@tu-clausthal.de HELO [192.168.0.20])
  by tu-clausthal.de (CommuniGate Pro SMTP 5.4.8)
  with ESMTPSA id 43402544; Sun, 27 Jan 2013 10:14:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <CAJDDKr6OhZOitTdDkHWnhVhdAis0U+95xUtaNn6nwkQ-k+bA+w@mail.gmail.com>
X-Enigmail-Version: 1.5
X-Virus-Scanned: by Sophos PureMessage V5.6 at tu-clausthal.de
X-Spam-Level: (9%, '
 MULTIPLE_RCPTS 0.1, RCVD_FROM_IP_DATE 0.1, HTML_00_01 0.05, HTML_00_10 0.05, BODYTEXTP_SIZE_3000_LESS 0, BODY_SIZE_1000_LESS 0, BODY_SIZE_2000_LESS 0, BODY_SIZE_5000_LESS 0, BODY_SIZE_500_599 0, BODY_SIZE_7000_LESS 0, CT_TEXT_PLAIN_UTF8_CAPS 0, DKIM_SIGNATURE 0, DOMAINKEY_SIG 0, __ANY_URI 0, __BOUNCE_CHALLENGE_SUBJ 0, __BOUNCE_NDR_SUBJ_EXEMPT 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_FROM 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __MOZILLA_MSGID 0, __MOZILLA_USER_AGENT 0, __MULTIPLE_RCPTS_CC_X2 0, __SANE_MSGID 0, __SUBJ_ALPHA_END 0, __TO_MALFORMED_2 0, __TO_NO_NAME 0, __URI_NO_MAILTO 0, __URI_NO_PATH 0, __URI_NO_WWW 0, __USER_AGENT 0')
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214688>

Am 26.01.2013 08:10 schrieb David Aguilar:
> These patches look correct (I do not have the tool to test)
> but I think we should fixup this commit message.
> 
> How about something like...
> 
> mergetools: Teach tortoisemerge about TortoiseGitMerge
> 
> TortoiseGitMerge improved its syntax to allow for file paths
> with spaces.  Detect when it is installed and prefer it over
> TortoiseMerge.

This message implies, that I have to combine two patches again?!

-- 
Best regards,
 Sven Strickroth
 PGP key id F5A9D4C4 @ any key-server
