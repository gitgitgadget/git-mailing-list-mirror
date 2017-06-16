Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A36B20282
	for <e@80x24.org>; Fri, 16 Jun 2017 06:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751879AbdFPGcK (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Jun 2017 02:32:10 -0400
Received: from resqmta-po-03v.sys.comcast.net ([96.114.154.162]:47228 "EHLO
        resqmta-po-03v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751755AbdFPGcJ (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 16 Jun 2017 02:32:09 -0400
Received: from resomta-po-10v.sys.comcast.net ([96.114.154.234])
        by resqmta-po-03v.sys.comcast.net with SMTP
        id LknQdcT3PWFyRLknhdG3nx; Fri, 16 Jun 2017 06:32:09 +0000
Received: from vm-fedora21.eagercon.com ([IPv6:2601:647:4d04:5190:20c:29ff:fe70:d3be])
        by resomta-po-10v.sys.comcast.net with SMTP
        id Lkngdue0emQlXLkngdnHlh; Fri, 16 Jun 2017 06:32:09 +0000
Subject: Re: Best practices for updating old repos
To:     Stefan Beller <sbeller@google.com>
References: <59432BCC.2040901@eagerm.com>
 <CAGZ79kZMCz9g7PW6km3gQJU5qipw27jvkVDXD64MUNKJykYZOw@mail.gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   Michael Eager <eager@eagerm.com>
Message-ID: <59437B68.5090601@eagerm.com>
Date:   Thu, 15 Jun 2017 23:32:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kZMCz9g7PW6km3gQJU5qipw27jvkVDXD64MUNKJykYZOw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfGcNuMB6PituoaBqNUjQ9qnfGxZ5+g+9M0LpxUBemdXSUUKIzqtMhVql8/LCpwcyKzYQDHTiFiY5h2ENjaNwc1I36/+CAqbhBdFv3AoddVNN5W98nsd9
 /O8TYkJfO9qYqp+x5G8CmabhFXY+HnVKNBj+nl0dRLytxd0UpOWaWd6MT374ED6F4zzxcAQUBufm+A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/15/2017 09:22 PM, Stefan Beller wrote:
> On Thu, Jun 15, 2017 at 5:52 PM, Michael Eager <eager@eagerm.com> wrote:
>
>> One other variant of the rebase approach I've thought of is to do
>> this incrementally, rebasing the old repo against an upstream commit
>> a short time after the old repo was forked, fixing any conflicts,
>> rebuilding and fixing build failures.  Then repeat, with a bit
>> newer commit.  Then repeat, until I get to the top.  This sounds
>> tedious, but some of it can be automated.  It also might result in
>> my making the changes compatible with upstream code which was later
>> abandoned or significantly changed.
>
> This sounds like
>
> https://github.com/mhagger/git-imerge
> https://www.youtube.com/watch?v=FMZ2_-Ny_zc

Thanks, Stefan.   I'll look into this; it may be similar to what
I was thinking of doing.  I'll have to watch the video.

-- 
Michael Eager	 eager@eagercon.com
1960 Park Blvd., Palo Alto, CA 94306  650-325-8077
