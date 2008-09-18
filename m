From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH] Convert "sink" to the new infrastructure
Date: Thu, 18 Sep 2008 12:24:41 +0100
Message-ID: <b0943d9e0809180424s61eff16cl8e9911a04e1cca42@mail.gmail.com>
References: <20080914085118.GC30664@diana.vm.bytemark.co.uk>
	 <20080915075740.GB14452@diana.vm.bytemark.co.uk>
	 <b0943d9e0809150944o71acafe7ndeda500b1fba97df@mail.gmail.com>
	 <20080916074024.GA2454@diana.vm.bytemark.co.uk>
	 <b0943d9e0809160759w5c9be510t3b33d5d983bff5a7@mail.gmail.com>
	 <20080916193647.GA12513@diana.vm.bytemark.co.uk>
	 <b0943d9e0809170455m53eaf677t87e9ade3f001d044@mail.gmail.com>
	 <20080917130432.GA26365@diana.vm.bytemark.co.uk>
	 <b0943d9e0809170901o15027408w439af4436cfea67c@mail.gmail.com>
	 <20080918071020.GA12550@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu Sep 18 13:26:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgHeP-0006ab-Bw
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 13:26:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753107AbYIRLYn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Sep 2008 07:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754820AbYIRLYn
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 07:24:43 -0400
Received: from rv-out-0506.google.com ([209.85.198.228]:45106 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754313AbYIRLYm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Sep 2008 07:24:42 -0400
Received: by rv-out-0506.google.com with SMTP id k40so3670923rvb.1
        for <git@vger.kernel.org>; Thu, 18 Sep 2008 04:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=s4t+RjQJnxftrV33bRNLSSDYD72Oeo/iCJu9cxdjpWU=;
        b=E/tjK2BeNIZ4ZEpTvy+Pabo/xAZY5sk1SgMljv9QtuQ8BwkcrjW/NkLslELNGmRqxc
         QCc7wGlwtpIddQ/Vpnhrs0+UZacJutnEZLkpS0VPOi4YedrXH5urCLsNbo2ys4Eyk1K/
         pRJ/FKmPnfKq0AfJz6KYEgYlnmRMvX0rYIj3Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=N6fgtyY0Eu63fAzZyrUn/tOLyqYgv6TRnNdg3CUgXYySYTkEKZrOLRa1ZubpcGItkB
         nXwd9mrpx/3ZseggP5RsgyK8U1PthaALsORSxSmV9NzgWRS1teKlm7aDPYSg3OtOSF5y
         BCzSizvyx19+oLcUO40JrOPcPI+JbasdLOwE4=
Received: by 10.140.164.1 with SMTP id m1mr7350830rve.69.1221737081924;
        Thu, 18 Sep 2008 04:24:41 -0700 (PDT)
Received: by 10.140.199.1 with HTTP; Thu, 18 Sep 2008 04:24:41 -0700 (PDT)
In-Reply-To: <20080918071020.GA12550@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96192>

2008/9/18 Karl Hasselstr=F6m <kha@treskal.com>:
> On 2008-09-17 17:01:22 +0100, Catalin Marinas wrote:
>
>> 2008/9/17 Karl Hasselstr=F6m <kha@treskal.com>:
>>
>> > Have you tried the benchmarks I committed a while back?
>>
>> No, I wanted to see how some real patches behave and I'm pretty
>> pleased with the result.
>
> In addition to the synthetic patch series you seem to have in mind,
> there is also a more than 1000 patches long series from the kernel
> history. Try running the setup.sh and take a look (it takes a few
> minutes to run, but you'll only have to do it once because the
> performance test script is careful not to wreck the repo it works on)=
=2E

OK, I thought we only had the synthetic patches and haven't bothered
looking at the scripts.

--=20
Catalin
