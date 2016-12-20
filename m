Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9B031FF6D
	for <e@80x24.org>; Tue, 20 Dec 2016 08:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932937AbcLTIEA (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Dec 2016 03:04:00 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:57245 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750927AbcLTID7 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 20 Dec 2016 03:03:59 -0500
X-AuditID: 12074412-5f5ff700000009b5-0d-5858e5eb4764
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id BE.5E.02485.BE5E8585; Tue, 20 Dec 2016 03:03:57 -0500 (EST)
Received: from [192.168.69.190] (p57907272.dip0.t-ipconnect.de [87.144.114.114])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id uBK83rxu025465
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Tue, 20 Dec 2016 03:03:54 -0500
Subject: Re: [PATCH 00/13] gitk: tweak rendering of remote-tracking references
To:     Philip Oakley <philipoakley@iee.org>,
        Paul Mackerras <paulus@samba.org>
References: <cover.1482164633.git.mhagger@alum.mit.edu>
 <CB83F601FBED482582F20099849D661A@PhilipOakley>
Cc:     Git List <git@vger.kernel.org>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <48f37df9-7264-f6d9-0d74-93e7949568e3@alum.mit.edu>
Date:   Tue, 20 Dec 2016 09:03:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.5.1
MIME-Version: 1.0
In-Reply-To: <CB83F601FBED482582F20099849D661A@PhilipOakley>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCIsWRmVeSWpSXmKPExsUixO6iqPv2aUSEQc83WYuuK91MFmuOLGa3
        6Jwq68DssXzpOkaPubv6GD0+b5ILYI7isklJzcksSy3St0vgyvj59S5bwT3Bis9TjrE3MHbz
        dTFyckgImEg8mriPvYuRi0NI4DKjRPuey1DOBSaJiac+sYFUCQv4STyeOAnI5uAQEfCWWLOq
        CCQsJJApsfjQBhYQm1lASeL3g7nsIDabgK7Eop5mJhCbV8Be4t+k86wgNouAqsTj6YfBRooK
        hEhcnnOUDaJGUOLkzCdgczgFbCQWbjrLBjFTT2LH9V+sELa8xPa3c5gnMPLPQtIyC0nZLCRl
        CxiZVzHKJeaU5urmJmbmFKcm6xYnJ+blpRbpmunlZpbopaaUbmKEBKjQDsb1J+UOMQpwMCrx
        8HZUR0QIsSaWFVfmHmKU5GBSEuXdzwMU4kvKT6nMSCzOiC8qzUktPsQowcGsJMJ79iFQjjcl
        sbIqtSgfJiXNwaIkzvtzsbqfkEB6YklqdmpqQWoRTFaGg0NJgvf8E6BGwaLU9NSKtMycEoQ0
        EwcnyHAeoOEnwYYXFyTmFmemQ+RPMepy3Hu78CmTEEtefl6qlDjvGpBBAiBFGaV5cHNgieUV
        ozjQW8K8b0GqeIBJCW7SK6AlTEBLFnaHgywpSURISTUwKqc96T0Xte7ioeU3Pe825FcJRGQ/
        do823rr8s2ZD8+7OOu83Gh/bO9RfVETt7p3z9vHzP8LVa9fydWhIP5AUjfFevuDPjyfX/sU9
        Tbi6kWln1zu+jrTetGMpt2Mn7olv5SzVaIi5z2B76Yt85PdpX6+8kpBwkHl0ftX5LQkLUo9Z
        5rEbxbzWV2Ipzkg01GIuKk4EAMxFESoHAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/19/2016 11:53 PM, Philip Oakley wrote:
> From: "Michael Haggerty" <mhagger@alum.mit.edu>
>> This patch series changes a bunch of details about how remote-tracking
>> references are rendered in the commit list of gitk:
>>
> [...]
>> * Introduce a separate constant to specify the background color used
>>  for the branch name part of remote-tracking references, to allow it
>>  to differ from the color used for local branches (which by default
>>  is bright green).
>>
>> * Change the default background colors for remote-tracking branches to
>>  light brown and brown (formerly they were pale orange and bright
>>  green).
>>
>> I understand that the colors of pixels on computer screens is an even
>> more emotional topic that that of bikesheds, so I implemented the last
>> change as a separate commit, the last one in the series. Feel free to
>> drop it if you don't want the default color change.
> 
> Just to say that there was an issue with the bright green (lime) a while
> back when 'green' changed its colour.
> 
> dscho reported in
> (https://github.com/git-for-windows/git/issues/300#issuecomment-133702654
> 26 Aug 2015)
> 
> "[T]his is a change in Tk 8.6 described here (http://wiki.tcl.tk/1424):
> From
> Tcl/Tk 8.6 on, Tk uses Web colours instead of X11 ones, where they
> conflict."
> 
> In particular the old bright green version of 'green' became a darker
> green,
> with the old colour becoming named lime.
> 
> For me, I needed to change my colour scheme (to a lime) as I could not read
> the refs against the darker colour.
> 
> Anyway, that's the background as I know it.

Thanks for the context. In fact, it was this color change that got me
looking at this code in the first place.

For anyone still suffering from the "green background of branch labels
in gitk got too dark" problem:

The default color in gitk was made lighter again in

    66db14c "gitk: Color name update", 2015-10-25

But your own configuration might still have "green" written in it, from
the days when "green" was still bright. If so, change the value for
`headbgcolor` to `lime` in `~/.config/git/gitk`.

It would be nice if these colors were adjustable via the "Preferences ->
Colors" dialog.

Michael

