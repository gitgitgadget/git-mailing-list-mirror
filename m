From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC PATCH] Makefile: Turn off the configure target by default
Date: Mon, 11 Oct 2010 14:10:32 +0200
Message-ID: <4CB2FEB8.3050705@drmicha.warpmail.net>
References: <36e21bdafd75e95f1e13437f81067c71c7390408.1286783121.git.git@drmicha.warpmail.net>	<AANLkTikGSj-x4hk7NFysWETuR80=REZ81Qy8Zu3Pks-L@mail.gmail.com>	<201010111039.59779.jnareb@gmail.com> <AANLkTikb2vDMXLa48QsDfK6grczmqC1uk1jYi0ZFq9QC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 11 14:10:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5HCz-0007qC-TB
	for gcvg-git-2@lo.gmane.org; Mon, 11 Oct 2010 14:10:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754135Ab0JKMKT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Oct 2010 08:10:19 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:40396 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754091Ab0JKMKS (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Oct 2010 08:10:18 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 80618271;
	Mon, 11 Oct 2010 08:10:17 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Mon, 11 Oct 2010 08:10:17 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=72iu3hLdeScbK0wskICaTTyE0Kc=; b=LI425ZzVTxSj44gZxSMAsGqRkKgnb30JRMyvh0c599MP/fHYyycznXjWSj41TDmQZVWdYbasaIrRJ0pKnebPNCq/Kcc0HOjTbIeAaoVtM2URTnu2J1nftIPWxq4dOhS1Gv7l9o/k4qbFfjkAfyntECLiA9SEj9H8pcDKBXfkb8c=
X-Sasl-enc: 3SdffBog42QAIpLMNlDaZuZYk2OEyyjAC2Q5HecsTpsX 1286799017
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id BA1BC400199;
	Mon, 11 Oct 2010 08:10:16 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.9) Gecko/20100921 Fedora/3.1.4-1.fc13 Lightning/1.0b3pre Thunderbird/3.1.4
In-Reply-To: <AANLkTikb2vDMXLa48QsDfK6grczmqC1uk1jYi0ZFq9QC@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158757>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason venit, vidit, dixit 11.10.2010 1=
1:40:
> On Mon, Oct 11, 2010 at 08:39, Jakub Narebski <jnareb@gmail.com> wrot=
e:
>=20
>> But thanks to having ./configure optional step, we can build git als=
o
>> on platforms that doesn't have autoconf installed (though the same c=
ould
>> be achieved by bundling ./configure script with release tarballs).
>=20
> It already is built as part of the tarballs, at least for
> http://kernel.org/pub/software/scm/git/git-1.7.3.1.tar.bz2

Well, the point of my semi-serious RFC is that every so often, we have =
a
variation on the following theme on the list:

- "Newbee" uses make configure && ./configure && make and can't build.
- Helpful "oldbees" respond like "Duh! Use the Makefile".

configure is a second class citizen in git.git (we even explicitly
=2Egitignore it - if you allow that lame joke), and given my complete l=
ack
of auto-conf-foo, I can't change that. But there's no need to make
someone feel stupid (I'm exaggerating a bit) for trying a standard buil=
d
tool that we do ship.

But, really, the typical responses to build problems with configure
indicate that most long timers don't use configure either, and probably
don't feel too comfortable with it. So, I think we should either make
the status quo clearer (Makefile as primary method) or change the statu=
s
quo. I can only do the former ;)

Michael
