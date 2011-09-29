From: Phil Hord <phil.hord@gmail.com>
Subject: Re: In favor of "git commit --no-parent"
Date: Thu, 29 Sep 2011 17:50:10 -0400
Message-ID: <CABURp0qEyQB37Zx75Xa6EEocnJeWiAGdkFqO7iZw_B_hg69hRg@mail.gmail.com>
References: <1316960136073-6829212.post@n2.nabble.com> <1316961212.4388.5.camel@centaur.lab.cmartin.tk>
 <7vaa9r2jii.fsf@alter.siamese.dyndns.org> <1317073309.5579.9.camel@centaur.lab.cmartin.tk>
 <vpq39fi9gf5.fsf@bauges.imag.fr> <69d6fb3199bc4f74b25dae7992a9f132-mfwitten@gmail.com>
 <vpqsjni6kkk.fsf@bauges.imag.fr> <553B5FA1A43748B1ADD759572EADA6FF@PhilipOakley>
 <e4f46b39e9ed4203bfab8a81e25eb600-mfwitten@gmail.com> <7vaa9oz9rl.fsf@alter.siamese.dyndns.org>
 <271cc2ed03774b4988bb61cb3e79750e-mfwitten@gmail.com> <7vmxdnte0j.fsf@alter.siamese.dyndns.org>
 <CABURp0q4wi5ruLmeaZtN=8QvuX2ftSFQo1uJL0_8-wtm1nYaGA@mail.gmail.com> <CAMOZ1Bs9kei58AVJZRJM4g+Nh3QaY8dtUBctmLL8SVL3XW=aLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-1?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>,
	vra5107 <venkatram.akkineni@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Raible <raible@nextest.com>,
	Philip Oakley <philipoakley@iee.org>,
	Jeff King <peff@peff.net>, Jay Soffian <jaysoffian@gmail.com>,
	git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 29 23:50:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9OV2-00050i-OE
	for gcvg-git-2@lo.gmane.org; Thu, 29 Sep 2011 23:50:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755287Ab1I2Vuc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Sep 2011 17:50:32 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:36479 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754287Ab1I2Vub convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Sep 2011 17:50:31 -0400
Received: by ywb5 with SMTP id 5so956327ywb.19
        for <git@vger.kernel.org>; Thu, 29 Sep 2011 14:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=TsOimiDwokqSNxq50A+M1/cQGUGINYB7n+5nCiTvZmw=;
        b=CC91iCqUcxx588SD15JHJyMYl4HeO0iO0mXjfFWQSu8gbIcuyyKHlySbEdSCUAkTXR
         ERaeLeMg3ul64d1st4KEqYOdxxvlZaAuOydwN5UHQVnyDaJSIPx/1cQgV/X+Qki0Zg7f
         KYcMAnoj/k0MJwtx0uxOzH5cPtv/+vNN5LYHI=
Received: by 10.68.39.170 with SMTP id q10mr42612116pbk.96.1317333030045; Thu,
 29 Sep 2011 14:50:30 -0700 (PDT)
Received: by 10.68.52.105 with HTTP; Thu, 29 Sep 2011 14:50:10 -0700 (PDT)
In-Reply-To: <CAMOZ1Bs9kei58AVJZRJM4g+Nh3QaY8dtUBctmLL8SVL3XW=aLw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182443>

On Thu, Sep 29, 2011 at 5:28 PM, Michael Witten <mfwitten@gmail.com> wr=
ote:
> On Thu, Sep 29, 2011 at 21:02, Phil Hord <phil.hord@gmail.com> wrote:
>> I think a user looking for this functionality -- either a new git us=
er
>> or a user who seldom uses the "create secondary root commit" command
>> -- would first try 'git help init'. =A0It seems logical to me that I
>> should be able to do this:
>>
>> =A0cd my-git-repo
>> =A0git init --root=3D<newbranch> .
>>
>> This feels natural to me for this operation.
>
> That would be a good place for the "git checkout --no-parent" variant=
,
> especially given that I think "git checkout --no-parent" should produ=
ce
> an empty working tree and index, which we can all note is essentially
> what "git init" gives us.
>
> Your suggestion seems like a corroboration of my stance.

I'm not arguing the functionality; just the command spelling.
Consider your stance corroborated.

I don't like "git checkout" for this because
1. git-checkout is too popular already; oddball functions like this
should live in the shadows.
2. git-checkout is conceptually wrong, imho.  git-checkout means
"fetch me this commit" or "fetch me files from this commit".
Technically it does the same thing that we're talking about here (it
frobs the index, the workdir and HEAD), but conceptually it is very
different.

Conceptually, I think the functionality you're talking about is more
akin to git-init.

Phil
