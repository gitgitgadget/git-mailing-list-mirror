From: Mark Struberg <struberg@yahoo.de>
Subject: Re: [JGIT] Request for help
Date: Sat, 5 Sep 2009 16:40:57 +0000 (GMT)
Message-ID: <513639.15699.qm@web27805.mail.ukl.yahoo.com>
References: <200909051825.49619.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Douglas Campos <douglas@theros.info>,
	Jonas Fonseca <jonas.fonseca@gmail.com>, git@vger.kernel.org,
	Gabe McArthur <gabriel.mcarthur@gmail.com>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sat Sep 05 18:41:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjyKa-0006RR-Kc
	for gcvg-git-2@lo.gmane.org; Sat, 05 Sep 2009 18:41:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752518AbZIEQk5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2009 12:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752509AbZIEQk4
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Sep 2009 12:40:56 -0400
Received: from web27805.mail.ukl.yahoo.com ([217.146.182.10]:26591 "HELO
	web27805.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752487AbZIEQk4 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Sep 2009 12:40:56 -0400
Received: (qmail 17114 invoked by uid 60001); 5 Sep 2009 16:40:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.de; s=s1024; t=1252168857; bh=ZTx8HbkdudzXSc3tI3h9z5OOh9QvHEqJO9fA38oHkc0=; h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type; b=P0as6xX1i6aHpmUdkn/NdqHFwTxV6lFM88u7Cm0uQqItdHtjHsUpMordYqc6nybvoADTGpBr+uZMXqtp8M7PIkpxcFYcMe4j9sSWBauEJM5AkeC83uAu1N9lyAR4YWufM+7ygX2olkJo98pJYCP8tHwcNKRtZHi4egRpfc8gehk=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type;
  b=ESMfoAIQkQiToqgMO3JrClzu7GCuW29l0ICgC9g/XojuRK5UYhBPNo43vKX2Jbr1zPr3QdEsbiWlyph5PPGy2YGGu9J45D72kG7uENZLpCLoa9d4MDisg4X2+Xtr6tiKhQtwC5yzvB6p5hMwEDdPbN30GqyfdhuzD+qLiwgj0Gc=;
X-YMail-OSG: 6t4av_EVM1k2rYpCP5xaSvqyVfichnptl.nyTJcxe2o4gHUMKXEBu6IPCrOX6l7WLV3JIimk56GYHDu4EZ1lHrxEWmmg4ruh_B.M6H1.s5c85m1UAJndcwR0MRNVLr8s_jyEqHCHsZ6cdv1GDreQcKdnvh6ttrd9UIIaleUT8cCVIEM.3Bv2SIMRVAhbfpnlMym7ZwsJI5DRyLd.8ndzgYXQbuza39t6GKRFP_pY9HC8kbt4Vq4Z9hOEdRZTTaioW6wWSZz2eTZagRIiJbqYwx3g0HZmE7yiFrxzO.COzlIK0YrhFC3IbbwB
Received: from [62.47.142.68] by web27805.mail.ukl.yahoo.com via HTTP; Sat, 05 Sep 2009 16:40:57 GMT
X-Mailer: YahooMailClassic/6.1.2 YahooMailWebService/0.7.338.2
In-Reply-To: <200909051825.49619.robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127820>

Haven't counted it, but I will check it.

Please note that for running the tests previously in 'exttest' you have to activate the tck profile:

$> mvn test -Ptck

And yes, we currently only run *Test.java. Any other patterns/files to include?

txs and LieGrue,
strub

--- On Sat, 9/5/09, Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:

> From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
> Subject: Re: [JGIT] Request for help
> To: "Mark Struberg" <struberg@yahoo.de>
> Cc: "Douglas Campos" <douglas@theros.info>, "Jonas Fonseca" <jonas.fonseca@gmail.com>, git@vger.kernel.org, "Gabe McArthur" <gabriel.mcarthur@gmail.com>
> Date: Saturday, September 5, 2009, 6:25 PM
> fredag 04 september 2009 19:28:39
> skrev Mark Struberg <struberg@yahoo.de>:
> > Hi!
> > 
> > Work has been done at 
> > 
> > http://github.com/sonatype/JGit/tree/mavenize
> > 
> > Please feel free to pull/fork and share your changes!
> I'd be happy to pull it in.
> > 
> 
> Why does this new mvn test only execute 1024 tests here,
> while the old maven setup
> does 1108 ones? It seems the classes that don't match
> *Test.java are omitted.
> 
> In both cases I invoke with "mvn clean test"
> 
> -- robin
> 


      
