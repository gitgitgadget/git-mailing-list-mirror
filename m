From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [GSOC] Contributing to git.
Date: Tue, 3 Apr 2012 11:03:43 +0200
Message-ID: <201204031103.44377.jnareb@gmail.com>
References: <CAH-tXsB39OpbmVcD3Fd+tq8UcBsyCf6JBZ-rSyf1VwrQPKLiFQ@mail.gmail.com> <CAH-tXsA0wdtryrQ0d+31nLp+JRBnL0OMhpbOHUjMC=6N26GMDg@mail.gmail.com> <CAEY4ZpM3ir3Vye=QsUonpv=soO2qVsm2ZJFEyhigt8E_1sgZ_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: jaseem abid <jaseemabid@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Nazri Ramliy <ayiehere@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 03 11:04:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEzem-0000Ar-5m
	for gcvg-git-2@plane.gmane.org; Tue, 03 Apr 2012 11:04:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751659Ab2DCJDv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Apr 2012 05:03:51 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:50856 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751330Ab2DCJDu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2012 05:03:50 -0400
Received: by wibhj6 with SMTP id hj6so3433267wib.1
        for <git@vger.kernel.org>; Tue, 03 Apr 2012 02:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=ePL0wByefOiV85IHpxBKVsrr9yUou0w/0QR0L6TYVLU=;
        b=Wnw3fWl+H5zC3P0QL/wuCeJ5nzoMGs3AMWHOfQ1JaDb7pKMgnYiscljYRmJW/PBVBH
         on6vrwwsNoig2usMWmQOzoUTUOMTdqVxvmYA4Orx9WKLcdcHkCBxlBeUVOgItol1iLmv
         4mid+c4MlcU4J63SS998FTQHw5Hv13ZWxDUnIlpPl/1Cm7fUolAAs2noFlKWxIQ17VHe
         HfFtKdMW8wg5xfMTbjqRgR9JdiWHLGWP1g1eiftEURp+522skibAPYxw9tO/ToTdoeDw
         5SA0zoFLVRhRfbYMhzVQBgF+4ihIim5KPMnVd/bFrORBMh9faGnKZG1R1c7ceSh01v4Z
         RpVg==
Received: by 10.180.89.130 with SMTP id bo2mr34473526wib.17.1333443829333;
        Tue, 03 Apr 2012 02:03:49 -0700 (PDT)
Received: from [192.168.1.13] (aei168.neoplus.adsl.tpnet.pl. [83.25.112.168])
        by mx.google.com with ESMTPS id o2sm66907956wiv.11.2012.04.03.02.03.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 03 Apr 2012 02:03:47 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <CAEY4ZpM3ir3Vye=QsUonpv=soO2qVsm2ZJFEyhigt8E_1sgZ_A@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194607>

On Tue, Apr 3, 2012, Nazri Ramliy wrote:
> On Tue, Apr 3, 2012 at 12:26 AM, jaseem abid <jaseemabid@gmail.com> w=
rote:

> > It feels like too much for this project. Do we need all the feature=
s
> > from these projects? As far as I can understand, you need phantom.j=
s
> > to be installed in your local development machine, which is a new
> > dependency. =A0I have an instruction from the community not to add =
new
> > dependencies.
>=20
> Ah that is true. I forgot about the overhead of getting phantomjs ins=
talled.

Well, we would need to have some JavaScript engine installed for
running tests from commandline, be it Google Chrome's V8 (e.g. node.js)=
,
Mozilla's SpiderMonkey, or WebKit (e.g. phantomjs).

Though I think that having a page with JavaScript tests, to be opened
and checked in browser would be enough for a start.
--=20
Jakub Narebski
Poland
