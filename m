From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: change URL
Date: Fri, 27 Nov 2009 16:09:18 +0100
Message-ID: <4B0FEB9E.3050009@drmicha.warpmail.net>
References: <4B0FA253.6060804@gulfsat.mg> <20091127122228.660131af@perceptron>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Rakotomandimby Mihamina <mihamina@gulfsat.mg>, git@vger.kernel.org
To: =?ISO-8859-1?Q?Jan_Kr=FCger?= <jk@jk.gs>
X-From: git-owner@vger.kernel.org Fri Nov 27 16:10:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NE2Sx-0003qV-5J
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 16:10:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754172AbZK0PKX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Nov 2009 10:10:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753487AbZK0PKX
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Nov 2009 10:10:23 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:40216 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753368AbZK0PKW (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Nov 2009 10:10:22 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 3C55BBF606;
	Fri, 27 Nov 2009 10:10:29 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Fri, 27 Nov 2009 10:10:29 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=XmbNaSr/H+mhq8pfjhB6GJs6hWY=; b=r3SBmOqkbQgLg1htKddBbXZzigpw3NaG9jF/zgNGF/Rwpu4G0QkoKxHnxkToqjYfcurC5YRW7RAkXnoaMyrSiebmL3R7IyFDgKvGfCfVmGBKGcLKzuAGILMU73MRoi1Xyw1F8Zuc7rWOv/MD/xYOFYR1qmm70Yb2HDWttwIvCoU=
X-Sasl-enc: +feNjUQKPcTRw0q+UN1a07myyvfdFI11etLg+1wkpkYT 1259334628
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 50A4D490D44;
	Fri, 27 Nov 2009 10:10:28 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.6pre) Gecko/20091127 Lightning/1.0b1pre Shredder/3.0.1pre
In-Reply-To: <20091127122228.660131af@perceptron>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133899>

Jan Kr=FCger venit, vidit, dixit 27.11.2009 12:22:
> Hi,
>=20
> Rakotomandimby Mihamina <mihamina@gulfsat.mg> wrote:
>=20
>> When I first cloned a project, I used the non fully qualified hostna=
me
>> if the repo:
>>    $ git clone ssh://git/git/Mailaka
>> [...]=20
>> What should I edit to make "git push" uses "git.rktmb.org" rather
>> than "git.domainsearch-in-resolv.conf"?
>=20
> it's in .git/config, and it's rather easy to find there.
>=20
> Jan

:)

git config remote.origin.url ssh://git.rktmb.org/git/Mailaka

Cheers,
Michael
