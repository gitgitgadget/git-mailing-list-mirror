From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] sh-18n: quell "unused variable" warning
Date: Thu, 26 May 2011 15:03:14 +0200
Message-ID: <4DDE4F92.7030301@drmicha.warpmail.net>
References: <62c2e1619edcb37c0411f29a34b6bc10e3899a97.1306317312.git.git@drmicha.warpmail.net> <BANLkTi=Mgd7=eriOsz1phDBJ25Com2Y=mQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 26 15:03:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPaDj-000344-1l
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 15:03:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757547Ab1EZNDR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 May 2011 09:03:17 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:38524 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754802Ab1EZNDR (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 May 2011 09:03:17 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.messagingengine.com (Postfix) with ESMTP id E55D320B5D;
	Thu, 26 May 2011 09:03:15 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute6.internal (MEProxy); Thu, 26 May 2011 09:03:15 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=H4QsounAajLv1dbYPV8DNV5p+RQ=; b=BSOEZox/nNHvZlV6EEnUR1vcjbN+74PjAYnQriQ2aVlIPhcEePH0Z+MrnoDiDaugGb5pUNOg20iwGZdhlGNWPLF38XtIEGPsBflM7HS35OLGlhJO+JwTv1p0PMN8ypP5G2LGqouU+y7H8nAIY1aGlRuT2mSNlvMz1QWdKwa88+E=
X-Sasl-enc: fKfgEZPVRPnKOsSESnaCmI7sIFGk2TEdlqc1R2q1+Xz6 1306414995
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 52A8C402DAC;
	Thu, 26 May 2011 09:03:15 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc15 Lightning/1.0b3pre Thunderbird/3.1.10
In-Reply-To: <BANLkTi=Mgd7=eriOsz1phDBJ25Com2Y=mQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174505>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason venit, vidit, dixit 26.05.2011 0=
1:33:
> On Wed, May 25, 2011 at 11:55, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>=20
> I suppose it was inevitable that we'd end up maintaining this since
> upstream only maintains the GPLv3 version now.
>=20
>>   /* Default values for command line options.  */
>> -  unsigned short int show_variables =3D 0;
>> +  /* unsigned short int show_variables =3D 0; */
>=20
>> -         show_variables =3D 1;
>> +         /* show_variables =3D 1; */
>=20
> Can we just remove these lines instead of commenting them out?

Sure, I just didn't know what is more convenient for the maintainer. I
noticed a few comments in there already but have not compared with
upstream. Resend necessary?

Michael
