Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F05E1F667
	for <e@80x24.org>; Wed, 16 Aug 2017 12:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752298AbdHPMF5 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 16 Aug 2017 08:05:57 -0400
Received: from smtpgw01.csem.ch ([138.131.145.33]:51823 "EHLO smtpgw01.csem.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752270AbdHPMFy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2017 08:05:54 -0400
X-Greylist: delayed 901 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Aug 2017 08:05:53 EDT
X-AuditID: 8a839121-339ff70000002f46-d1-5994319b10aa
Received: from smtpgw02in.csem.local ( [138.131.145.16])
        (using TLS with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by smtpgw01.csem.ch (Symantec Messaging Gateway) with SMTP id F9.BC.12102.B9134995; Wed, 16 Aug 2017 13:50:51 +0200 (CEST)
Received: from srvne115.csem.local ([138.131.150.115]:47562)
        by smtpgw02in.csem.local with esmtp (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <Yves.CHEVALLIER@csem.ch>)
        id 1dhwqW-0006kV-2b
        for git@vger.kernel.org; Wed, 16 Aug 2017 13:50:48 +0200
Received: from webmail.csem.ch ([138.131.150.110])
  by srvne115.csem.local (PGP Universal service);
  Wed, 16 Aug 2017 13:50:44 +0200
X-PGP-Universal: processed;
        by srvne115.csem.local on Wed, 16 Aug 2017 13:50:44 +0200
Received: from SRVNE111.csem.local ([138.131.150.111]) by srvne110.csem.local
 ([138.131.150.110]) with mapi id 14.03.0351.000; Wed, 16 Aug 2017 13:50:49
 +0200
From:   CHEVALLIER Yves <Yves.CHEVALLIER@csem.ch>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Bug with ignorecase on Git and Cygwin
Thread-Topic: Bug with ignorecase on Git and Cygwin
Thread-Index: AdMWg/2uM1GvfhErTCOAl3lHX5ohTw==
Date:   Wed, 16 Aug 2017 11:50:47 +0000
Message-ID: <078108E7D0BA58498F61BC8C1ED2D10933E86F@srvne111.csem.local>
Accept-Language: fr-CH, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [138.131.173.118]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrALMWRmVeSWpSXmKPExsXS1TxRQHe24ZRIg77FbBZdV7qZHBg9Pm+S
        C2CM4rJJSc3JLEst0rdL4Mo4su0aS8EcvooX/xtZGxi/cnUxcnJICJhInLh0k72LkYtDSGAx
        k0Tbr1MsIAkhgR+MEnOnOUEkOhglbuzrZYboCJfYdOAQG0RiEVCidx1YB5uAvsThWd1Aozg4
        RIDsvguiIGFhAT2Jv3u2gpWICBhL/Nn1HMrWk5i/ZQ0riM0ioCpx4s8MRhCbV8BDYt/xZWA1
        jAKyEvPezGMDsZkFxCVuPZnPBHGDgMSSPeeh7hGVePn4HyuErSyx9dMmRoh6HYkFuz9B9WpL
        LFv4mhlivqDEyZlPWCYwis5CMnYWkpZZSFpmIWlZwMiyilG4OLekIL3cwFAvuTg1Vy8nPzkx
        ZxMjJB4UdzBOX2h5iFGAg1GJh/eHxeRIIdbEsuLK3EOMEhzMSiK8u/WnRArxpiRWVqUW5ccX
        leakFh9ilOZgURLn3dd/PkJIID2xJDU7NbUgtQgmy8TBKdXAGCD8Tsllgdunu2LXDncZKc21
        8N+wYK/yx8Tvd5cVy5/5d672XvHFM9dWNnAfMZOe8fb2JnmpJWyrTldpL/PPPKU56frsdNbb
        T+IbW2eVtP17nXKh7UKp8gM5tQIr8c65Zd3+PFHJu3hrDqqaC9x7U3zbr8p1VsTraSKzZJak
        T2xM+F2RymGeqsRSnJFoqMVcVJwIADw+zLyDAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, 

On Cygwin, the config value `ignorecase` is set to `true` during `git init` and it is not possible to change the default value using templates. 

The issue was discovered while I was tracking a bunch of source files of a SDK. To track the changes I simply rm all the working directory, unzip the new SDK, then git add . and git commit -am "new sdk". In this process an issue with an assembly file with preprocessing was incorrectly named .s instead of .S. In the next version the correction was made, but Git was unable to detect it. 

That said I've tried to manually change ignorecase from true to false and I still have the issue. Git on Cygwin cannot detect files renamed with a case change. 

Is it a bug?

# It works on Ubuntu

	$ git --version
	git version 1.8.3.1
    $ # To be sure 
    $ git config --global init.templateDir /usr/share/git-core/templates
	$ cat /usr/share/git-core/templates
	# Patched config 
	[core] 
	    dummyvar = true 
		ignorecase = false
		
	$ git init dummy 
	$ cat dummy/.git/config
	# Patched config
	[core]
		ignorecase = false
		dummyvar = true
		repositoryformatversion = 0
		filemode = true
		bare = false
		logallrefupdates = true

# It doesn't work on Cygwin:

	$ git --version
	git version 2.13.2
	$ which git
	/usr/bin/git
    $ # To be sure 
    $ git config --global init.templateDir /usr/share/git-core/templates
	$ cat /usr/share/git-core/templates
	# Patched config 
	[core] 
	    dummyvar = true 
		ignorecase = false		
	$ git init dummy 
	$ cat dummy/.git/config
	# Patched config
	[core]
		ignorecase = true
		dummyvar = false
		repositoryformatversion = 0
		filemode = true
		bare = false
		logallrefupdates = true
