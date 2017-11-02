Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FE2A20281
	for <e@80x24.org>; Thu,  2 Nov 2017 23:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934482AbdKBXKT convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 2 Nov 2017 19:10:19 -0400
Received: from marcos.anarc.at ([206.248.172.91]:36690 "EHLO marcos.anarc.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932201AbdKBXKT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 19:10:19 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])      (Authenticated sender: anarcat) with ESMTPSA id C4C911A00AA
From:   =?utf-8?Q?Antoine_Beaupr=C3=A9?= <anarcat@debian.org>
To:     Thomas Adam <thomas@xteddy.org>
Cc:     Thomas Adam <thomas@xteddy.org>, git@vger.kernel.org
Subject: Re: [PATCH v3 7/7] remote-mediawiki: show progress while fetching namespaces
In-Reply-To: <20171102223102.j3niifmupcs77p3r@laptop.local>
Organization: Debian
References: <20171030025142.19421-1-anarcat@debian.org> <20171102212518.1601-1-anarcat@debian.org> <20171102212518.1601-8-anarcat@debian.org> <20171102221807.juon446b6zfw64cq@laptop.local> <87vais48rg.fsf@curie.anarc.at> <20171102223102.j3niifmupcs77p3r@laptop.local>
Date:   Thu, 02 Nov 2017 19:10:17 -0400
Message-ID: <87o9ok46qu.fsf@curie.anarc.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-11-02 22:31:02, Thomas Adam wrote:
> On Thu, Nov 02, 2017 at 06:26:43PM -0400, Antoine Beaupré wrote:
>> On 2017-11-02 22:18:07, Thomas Adam wrote:
>> > Hi,
>> >
>> > On Thu, Nov 02, 2017 at 05:25:18PM -0400, Antoine Beaupré wrote:
>> >> +        print {*STDERR} "$#{$mw_pages} found in namespace $local_namespace ($namespace_id)\n";
>> >
>> > How is this any different to using warn()?  I appreciate you're using a
>> > globbed filehandle, but it seems superfluous to me.
>> 
>> It's what is used everywhere in the module, I'm just tagging along.
>> 
>> This was discussed before: there's an issue about cleaning up the
>> messaging in that module, that can be fixed separately.
>
> Understood.  That should happen sooner rather than later.

Actually, is there a standard way to do this in git with Perl
extensions? I know about "option verbosity N" but how should I translate
this into Perl? Carp? Warn? Log::Any? Log4perl?

Recommendations welcome...

A.

-- 
Si Dieu existe, j'espère qu'Il a une excuse valable
                        - Daniel Pennac
