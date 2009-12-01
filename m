From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Umlaut in filename makes troubles
Date: Tue, 01 Dec 2009 15:10:56 +0100
Message-ID: <4B1523F0.9030304@drmicha.warpmail.net>
References: <200912010815.14515.rick23@gmx.net> <hf2pbp$rss$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jochen <rick23@gmx.net>
X-From: git-owner@vger.kernel.org Tue Dec 01 15:12:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFTSl-0001zR-3S
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 15:12:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753178AbZLAOMF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Dec 2009 09:12:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752658AbZLAOMF
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 09:12:05 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:43403 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751898AbZLAOME (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Dec 2009 09:12:04 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 285B8C4CCD;
	Tue,  1 Dec 2009 09:12:10 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Tue, 01 Dec 2009 09:12:10 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=o9qw34huYjtUz10izsiZyXpteiE=; b=h6vOl+QIvN2kQwDj5iL8dgJ21OnyMWCNaKOKxL9N3FJVVu7CE4612K21mDghdxZkWTBK9e9P/Pugt12H/8GanI2xQq3s8BZwMK0Ljn5p9JdfLHoDpYjgLF1SCMjyWz/wSz16kmCqlpCWf9xvoHZYluouwncpubrFh/6F1SIksGg=
X-Sasl-enc: S9W+mI+AkU1INWUS4UrbVKsdi8c39kpO6ps+Mf1ZvPu+ 1259676729
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 7053549F264;
	Tue,  1 Dec 2009 09:12:09 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.6pre) Gecko/20091127 Lightning/1.0b1pre Shredder/3.0.1pre
In-Reply-To: <hf2pbp$rss$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134212>

Jochen venit, vidit, dixit 01.12.2009 10:58:
> I found another strange effect...
>=20
> I made a file with "touch a=C3=B6=C3=A4=C3=BC.txt" and from "git stat=
us" I get=20
> #       "a\303\266\303\244\303\274.txt"
> reported as untracked. But when I start "git gui" I get file displaye=
d with=20
> it's correct name...
>=20

Does this change after

git config core.quotepath false

Michael
