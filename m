Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E84F2027C
	for <e@80x24.org>; Mon, 29 May 2017 11:30:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751012AbdE2La4 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 29 May 2017 07:30:56 -0400
Received: from mikako.shopkeeper.de ([82.119.175.20]:26583 "EHLO
        mikako.shopkeeper.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750885AbdE2Laz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 May 2017 07:30:55 -0400
X-Greylist: delayed 605 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 May 2017 07:30:55 EDT
Received: from email.pecont.de (p54B8840B.dip0.t-ipconnect.de [84.184.132.11])
        (authenticated bits=0)
        by mikako.shopkeeper.de (8.15.2/8.14.3) with ESMTPSA id v4TBKfkV082879
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Mon, 29 May 2017 13:20:48 +0200 (CEST)
        (envelope-from mathias.artus@pecont.de)
Message-Id: <201705291120.v4TBKfkV082879@mikako.shopkeeper.de>
X-Authentication-Warning: mikako.shopkeeper.de: Host p54B8840B.dip0.t-ipconnect.de [84.184.132.11] claimed to be email.pecont.de
X-CTCH-RefID: str=0001.0A0C0205.592C0403.01BD,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
From:   Mathias Artus <mathias.artus@pecont.de>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Error with Templates: Could not find templates on cloning but on
 creating
Thread-Topic: Error with Templates: Could not find templates on cloning but
 on creating
Thread-Index: AdLYbQmZlWIJ+ANcSZmo3Pus4h+iZw==
Date:   Mon, 29 May 2017 11:20:32 +0000
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-tm-as-product-ver: SMEX-10.5.0.1057-8.100.1062-23098.004
x-tm-as-result: No--5.458000-5.000000-31
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,
Today i've tried to set up a template directory. I added in the system wide gitconfig the following lines:
	
	[init]
		templatedir = "//OurServer/SomeDirectory/GitTemplate"

Where //Ourserver is a Network Path.
With this line i can create a new Repository and the template gets copied. But when i clone a repo the following error shows up and the template doesn't get copied:
	templates not found /OurServer/SomeDirectory/GitTemplate

I Recognized that one slash was missing. Hence i added one:
	[init]
		templatedir = "///OurServer/SomeDirectory/GitTemplate"

Fine, cloning works after that, but creating a new repository then shows up a Warning:
	templates not found ///OurServer/SomeDirectory/GitTemplate

Is that a known bug or is it my Failure?

I use git 2.13 on windows 7


Kind regards
Mathias Artus

