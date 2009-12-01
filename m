From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Umlaut in filename makes troubles
Date: Tue, 01 Dec 2009 08:54:17 +0100
Message-ID: <4B14CBA9.6080104@drmicha.warpmail.net>
References: <200912010815.14515.rick23@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: rick23@gmx.net
X-From: git-owner@vger.kernel.org Tue Dec 01 08:55:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFNaI-00068B-LU
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 08:55:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753806AbZLAHzY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Dec 2009 02:55:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753782AbZLAHzY
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 02:55:24 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:42137 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753585AbZLAHzX (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Dec 2009 02:55:23 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id D9D96C5CA4;
	Tue,  1 Dec 2009 02:55:29 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Tue, 01 Dec 2009 02:55:29 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=SnAJRfGo8pSy0oLdMuJ6+d9rTxg=; b=fPdhb942pjZhz6R6BT/RMmtK1JEozBXuuebhkSt8dU1trYrri/Fw4VdcgjyPdDRUcNp2IsBlURv1f6JknY0LX76l7hg+n7TsS/+kwD6dINwy8e0YSOJKjnyw1vZuTzMBHBG7kLAMf3ZELybdWVMe7d5iuN35KF9IPZL3mt945Bo=
X-Sasl-enc: OS5m0drzasYc0Fuhxuae4KRTkDDI77qEiJd6fVzvgGJm 1259654129
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 5862A214E;
	Tue,  1 Dec 2009 02:55:29 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.6pre) Gecko/20091127 Lightning/1.0b1pre Shredder/3.0.1pre
In-Reply-To: <200912010815.14515.rick23@gmx.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134175>

rick23@gmx.net venit, vidit, dixit 01.12.2009 08:15:
> I have problems with my repository under slackware vs. windows. I=20
> created a repo in linux and every time I use it under msysgit, the=20
> files containing umlauts in the filename are marked as deleted (and=20
> vice versa).
>=20
> For instance: the repo perfectly synced under msysgit leads to:
>=20
> user@sauron:/media/disk-2$ git status |grep Auszug
> #       deleted:    "trunk/007_Literatur/Auszug aus Ergonomische=20
> Untersuchung des Lenkgef\374hles.docx"
> #       "trunk/007_Literatur/Auszug aus Ergonomische Untersuchung des=
=20
> Lenkgef\303\274hles.docx"
>=20
> in linux. But the file exists and is displayed correctly in the shell=
=20
> or in dolphin (my filemanager under X):
>=20
> user@sauron:/media/disk-2$ ls trunk/007_Literatur/Auszug*
> trunk/007_Literatur/Auszug aus Ergonomische Untersuchung des=20
> Lenkgef=C3=BChles.docx
>=20
> Can you please give me a hint what to do?

I would say you can give us more info about your setup. If I understand
you correctly, you use the same repo and checkout under linux and
msysgit. What kind of filesystem is this on, what are the mount options=
?
What is your locale ($LANG) in slackware?

Michael
