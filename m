From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] completion: complete "git diff ...branc<TAB>"
Date: Thu, 24 Feb 2011 15:07:33 +0100
Message-ID: <4D666625.70608@drmicha.warpmail.net>
References: <7vlj1677gz.fsf@alter.siamese.dyndns.org>	<4D664E19.5080804@drmicha.warpmail.net> <20110224135821.GA14720@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>
To: =?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu Feb 24 15:10:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsbuC-000599-Ak
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 15:10:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755683Ab1BXOKv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Feb 2011 09:10:51 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:48881 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755228Ab1BXOKv (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Feb 2011 09:10:51 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 6D7FD20583;
	Thu, 24 Feb 2011 09:10:50 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Thu, 24 Feb 2011 09:10:50 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=nYNBGaXrXKDK73NI+jCEutkDN7o=; b=hEO8LRlkwl4i1LT7kNj8DJ0mS23Gfje9u9+1nTKSZ+hcvLWAo1fM236ycUssmVeswab2LnSLiD1tFt2T4pjhxGz9DXh8rpcu5eFAX3zIBLWdyj84PXKLn3WLpul1o0D5LDtTK8cclDbeusK63gvx/7g+p01KqddBkRhPP2Iw2tw=
X-Sasl-enc: r0iXhEKRVfzapfRrXrBgQxF8pUVI1nyZJMjiNz881w6H 1298556650
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 8FAAE408DFD;
	Thu, 24 Feb 2011 09:10:49 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <20110224135821.GA14720@neumann>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167808>

SZEDER G=E1bor venit, vidit, dixit 24.02.2011 14:58:
> On Thu, Feb 24, 2011 at 01:24:57PM +0100, Michael J Gruber wrote:
>> Reminds me fo the following: Typing
>>
>> git log origin/next@{1}..o<TAB>
>>
>> gives
>>
>> git log origin/next{1}..o
>>
>> WTF? Completion eats at babies!
>=20
> Interesting, I can't seem to be able to reproduce.
>=20
>   git log origin/next@{1}..o<TAB>
>=20
> gives me
>=20
>   git log origin/next@{1}..origin/
>=20
> and a TAB after that gives me all the remote branches from origin, as
> it is supposed to, leaving the @{1} intact.
>=20
> Which git, bash, and bash completion versions are you using?

git version 1.7.4.1.224.gefc87
(yesterday's next, but I've been observing this for a while now)

GNU bash, Version 4.1.7(1)-release (x86_64-redhat-linux-gnu)
(Fedora 14+updates)

git-completion from next a few days ago

(Also, I just tried with LANG=3DC, so it's not the de_DE locale nor utf=
8.)

Michael
