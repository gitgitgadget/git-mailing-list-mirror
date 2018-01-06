Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 863831F406
	for <e@80x24.org>; Sat,  6 Jan 2018 22:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752074AbeAFWUp (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Jan 2018 17:20:45 -0500
Received: from vsmx012.vodafonemail.xion.oxcs.net ([153.92.174.90]:7566 "EHLO
        vsmx012.vodafonemail.xion.oxcs.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751274AbeAFWUo (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 6 Jan 2018 17:20:44 -0500
X-Greylist: delayed 439 seconds by postgrey-1.27 at vger.kernel.org; Sat, 06 Jan 2018 17:20:44 EST
Received: from vsmx004.vodafonemail.xion.oxcs.net (unknown [192.168.75.198])
        by mta-8-out.mta.xion.oxcs.net (Postfix) with ESMTP id 9049E8CE34F
        for <git@vger.kernel.org>; Sat,  6 Jan 2018 22:13:22 +0000 (UTC)
Received: from [192.168.22.206] (unknown [80.156.181.150])
        by mta-8-out.mta.xion.oxcs.net (Postfix) with ESMTPA id 6F832CDF7B
        for <git@vger.kernel.org>; Sat,  6 Jan 2018 22:13:20 +0000 (UTC)
To:     git@vger.kernel.org
From:   Friedrich Spee von Langenfeld <stehlampen@arcor.de>
Subject: Errors and other unpleasant things found by Cppcheck
Message-ID: <5fb2c981-7a7b-5a0f-f2bb-b16189980d9b@arcor.de>
Date:   Sat, 6 Jan 2018 23:13:23 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------24BAE6A9DCC0D8764DF352A4"
X-VADE-STATUS: LEGIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------24BAE6A9DCC0D8764DF352A4
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I analyzed the GitHub repository with Cppcheck. The resulting XML file 
is attached. Please open it in Cppcheck to view it comfortably.

Especially the bunch of errors could be of interest to you.

Greetings

Friedrich


--------------24BAE6A9DCC0D8764DF352A4
Content-Type: text/xml;
 name="Cppcheck results for Git.xml"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="Cppcheck results for Git.xml"

<?xml version="1.0" encoding="UTF-8"?>
<results version="2">
    <cppcheck version="1.81"/>
    <errors>
        <error id="uninitvar" severity="error" msg="Uninitialized variable: git_dir" verbose="Uninitialized variable: git_dir">
            <location file="config.c" line="219"/>
        </error>
        <error id="uninitvar" severity="error" msg="Uninitialized variable: oe" verbose="Uninitialized variable: oe">
            <location file="fast-import.c" line="3006"/>
        </error>
        <error id="uninitvar" severity="error" msg="Uninitialized variable: oe" verbose="Uninitialized variable: oe">
            <location file="fast-import.c" line="3023"/>
        </error>
        <error id="uninitvar" severity="error" msg="Uninitialized variable: mrtree" verbose="Uninitialized variable: mrtree">
            <location file="merge-recursive.c" line="2064"/>
        </error>
        <error id="uninitvar" severity="error" msg="Uninitialized variable: saved_namelen" verbose="Uninitialized variable: saved_namelen">
            <location file="read-cache.c" line="2107"/>
        </error>
        <error id="uninitvar" severity="error" msg="Uninitialized variable: explicit" verbose="Uninitialized variable: explicit">
            <location file="ref-filter.c" line="1287"/>
        </error>
        <error id="unknownEvaluationOrder" severity="error" msg="Expression &amp;#039;prev_ch=p_ch,(p_ch=*++p)!=&amp;#039;]&amp;#039;&amp;#039; depends on order of evaluation of side effects" verbose="Expression &amp;#039;prev_ch=p_ch,(p_ch=*++p)!=&amp;#039;]&amp;#039;&amp;#039; depends on order of evaluation of side effects">
            <location file="wildmatch.c" line="263"/>
        </error>
        <error id="uninitvar" severity="error" msg="Uninitialized variable: item" verbose="Uninitialized variable: item">
            <location file="builtin\clean.c" line="268"/>
        </error>
        <error id="uninitvar" severity="error" msg="Uninitialized variable: item" verbose="Uninitialized variable: item">
            <location file="builtin\clean.c" line="692"/>
        </error>
        <error id="uninitvar" severity="error" msg="Uninitialized variable: item" verbose="Uninitialized variable: item">
            <location file="builtin\clean.c" line="758"/>
        </error>
        <error id="uninitvar" severity="error" msg="Uninitialized variable: string_list_item" verbose="Uninitialized variable: string_list_item">
            <location file="builtin\clean.c" line="357"/>
        </error>
        <error id="uninitvar" severity="error" msg="Uninitialized variable: item" verbose="Uninitialized variable: item">
            <location file="builtin\clean.c" line="688"/>
        </error>
        <error id="uninitvar" severity="error" msg="Uninitialized variable: item" verbose="Uninitialized variable: item">
            <location file="builtin\clean.c" line="1009"/>
        </error>
        <error id="uninitvar" severity="error" msg="Uninitialized variable: item" verbose="Uninitialized variable: item">
            <location file="builtin\clone.c" line="1000"/>
        </error>
        <error id="uninitvar" severity="error" msg="Uninitialized variable: item" verbose="Uninitialized variable: item">
            <location file="builtin\config.c" line="456"/>
        </error>
        <error id="uninitvar" severity="error" msg="Uninitialized variable: item" verbose="Uninitialized variable: item">
            <location file="builtin\describe.c" line="161"/>
        </error>
        <error id="uninitvar" severity="error" msg="Uninitialized variable: item" verbose="Uninitialized variable: item">
            <location file="builtin\describe.c" line="175"/>
        </error>
        <error id="uninitvar" severity="error" msg="Uninitialized variable: pos" verbose="Uninitialized variable: pos">
            <location file="builtin\interpret-trailers.c" line="46"/>
        </error>
        <error id="uninitvar" severity="error" msg="Uninitialized variable: tmp" verbose="Uninitialized variable: tmp">
            <location file="builtin\interpret-trailers.c" line="46"/>
        </error>
        <error id="uninitvar" severity="error" msg="Uninitialized variable: item" verbose="Uninitialized variable: item">
            <location file="builtin\ls-files.c" line="259"/>
        </error>
        <error id="uninitvar" severity="error" msg="Uninitialized variable: item" verbose="Uninitialized variable: item">
            <location file="builtin\name-rev.c" line="202"/>
        </error>
        <error id="uninitvar" severity="error" msg="Uninitialized variable: item" verbose="Uninitialized variable: item">
            <location file="builtin\name-rev.c" line="213"/>
        </error>
        <error id="doubleFree" severity="error" msg="Memory pointed to by &amp;#039;buf&amp;#039; is freed twice." verbose="Memory pointed to by &amp;#039;buf&amp;#039; is freed twice.">
            <location file="builtin\notes.c" line="265"/>
        </error>
        <error id="uninitvar" severity="error" msg="Uninitialized variable: item" verbose="Uninitialized variable: item">
            <location file="builtin\repack.c" line="314"/>
        </error>
        <error id="uninitvar" severity="error" msg="Uninitialized variable: reaches" verbose="Uninitialized variable: reaches">
            <location file="builtin\rev-list.c" line="482"/>
        </error>
        <error id="uninitvar" severity="error" msg="Uninitialized variable: all" verbose="Uninitialized variable: all">
            <location file="builtin\rev-list.c" line="482"/>
        </error>
        <error id="leakNoVarFunctionCall" severity="error" msg="Allocation with malloc_startup, memcpy doesn&amp;#039;t release it." verbose="Allocation with malloc_startup, memcpy doesn&amp;#039;t release it.">
            <location file="compat\mingw.c" line="2139"/>
        </error>
        <error id="memleak" severity="error" msg="Memory leak: sbcset" verbose="Memory leak: sbcset">
            <location file="compat\regex\regcomp.c" line="3085"/>
        </error>
        <error id="memleak" severity="error" msg="Memory leak: mbcset" verbose="Memory leak: mbcset">
            <location file="compat\regex\regcomp.c" line="3085"/>
        </error>
        <error id="memleak" severity="error" msg="Memory leak: sbcset" verbose="Memory leak: sbcset">
            <location file="compat\regex\regcomp.c" line="3633"/>
        </error>
        <error id="memleak" severity="error" msg="Memory leak: mbcset" verbose="Memory leak: mbcset">
            <location file="compat\regex\regcomp.c" line="3633"/>
        </error>
        <error id="uninitvar" severity="error" msg="Uninitialized variable: table_size" verbose="Uninitialized variable: table_size">
            <location file="compat\regex\regcomp.c" line="2801"/>
        </error>
        <error id="uninitvar" severity="error" msg="Uninitialized variable: table_size" verbose="Uninitialized variable: table_size">
            <location file="compat\regex\regcomp.c" line="2804"/>
        </error>
        <error id="uninitvar" severity="error" msg="Uninitialized variable: lrr_count" verbose="Uninitialized variable: lrr_count">
            <location file="contrib\examples\builtin-fetch--tool.c" line="420"/>
        </error>
        <error id="uninitvar" severity="error" msg="Uninitialized variable: lrr_list" verbose="Uninitialized variable: lrr_list">
            <location file="contrib\examples\builtin-fetch--tool.c" line="427"/>
        </error>
        <error id="preprocessorErrorDirective" severity="error" msg="No header in #include" verbose="No header in #include">
            <location file="sha1dc\ubc_check.c" line="31"/>
        </error>
        <error id="preprocessorErrorDirective" severity="error" msg="No header in #include" verbose="No header in #include">
            <location file="sha1dc\ubc_check.c" line="371"/>
        </error>
        <error id="preprocessorErrorDirective" severity="error" msg="No header in #include" verbose="No header in #include">
            <location file="sha1dc\ubc_check.h" line="49"/>
        </error>
        <error id="memleak" severity="error" msg="Memory leak: entries" verbose="Memory leak: entries">
            <location file="t\helper\test-hashmap.c" line="129"/>
        </error>
        <error id="memleak" severity="error" msg="Memory leak: hashes" verbose="Memory leak: hashes">
            <location file="t\helper\test-hashmap.c" line="129"/>
        </error>
        <error id="syntaxError" severity="error" msg="Invalid number of character &amp;#039;{&amp;#039; when no macros are defined." verbose="Invalid number of character &amp;#039;{&amp;#039; when no macros are defined.">
            <location file="t\t4051\appended1.c" line="3"/>
        </error>
        <error id="syntaxError" severity="error" msg="Invalid number of character &amp;#039;{&amp;#039; when no macros are defined." verbose="Invalid number of character &amp;#039;{&amp;#039; when no macros are defined.">
            <location file="t\t4051\appended2.c" line="35"/>
        </error>
    </errors>
</results>

--------------24BAE6A9DCC0D8764DF352A4--
