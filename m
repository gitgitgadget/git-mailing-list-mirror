Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE6E5206A4
	for <e@80x24.org>; Mon, 12 Dec 2016 20:24:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752997AbcLLUYm (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Dec 2016 15:24:42 -0500
Received: from mout.gmx.net ([212.227.15.19]:51427 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932163AbcLLUYl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2016 15:24:41 -0500
Received: from [192.168.178.43] ([88.71.239.96]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MNZgw-1cICtr3Bvu-0079kX; Mon, 12
 Dec 2016 21:24:29 +0100
Subject: Re: git add -p with new file
To:     Ariel <asgit@dsgml.com>, Duy Nguyen <pclouds@gmail.com>
References: <alpine.DEB.2.11.1612062012540.13185@cherryberry.dsgml.com>
 <CACsJy8A_YMyEUgX--1tEfJC4aaYfDbFFL8WEs6CHp4a4=mHRjw@mail.gmail.com>
 <alpine.DEB.2.11.1612091322290.13185@cherryberry.dsgml.com>
Cc:     Git Mailing List <git@vger.kernel.org>
From:   Stephan Beyer <s-beyer@gmx.net>
Message-ID: <e60f6324-421f-3445-b2a9-02c2dd0c2688@gmx.net>
Date:   Mon, 12 Dec 2016 21:24:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.5.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.11.1612091322290.13185@cherryberry.dsgml.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:64mhU6EgYtEdhVhtqXYPIB2bJ0PZzUOBm2q6k3A69Qsy3CmDmJq
 KTZtbMeiL4aVhYxb8JDjynYMyyyEvYlFgeWqDjyZ2UAWnFOI9VHp2F79tWfvkct+TakM8tJ
 1EEqUIiDZ8vDK3+dp1I/eozkv1VF8R4CQCuipaFep1j8k0JeCfXBKpArEumK8TaX01GE/tE
 j2c6JrBxiuN/YlwtLo8Zg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QqRiVH1bMgU=:8fSceGZZJVrNaan/E8xEYh
 84tf5FeDqn7cq3lf3iE2dx49+oAHNJCklI3MqLXpOfo20JQefdXs7++iVj3I8tREGME6UclPn
 WWWSm3vKEqihjJ1bofWkdaskhdQA6tmZ/tzB04zGecHDxf0c4vejHop+3hYzRsb2RG+zZpgNL
 QnmwcwxwzIr2jg/l9c8J8kj1l9XWaby5WgHYx7Dl58XhgHtrvY5aNjtnlNozGWOAi/AFox52k
 BiIGqulrn4vUR4EiX8rGnIluyi0CpnqoL37dXkoNiB9JdJLy+O2SZRI9Y5MrvBbh2crEj7Gh3
 a6pRKU7iov7JxwE5/y+fuHSSNPsxECmb4fLxVTRTkl4r4l4Qer7BaR4kprXCZyMxmduc5zeeO
 bjjYaIX/2jms/9SwBgMToAiPoUJXEwK+kARuyoTdoGA2ilPJgrfZLaGcIwK7wOty9npfN4bgh
 8jiGFqJlDTeZxi3M55yXfcKZggezdSWPmf0FwEWK46SE8U68aHoQ5R+LRbLNy+IF8nagoXJZr
 Rj0lGppIl4shfSmBs6teZHm6idM7zjpNk36D8v8Zw6E/OsHi0iODmqWOmxu9p6pF/ZPSfHuBl
 C5oF4b3rGbd1pP3i0SvmTCB6GfVZXZ6MgDm50UOFLw1GCbi/sx7SWcPygd9tc640hS7nupzOC
 FD/CabHUpMipXad0uB9vns8ObMuS6HbX3oMN2BhrcaEQBSn84eVhvuTPoq9Y+7wELLruvQFOd
 scswp9O99jFvOdshSIWkhda0wgHdL607nlxULAoHJhcyBFkjEEvlQfY3/SVSXk4qP35edNnAf
 X94hUi5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ariel,

On 12/09/2016 07:26 PM, Ariel wrote:
> On Wed, 7 Dec 2016, Duy Nguyen wrote:
>> We could improve it a bit, suggesting the user to do git add -N. But
>> is there a point of using -p on a new file?
> 
> I got into the habit of always using -p as a way of checking my diffs
> before committing,

Not commenting on the main issue here, but if you want to check your new
files with a "git add -p"-like tool, you can do

	git add <untracked files>
	git reset -p

(this is unstaging, but it's still useful)

Best
  Stephan
