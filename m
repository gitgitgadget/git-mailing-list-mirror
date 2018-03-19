Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 488951F404
	for <e@80x24.org>; Mon, 19 Mar 2018 14:30:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933530AbeCSOaf (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 10:30:35 -0400
Received: from mut-mta1-se01a-zose1-fr.yulpa.io ([185.49.21.248]:36574 "EHLO
        mut-mta1-se01a-zose1-fr.yulpa.io" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932708AbeCSOac (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 19 Mar 2018 10:30:32 -0400
X-Greylist: delayed 2362 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Mar 2018 10:30:32 EDT
Received: from zose-mx-out01.web4all.fr ([185.49.20.46] helo=zose-mta-hub-out-mua-02.web4all.fr)
        by mut-mta1-se01a-fr.yulpa.io with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <git@matthieu-moy.fr>)
        id 1exvBi-000DnZ-HN; Mon, 19 Mar 2018 14:51:05 +0100
Received: from localhost (localhost [127.0.0.1])
        by zose-mta-hub-out-mua-02.web4all.fr (Postfix) with ESMTP id D4AFB60E49;
        Mon, 19 Mar 2018 14:50:57 +0100 (CET)
Received: from zose-mta-hub-out-mua-02.web4all.fr ([127.0.0.1])
        by localhost (zose-mta-hub-out-mua-02.web4all.fr [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 7jBKG2WxjYmY; Mon, 19 Mar 2018 14:50:57 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zose-mta-hub-out-mua-02.web4all.fr (Postfix) with ESMTP id 5947660F84;
        Mon, 19 Mar 2018 14:50:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at zose1.web4all.fr
Received: from zose-mta-hub-out-mua-02.web4all.fr ([127.0.0.1])
        by localhost (zose-mta-hub-out-mua-02.web4all.fr [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id RN3HG-N3HRwx; Mon, 19 Mar 2018 14:50:57 +0100 (CET)
Received: from moylip (nautfst12.univ-lyon1.fr [134.214.142.79])
        (Authenticated sender: matthieu.moy@matthieu-moy.fr)
        by zose-mta-hub-out-mua-02.web4all.fr (Postfix) with ESMTPSA id 36C7F60E49;
        Mon, 19 Mar 2018 14:50:54 +0100 (CET)
References: <nycvar.QRO.7.76.6.1803191217410.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
User-agent: mu4e 1.0; emacs 24.5.1
From:   Matthieu Moy <git@matthieu-moy.fr>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Ville =?utf-8?Q?Skytt=C3=A4?= <ville.skytta@iki.fi>,
        Luke Diamand <luke@diamand.org>,
        Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org
Subject: Re: multimail/p4: issues identified by lgtm.com
In-reply-to: <nycvar.QRO.7.76.6.1803191217410.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Date:   Mon, 19 Mar 2018 14:50:43 +0100
Message-ID: <86d100uqbw.fsf@matthieu-moy.fr>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: 185.49.20.46
X-SpamExperts-Domain: zose1.web4all.fr
X-SpamExperts-Username: 185.49.20.46
Authentication-Results: yulpa.io; auth=pass smtp.auth=185.49.20.46@zose1.web4all.fr
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.07)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5mtlMO/mxKxUbNU7fT5IXG5602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO971bSIN96NVv+IMZVam7SC2wHwewjZh5Xd5YBPvxpBfNfm8EmBb+vo+OUVqLvZQLbkQ
 UFA0QhbfV5+15tKhOE//wwVDpwXymAEABC1IUXJNzOH6UIkcPrObxtlwdPrnxPYP6qHrQthZds6l
 4P414NnPak4NAcnq8KOMIFX6HA4RSh0IYMmLb5TEzF5YHRyy9Yl4OEMNsQuwpgbEFk99sLOmq3zv
 f6PSPqIikbzE5b8vJODXbtOodkPED+RkHjVGH+Y+AVTHAPNee46WGYwWe3A6LyrF4MQKOzzvnQnr
 8hsMT4wPt/OpIKGz7i7CIVU4whTHswbbB/ha+ZWrSAi8Skyxe17QIfgTGOgXzm19/3QDeZ59RfF/
 VI1q+Rmm2+UHK7ASVYnBhdKUnGmBdHG7BUn2dK6UtSEdwn3yFtfkzf2gFHLQzlG8ZpaJcA9oorTz
 b5YN6CxqPuk3xOJ6j9j7VPsjF+zaopzR+EXhgx3SXAfA5fJjsMYie1KIHivoqPV+yIMy2iO2w3c6
 blrMf3On8U7Y2dgVhFBmmtiker54swgmHwNvxu9HAKewkv0+phKZdN1mHTcTFOoOq4AKk2yYOuUS
 FEevI6IrOhkUGOYYF3dBGplHcpVCCoX989hgB8R+yE53ufVArBUDE4BTYJtudsKDOFYPuE5z0j7b
 XKXFr6ZG9N+PyLGMxPVK2Cy0Y4Xe+vFKes0nIijDAkybd8uG2uOvfcWe2ihgEES7DHO3PMGQUzaT
 jUW1cP1WbhuwMi+ICgDzS42xN4VrjJgkUZLUenT2f4gZCAPRGlwWC65zIqnNaoKg9b9VVGI4r0/K
 aAd0W9clTxNspOQVWap5sO+kfG7ZwogH/RRzXouiYI7YfpxQZjEa/sNl+vcoDGoYk0DAXSmC4D60
 6+Ipq2UhZR8vAu/DqcigOvSxdRnthmhn8Zn6aWrZrUlgdDND/i6cOItbj05c91oUlJFK7m5OBrtM
 fDJKJrcoxEfnFpm9QY4yOBflSQlYjKHWBXbyFNUxO4iwNdjZ2BWEUGaa2KR6vnizCCZMFTZq1uOx
 Qt3sHAFGc0h6q2VyZNYoPn0Qp1r9V9y1+JKIVfj9vA1k4g9l7rxwo+w=
X-Report-Abuse-To: spam@mut-mta1-se01a-fr.yulpa.io
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin writes:

> Hi team,
>
> while Coverity was down (it still is not reachable for me, but I guess
> that's just because everybody and their dog wants to catch up on a month
> of work delayed by their outage), I tried to find alternatives, and one of
> them is lgtm.com. Their C/C++ support is not generally available yet, but
> there have been a couple of issues identified in our Python scripts:
>
> https://lgtm.com/projects/g/git/git/alerts/?mode=list&rule=py%2Fcall%2Fwrong-arguments%2Cpy%2Fcall%2Fwrong-named-argument%2Cpy%2Fexplicit-call-to-delete%2Cpy%2Finconsistent-equality%2Cpy%2Finheritance%2Fincorrect-overridden-signature%2Cpy%2Fmissing-call-to-init%2Cpy%2Fmultiple-definition%2Cpy%2Fredundant-else%2Cpy%2Funinitialized-local-variable%2Cpy%2Funreachable-statement
>
> From a cursory look, it *does* seem as if there are legitimate issues
> there that want to be fixed ;-) But then, I am far from a Python expert,
> so my impressions could be completely off the mark.

For git-multimail, there are actually a lot of false-positive due to the
way we use multiple-inheritance (when calling super(...).__init__(),
lgtm assumes we're calling the superclass's constructor while we
actually call the "next in the method resolution order list"), but also
probably valid concerns.

I've set up a separate project for git-multimail:

  https://lgtm.com/projects/g/git-multimail/git-multimail/alerts/?mode=list

I'll have a deeper look ASAP.

Thanks!

-- 
Matthieu Moy
https://matthieu-moy.fr/
