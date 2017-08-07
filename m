Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96A252047F
	for <e@80x24.org>; Mon,  7 Aug 2017 17:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751914AbdHGRHv (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 13:07:51 -0400
Received: from mail-qk0-f170.google.com ([209.85.220.170]:36372 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751589AbdHGRHu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 13:07:50 -0400
Received: by mail-qk0-f170.google.com with SMTP id d136so6158353qkg.3
        for <git@vger.kernel.org>; Mon, 07 Aug 2017 10:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=/PWaYuCBRCG1ttsWNQCzYy0iH3tKCaFuW6KLjPL/SKo=;
        b=MvbZ906D1okdj27x9oDkyNMws7O51oo0Ta2j6bfBtZN52gh7HJspX+4TRukrCkBb68
         bWQJPGvrciMcGQi9b68XISvTEAHFb+zXT0eUpgNlMSPv8lx/uRVsvc+w1jagS40UI/uF
         PdCejGR1RrvRfFS9BEKp0AnwgOhVFzqjZBJmpcnf2JxP3XvhWelE7RLxvAujdyvOVcqu
         w1bAte97fZ8xF/1zcEJxwSxQcyV7Oix95QT/YFwr0qqj+tKIF2na83PMbHL8Kv0457jq
         p+cADRdYE8CujUP9swevmAm2BFiMFffYPfa7SWKiRUg9LK3icwgAgyw+MIskjLEZrPfS
         Z+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=/PWaYuCBRCG1ttsWNQCzYy0iH3tKCaFuW6KLjPL/SKo=;
        b=I3VgY44duJwzcGNaEPsp/Cx90kpxam1E8lbZjdL2jI25Th0OoyP4UJkUO5EuyTMJi7
         2zL32KUur7ZwuAbSBk1WX3Ui0FNYx76mVq5acnLb0CBvRlVYE616+h6a+0XFr7T2uIaF
         zb0pw+3z51ZpMl0EGl2xg25x8Bi6hDrHXuZYtVR6tB8SSimpWIHQUYIZcpRnAwIpPSbz
         h73DuGJimg2kPP15UyUq4TXgCsoTOTKZ/9jpOoa178iQf4A6qA5bjpOsGohxct7fCH0Q
         xjuu/jWw4PtMiq1TUCpe57j2lDvvm5M6JsAlypgN8syjVnVgfNgL3xArt/v4iXv0HcY7
         tmvA==
X-Gm-Message-State: AHYfb5j2c2x9y3AsNPHxqamBOf7LJPwSupk8lRpI0vi504ka+v8P1TPB
        pb8s9kvNQYaKTQ==
X-Received: by 10.55.20.230 with SMTP id 99mr1567624qku.236.1502125669679;
        Mon, 07 Aug 2017 10:07:49 -0700 (PDT)
Received: from zaya.teonanacatl.net (pool-71-113-173-254.hrbgpa.fios.verizon.net. [71.113.173.254])
        by smtp.gmail.com with ESMTPSA id 74sm5868569qkv.31.2017.08.07.10.07.47
        (version=TLS1_1 cipher=AES128-SHA bits=128/128);
        Mon, 07 Aug 2017 10:07:48 -0700 (PDT)
Date:   Mon, 7 Aug 2017 13:07:45 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     James Wells <james.wells@statseeker.com>, git@vger.kernel.org
Subject: Re: upgarding GIT
Message-ID: <20170807170745.GG25542@zaya.teonanacatl.net>
References: <9a2576ed8b7146459585af4238613286@statseeker.com>
 <871sonzlar.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <871sonzlar.fsf@gmail.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason wrote:
> On Mon, Aug 07 2017, James Wells jotted:
>> I am fairly new to git, however I have a challenge of upgrading git 
>> from 2.0.4 to 2.4.12 and my initial 2.0.4 install was done via TAR 
>> BALL on my server.
>>
>> I have a centos server running git and Atlassian STASH and my 
>> challenge is for me to upgrade the STASH application I need to move 
>> to a newer version of git.

Which release of CentOS are you using James?  And what git version is 
required for the Atlassian Stash (which is now called Bitbucket) 
release you're trying to use?  IIRC, they support as far back as git 
1.8?

> You're going to want to install git via RPM/yum. CentOS already has a 
> package for it.

Indeed.  (But I'm biased because I would never, ever install software 
via 'sudo make install' on anything other than a throw-away test 
instance.)

The one problem folks run into on CentOS/RHEL is that the versions may 
be somewhat old.  CentOS/RHEL 6 ships with git 1.7.1, for instance. 
CentOS/RHEL 7 is only a little newer, with git 1.8.3.  There are 
"software collections" which provide git 1.9¹ and 2.9², but personally 
I've never liked using software collections for software that I need 
to integrate with other tools.

For users of CentOS/RHEL who want to run the current git release in a 
packaged form, the Fedora git package maintainers take care to ensure 
that the Fedora packages can be built for the current supported 
releases of CentOS/RHEL (6 & 7 at the moment).  Grabbing the current 
code and/or srpm from Fedora should (almost³) always build cleanly 
using the mock build tool for CentOS/RHEL.

I also try to keep a semi-official COPR repo up to date, here:

    https://copr.fedorainfracloud.org/coprs/g/git-maint/git/

(Even as the primary maintainer of that repo, I'd still suggest that 
it's wise to either mirror it locally or rebuild the srpm's in your 
own infrastructure, to ensure that if the copr service is ever down 
you can reinstall important systems.)

¹ https://www.softwarecollections.org/en/scls/rhscl/git19/
² https://www.softwarecollections.org/en/scls/rhscl/rh-git29/
³ Right now, there's a slight issue building the current git for 
  CentOS 7 because RHEL 7.4 moved the pcre2 package from EPEL into 
  RHEL and CentOS 7.4 is not yet built.  The Fedora packages are 
  built against pcre2 now (thanks Ævar ;).  So for a few weeks it 
  won't be possible to build them for CentOS 7 without a minor change.

-- 
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Ocean, n. A body of water occupying about two-thirds of a world made
for man -- who has no gills.
    -- Ambrose Bierce, "The Devil's Dictionary"

