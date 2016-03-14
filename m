From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [ANNOUNCE] Git v2.8.0-rc2
Date: Mon, 14 Mar 2016 16:29:08 +0100
Message-ID: <56E6D8C4.2010205@drmicha.warpmail.net>
References: <xmqqr3fiaq9f.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 14 16:29:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afUQq-0006GN-LU
	for gcvg-git-2@plane.gmane.org; Mon, 14 Mar 2016 16:29:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965407AbcCNP3N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2016 11:29:13 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:44175 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965025AbcCNP3L (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Mar 2016 11:29:11 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 404B320B1E
	for <git@vger.kernel.org>; Mon, 14 Mar 2016 11:29:10 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute4.internal (MEProxy); Mon, 14 Mar 2016 11:29:10 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=1Nm5vkkCBFNQCF9RMD5gCEu4vS0=; b=ezsY77
	b1eDyVRXpzC7W0bS2XatvuPF8jO0AloDqVZpahuokIijXioCHa0CenyTruF4Y9eg
	Ya294qojv8L0vrvXpU67F9cZL4qLvPZBP0ry+ozDGLBVIGlPdVYl8bf55ZaGtm8y
	ZvyNj8efDxCmPGWhBgLBX7a/k1wqrGFM4Hsv8=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=1Nm5vkkCBFNQCF9
	RMD5gCEu4vS0=; b=ud6oNpuIE2uJH7G7SkTlzgThsaKJyl40IYu5spgMYZoeKX4
	wvrU+Pz3yMYO+Y7IveTWnDrPAF+7UEc7ouFrX1il2sYM2/iwF5viM7TGgdKeq9k0
	Ta4I+cS9q7zSlXtM2BhOIqxIypTWRRSoBrUmLzVOmOHu7ob8i5aHYIQA1laU=
X-Sasl-enc: +ZO7FkmbGga5mW61kOpLh8zAOGF+LpKIpZoOL8pakl+8 1457969349
Received: from skimbleshanks.math.uni-hannover.de (skimbleshanks.math.uni-hannover.de [130.75.46.4])
	by mail.messagingengine.com (Postfix) with ESMTPA id 993BA680092;
	Mon, 14 Mar 2016 11:29:09 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <xmqqr3fiaq9f.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288782>

Hi Junio,

Have you pulled git.pot for 2.8.0 already? [1]

Maybe I'm not up-to-date on the release cycle timing regarding l10n, but
I was trying to fix a mixed translation/non-translation issue, and it
turned out the reason is probably that it is not in "git.pot":

"behind " is in git.pot
"ahead " is not in git.pot

Now, I can recreate git.pot locally, of course, but localisations such
as de.po seem to have those translation commented out because they're
missing from git.pot.

Basically, translations don't get proper testing at this point in the
release cycle.

In fact, there seems to be another weird problem around that string.
I'll follow up with a patch in a minute.

Michael

[1] http://permalink.gmane.org/gmane.comp.version-control.git/287774
