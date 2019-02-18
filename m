Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PI_DNOT,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 990131F453
	for <e@80x24.org>; Mon, 18 Feb 2019 16:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732097AbfBRQNC convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 18 Feb 2019 11:13:02 -0500
Received: from elephants.elehost.com ([216.66.27.132]:59153 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730659AbfBRQNB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Feb 2019 11:13:01 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x1IGCuPk068659
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 18 Feb 2019 11:12:56 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Senol Yazici'" <sypsilon@googlemail.com>, <git@vger.kernel.org>
References: <5c62b41d.1c69fb81.fe791.877b@mx.google.com> <CAFacdQ-soWD176VHgd+raHaV=VPpzKXrDrLFavPcNEoewZwBYA@mail.gmail.com> CAFacdQ-soWD176VHgd+raHaV=VPpzKXrDrLFavPcNEoewZwBYA@mail.gmail.com <5c657002.1c69fb81.d433c.32ce.GMR@mx.google.com> <CAFacdQ8NDKfd0p8=9Rh3s4FPeS9mbqpQt8mw3AZoJn9jHjriPg@mail.gmail.com>
In-Reply-To: <CAFacdQ8NDKfd0p8=9Rh3s4FPeS9mbqpQt8mw3AZoJn9jHjriPg@mail.gmail.com>
Subject: RE: Delivery Status Notification (Failure)
Date:   Mon, 18 Feb 2019 11:12:49 -0500
Message-ID: <000b01d4c7a4$ce4db4b0$6ae91e10$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQIG8tPn8ZhkYxBZqOqCto1UqajiFwGSg2oqAmc8qhwCvsNoFaVLnRXA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On February 18, 2019 5:47, Senol Yazici
> I just stumbled over following page
> 
> https://git-scm.com/about/distributed
> 
> and was wondering if it is possible to
> 
> - demilitarise that “dictator/lieutenant” thing and
> - de-religionise that “blessed” thing
> 
> I did not had the feeling that git is “pro military”, or is against “non religious”
> developers/users.

I think there is a point here. In some of my customers, we have replaced these terms with the following (the Repository is optional in the second two):

* Blessed: Repository of Record
* Dictator: Committer [Repository]
* Lieutenant: Contributor [Repository]

This seems more closely aligned with the real roles being applied to activities associated with the repositories involved.

Taking a lesson from other Open Source projects, Jenkins has deprecated Master/Slave in favour of Controller/Agent. This seems not only more acceptable to some, but in my view more descriptive. The terms on the page above do not actually make any descriptive sense to a newbie. And confusion could ensue from the dictionary definitions:

* Lieutenant: an aide or representative of another in the performance of duty : assistant (not what that repository is for)
* Dictator: one holding complete autocratic control : a person with unlimited governmental power (not how the git team behaves)
* Blessed: honored in worship : hallowed; of or enjoying happiness (although I can see the happiness part of this one)

Regards,
Randall


