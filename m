From: Michael Witten <mfwitten@gmail.com>
Subject: Re: In favor of "git commit --no-parent"
Date: Thu, 29 Sep 2011 18:52:03 +0000
Message-ID: <CAMOZ1Bu7UGOu=XPUbjWo30hzGfgHSk4dsZRUsDT4cUmwu79GbA@mail.gmail.com>
References: <1316960136073-6829212.post@n2.nabble.com> <1316961212.4388.5.camel@centaur.lab.cmartin.tk>
 <7vaa9r2jii.fsf@alter.siamese.dyndns.org> <1317073309.5579.9.camel@centaur.lab.cmartin.tk>
 <vpq39fi9gf5.fsf@bauges.imag.fr> <69d6fb3199bc4f74b25dae7992a9f132-mfwitten@gmail.com>
 <vpqsjni6kkk.fsf@bauges.imag.fr> <553B5FA1A43748B1ADD759572EADA6FF@PhilipOakley>
 <e4f46b39e9ed4203bfab8a81e25eb600-mfwitten@gmail.com> <7vaa9oz9rl.fsf@alter.siamese.dyndns.org>
 <271cc2ed03774b4988bb61cb3e79750e-mfwitten@gmail.com> <7vmxdnte0j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@elego.de>,
	vra5107 <venkatram.akkineni@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Raible <raible@nextest.com>,
	Philip Oakley <philipoakley@iee.org>,
	Jeff King <peff@peff.net>, Jay Soffian <jaysoffian@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 29 20:52:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9Lip-0002Km-9a
	for gcvg-git-2@lo.gmane.org; Thu, 29 Sep 2011 20:52:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753998Ab1I2Swe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Sep 2011 14:52:34 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:35460 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752292Ab1I2Swd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2011 14:52:33 -0400
Received: by yib18 with SMTP id 18so822641yib.19
        for <git@vger.kernel.org>; Thu, 29 Sep 2011 11:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=oy39Hem4HXoS/UhjYLwPjBjGqvdKz1zJvEbIspOmgSU=;
        b=fBsjO6UbBTlXA8M578IaRPwbrnsA3X71skMSpuJJQSIkpTBNV+z8vzEc0B3pd16FVc
         MziWZsQM+pfZDaGZAvCk32F3GbRmIr+SNXXm/AM2GJTfK2ufrE7MGCFb3ftkREUeVvzN
         OAYUp07CP1HUxLSHA+17++azj8FWe70mSCD3o=
Received: by 10.42.117.133 with SMTP id t5mr1286729icq.222.1317322353113; Thu,
 29 Sep 2011 11:52:33 -0700 (PDT)
Received: by 10.42.171.194 with HTTP; Thu, 29 Sep 2011 11:52:03 -0700 (PDT)
In-Reply-To: <7vmxdnte0j.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182422>

On Thu, Sep 29, 2011 at 18:11, Junio C Hamano <gitster@pobox.com> wrote:
> That leaves "Hidden History" the only useful use case. IOW, the answer to
> the first question above is not "Separate or Hidden History", but is
> "Hidden History and nothing else".
>
> And a half of the the answer to the second question is "checkout --orphan"
> (and the other half would be "filter-branch").

Uh... no.

If you think that "Hidden History" is all that matters, then you think that

  git commit --no-parent

is all that matters.

That's what my email was showing.

> "checkout --orphan" does
> have major safety advantage than introducing "commit --no-parent", as Peff
> pointed out earlier (to which I agreed).

Did I not provide in my previous email a decent safety mechanism?
