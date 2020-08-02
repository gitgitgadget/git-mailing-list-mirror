Return-Path: <SRS0=XjWc=BM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F75C433E0
	for <git@archiver.kernel.org>; Sun,  2 Aug 2020 22:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9CA22076B
	for <git@archiver.kernel.org>; Sun,  2 Aug 2020 22:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="saBrIYrO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbgHBWFG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Aug 2020 18:05:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53825 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbgHBWFG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Aug 2020 18:05:06 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6DF787D430;
        Sun,  2 Aug 2020 18:05:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3hCHvCdkqPT47nkhvH0zdpZij0M=; b=saBrIY
        rOebWFPxLWjq1SoKPgg7LJsmSQ1GLY7AAEDmTFllch9os+WbNzktkkyKjlfjObfE
        pK05sMhxAf8MCjQsE4+rxgH49IE7Ckg3Qdafr030PfNVCuYbOONOOegtpzTwBIAg
        2YVysC/VkpmSmFJuCGNq5alkA/kF6NPRGgYOU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IukMnqsY6a+GDE1rROQy1OI5TCJm3MaP
        3jZWWb4933WL21iAVl4y7fXguuYohvmBrUnjgUdj0d9qn3FJ3MyjQY+If9AoxUUe
        WRrHQsjlnBnuDmpZkqq2ER/V5Xa01woIJl49djg4O2jPJxJnBNtqbruO9WKR71SE
        aQDLjIkpZJI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5D9E67D42E;
        Sun,  2 Aug 2020 18:05:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8B1197D429;
        Sun,  2 Aug 2020 18:05:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH 3/3] git.txt: add list of guides
References: <pull.691.git.1596381647.gitgitgadget@gmail.com>
        <9374d80f0c37a6b6a7f5f76601ee757f89712d0c.1596381647.git.gitgitgadget@gmail.com>
        <xmqqsgd4rad8.fsf@gitster.c.googlers.com>
Date:   Sun, 02 Aug 2020 15:05:00 -0700
In-Reply-To: <xmqqsgd4rad8.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Sun, 02 Aug 2020 14:44:35 -0700")
Message-ID: <xmqqv9i0wvoz.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 365253E2-D50C-11EA-983C-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Philippe Blain <levraiphilippeblain@gmail.com>
>>
>> Not all guides are mentioned in the 'git(1)' documentation,
>> which makes the missing ones somewhat hard to find.
>>
>> Add a list of the guides to git(1).
>>
>> Tweak `Documentation/cmd-list.perl` so that it also generates
>> a file `cmds-guide.txt` which gets included in git.txt.
>
> Who cleans this?  Do we need a change to Makefile?

A band-aid patch would look like this, BUT.

    diff --git a/Documentation/Makefile b/Documentation/Makefile
    index 39f6fc8de7..616449da88 100644
    --- a/Documentation/Makefile
    +++ b/Documentation/Makefile
    @@ -295,6 +295,7 @@ cmds_txt = cmds-ancillaryinterrogators.txt \
            cmds-plumbingmanipulators.txt \
            cmds-synchingrepositories.txt \
            cmds-synchelpers.txt \
    +       cmds-guide.txt \
            cmds-purehelpers.txt \
            cmds-foreignscminterface.txt

I think with a bit more work, we can be at a lot better place.  How
about something along the following line (untested)?

 Documentation/Makefile      |  3 ++-
 Documentation/cmd-list.perl | 21 ++++++++-------------
 2 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 39f6fc8de7..80d1908a44 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -295,6 +295,7 @@ cmds_txt = cmds-ancillaryinterrogators.txt \
 	cmds-plumbingmanipulators.txt \
 	cmds-synchingrepositories.txt \
 	cmds-synchelpers.txt \
+	cmds-guide.txt \
 	cmds-purehelpers.txt \
 	cmds-foreignscminterface.txt
 
@@ -302,7 +303,7 @@ $(cmds_txt): cmd-list.made
 
 cmd-list.made: cmd-list.perl ../command-list.txt $(MAN1_TXT)
 	$(QUIET_GEN)$(RM) $@ && \
-	$(PERL_PATH) ./cmd-list.perl ../command-list.txt $(QUIET_STDERR) && \
+	$(PERL_PATH) ./cmd-list.perl ../command-list.txt $(cmds_txt) $(QUIET_STDERR) && \
 	date >$@
 
 mergetools_txt = mergetools-diff.txt mergetools-merge.txt
diff --git a/Documentation/cmd-list.perl b/Documentation/cmd-list.perl
index 99f01a0910..af5da45d28 100755
--- a/Documentation/cmd-list.perl
+++ b/Documentation/cmd-list.perl
@@ -43,12 +43,15 @@ sub format_one {
 	}
 }
 
-while (<>) {
+my ($input, @categories) = @ARGV;
+
+open IN, "<$input";
+while (<IN>) {
 	last if /^### command list/;
 }
 
 my %cmds = ();
-for (sort <>) {
+for (sort <IN>) {
 	next if /^#/;
 
 	chomp;
@@ -56,18 +59,10 @@ sub format_one {
 	$attr = '' unless defined $attr;
 	push @{$cmds{$cat}}, [$name, " $attr "];
 }
+close IN;
 
-for my $cat (qw(ancillaryinterrogators
-		ancillarymanipulators
-		mainporcelain
-		plumbinginterrogators
-		plumbingmanipulators
-		synchingrepositories
-		foreignscminterface
-		purehelpers
-		synchelpers
-		guide)) {
-	my $out = "cmds-$cat.txt";
+for my $out (@categories) {
+	my ($cat) = $out =~ /^cmds-(.*)\.txt$/;
 	open O, '>', "$out+" or die "Cannot open output file $out+";
 	for (@{$cmds{$cat}}) {
 		format_one(\*O, $_);
