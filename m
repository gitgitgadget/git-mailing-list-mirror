From: "Mestnik, Michael J - Eagan, MN - Contractor" 
	<Michael.J.Mestnik@usps.gov>
Subject: Using Format/export-subst Howto.
Date: Fri, 14 Sep 2012 07:20:23 -0500
Message-ID: <84EA18831601B6429E578236AE239B01A54807F242@EAGNMNSXMB07.usa.dce.usps.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 14 14:35:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCV7e-0000CN-Ai
	for gcvg-git-2@plane.gmane.org; Fri, 14 Sep 2012 14:35:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751979Ab2INMfl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2012 08:35:41 -0400
Received: from mailwest2.usps.gov ([56.0.84.22]:44926 "EHLO
	gk-w2-email.srvs.usps.gov" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751017Ab2INMfk convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2012 08:35:40 -0400
X-Greylist: delayed 900 seconds by postgrey-1.27 at vger.kernel.org; Fri, 14 Sep 2012 08:35:40 EDT
DKIM-Signature: v=1; a=rsa-sha256; d=usps.gov; s=uspsgov0830; c=relaxed/simple;
	q=dns/txt; i=@usps.gov; t=1347625239; x=1351513239;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=BfFrVpO0seaRWaziePv7u8lqnolLPOtn5EpIOai1eYA=;
	b=ZHExl6UaJwR6vRdsaKos4sJGbW7v2Rf7z1kvd7k0VsshFehBKAw6aDVC/ieN8Tdo
	0eb39KZACqVR2EZvjl8OgicWujL6+kPSL+jTIz09kZMluivO1lMnlTnfK0xYHALI
	mcUfKwlXsjUN5vh/3emSijsGCGZi3STGgth072wc/Qo=;
Received: from mailrelay-w3i.usps.gov (Unknown_Domain [56.224.66.58])
	by gk-w2-email.srvs.usps.gov (Sendmail 8.14.3) with SMTP id 11.C5.21176.90123505; Fri, 14 Sep 2012 07:20:25 -0500 (CDT)
X-AuditID: 38005411-b7fc36d0000052b8-11-505321090593
Received: from EAGNMNSXMHC05.usa.dce.usps.gov (EAGNMNSXMHC05.usa.dce.usps.gov [56.207.244.215])
	by mailrelay-w3i.usps.gov (Symantec Messaging Gateway) with SMTP id DD.95.03288.C3123505; Fri, 14 Sep 2012 05:21:16 -0700 (PDT)
Received: from EAGNMNSXMB07.usa.dce.usps.gov ([169.254.1.98]) by
 EAGNMNSXMHC05.usa.dce.usps.gov ([56.207.244.215]) with mapi; Fri, 14 Sep 2012
 07:20:25 -0500
Thread-Topic: Using Format/export-subst Howto.
Thread-Index: Ac2Sc1DZB0C5do7qTAOUGhRneoZIhQ==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKIsWRmVeSWpSXmKPExsViwRCirSumGBxgMHuVtUXXlW4mB0aPz5vk
	AhijuG2SEkvKgjPT8/TtErgz2o9eYyroZa/of/OauYHxE2sXIyeHhICJxMlbz9kgbDGJC/fW
	A9lcHEIC+xklZr25xQJTdPduNytE4iGjxNfl81kgnIWMEpP3rABrZxMIkljzaR+QzcEhIqAv
	0XdBFCTMIqAq8W3SerASYQFNiU2b3rGD2CICehL3t99ghbHPdv5gBLF5BcIkZr9+ygRiMwJd
	9P3UGjCbWUBc4taT+UwQBwlILNlznhnCFpV4+fgfK0S9qMSd9vWMEPU6Egt2f2KDsLUlli18
	zQwxX1Di5MwnYPdLCMxgk3j3q40F5v0PS7YxTWAUn4Vk3ywks2YhmTULyawFjCyrGCXTs3XL
	jXRTcxMzc/SKi8qK9UqLC4r10vPLNjFC4klwB2P/Vd1DjAIcjEo8vAH/AgOEWBPLiitzDzFK
	cDArifDaagcFCPGmJFZWpRblxxeV5qQWH2KU5mBREuctfwZULZCeWJKanZpakFoEk2Xi4AQR
	XFINjC3ntKctviKyqr8p+hEL8+tDp5+67Ml2naLHy2wdsupH/6aVs49uUg+S9rm1aq96Cffb
	Uypiu1M4LkTks/w85tNo/8Xw42qzwMJKnVPrk9d43Pp/490fCz2/yjihIMbUve8W+bJssFFb
	kK/1+7BtjvSjkuUrNZuO6pzNv2JjP3/GgeOfv6dxXVZiKc5INNRiLipOBACy/A9yqAIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFLMWRmVeSWpSXmKPExsVicf7LdV0bxeAAg9VbjS26rnQzOTB6fN4k
	F8AYxWWTkpqTWZZapG+XwJXRfvQaU0Eve0X/m9fMDYyfWLsYOTkkBEwk7t7thrLFJC7cW8/W
	xcjFISTwkFHi6/L5LBDOQkaJyXtWsIFUsQkESaz5tA/I5uAQEdCX6LsgChJmEVCV+DZpPViJ
	sICmxKZN79hBbBEBPYn722+wwthnO38wgti8AmESs18/ZQKxGYEWfz+1BsxmFhCXuPVkPhPE
	QQISS/acZ4awRSVePv7HClEvKnGnfT0jRL2OxILdn9ggbG2JZQtfM0PMF5Q4OfMJywRG4VlI
	xs5C0jILScssJC0LGFlWMYrlJmbmFKXmJFbqlhtn6pUWFxTrpeeXbWIEhfgDJ6MdjLcemh9i
	FOBgVOLh3cAeFCDEmlhWXJl7iFGCg1lJhNdWGyjEm5JYWZValB9fVJqTWnyIUZqDRUmcV8rP
	LUBIID2xJDU7NbUgtQgmy8TBKdXAuGj2ogRejo7y2725jauv7Jhupjk/nm+DwNY3N0Oe5S3T
	cT86fc23g8c0RM+dfb+p8dYew/q7U/qDemXfX7P/6vi2dOn85xxqW2+rGH9+3dhpwMAT+WPl
	d/aLOoEOW7y76sJ8gzeXlDBqdepoHUqUZdDcW3T93/I3XnXbW1dZugexst4zPKj2WImlOCPR
	UIu5qDgRACnqx5htAgAA
X-CFilter-Loop: DLP SM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205483>

I must have missed something reading through the documentation for this.  git version 1.7.11.3

$ git check-attr -a -- autorepair.d/AR02_new_rttest.sh
autorepair.d/AR02_new_rttest.sh: ident: set
autorepair.d/AR02_new_rttest.sh: export-subst: set

  echo "0..$_expected_tests"
  diag 'Script Version: $Id: 1ca40f8395ea361cc07d2ec1a2961c3df749dc3c $'
  diag 'By: $Format:%cn$ $Format:%ce$'
  diag 'At: $Format:%cD$'

I also believe that the documentation could try and better explain under what conditions "$Id" will be processed, it doesn't seam to happen on commit and even after a checkout this is not updated.  It does seam to update during a pull and that's basically all I need.

Thanks!

Mike Mestnik, Michael J
The ESM Tools
Enterprise Systems Monitoring
United States Postal Service
 O: (651) 406-2048
Michael.J.Mestnik@usps.gov
ITEnterpriseSystemsMonitoring@usps.gov
