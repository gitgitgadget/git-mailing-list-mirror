Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CC031F5FB
	for <e@80x24.org>; Mon, 27 Feb 2017 13:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751424AbdB0NjG (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 08:39:06 -0500
Received: from mout.web.de ([212.227.17.11]:59417 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751030AbdB0NjD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 08:39:03 -0500
Received: from [192.168.178.36] ([79.237.49.102]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lk8t4-1cC1gk2evi-00c9tA; Mon, 27
 Feb 2017 14:29:24 +0100
Subject: Re: SHA1 collisions found
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
References: <20170223164306.spg2avxzukkggrpb@kitenet.net>
 <CACsJy8AtQG8YXQ+YfSFifUxqtd==THj5weJK5jooyiRN0yamiQ@mail.gmail.com>
 <20170225190410.anvb7ll7tlhwgm3t@genre.crustytoothpaste.net>
Cc:     Duy Nguyen <pclouds@gmail.com>, Joey Hess <id@joeyh.name>,
        Git Mailing List <git@vger.kernel.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <13bb2033-fedd-d7da-f584-21a3142852d3@web.de>
Date:   Mon, 27 Feb 2017 14:29:18 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20170225190410.anvb7ll7tlhwgm3t@genre.crustytoothpaste.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:gqjW2nb7AZamQe3kPs+gXrDzgTtiaUSZ7uECJArK66MvV3/4zYk
 5t/1Dup6blQVMz9G0xAwqYCTdBE35u8POp6jaB3KVxiRZUzQDIrRpzoo/1EdbDUhsJyq+VW
 xxJ2lXzsMhS847Fl4n0DTQ1J7+03c5GV7GgK3T8fyet6p6qQMFJ6z/aWCyb+8dBhptUPadz
 1Wt4VGgSx9smosW+PBL0A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:j+AmnzU2qNU=:AnFqeRlcu7T/6peGGbp4am
 a3+4U/0FLdndHXWxUSTVsKknaQwGmiyeD1A18dUPHMVhzciqm8dTLN7eahaevfcFkYky+OBoT
 46PdaDoycsuq6nFFTMEwau3wTDLjCdeRKdDDoPvNBTOpyHOAQTPEfaA4mUTPaZWh1hcSfVbU0
 Mw2uLRrPkxLyGni9zxT4rBtcytUSlJe7mAE8PVssyBKatAbaOaxsTGvpO23k7jyWpQu7lbiPn
 5Qa4dJtmtmhB6eHMb1x+3LVab4+oUddQMkiHp8t0Us1uQKlxwdgSE6MHAt//0xRr8fZDAugf3
 vQI3gEi7nY6p/U4zRrTTqmU46nrOgmwMemVapy+PuuS6IoyZlPaNkFoeRRq9kA1ZXD0fGOJAM
 tI6iSPC1xVdP/uGPVKOlyX0ZpsEexPVaTFTYMtWcW2+VHV4WTe80v0ZFO+b5uuVT+lXmnOxfR
 Y4ePBac05bz+94j1tJjlvXBC4vMDluE/aKa15c8A1RggOz+5qY0UXu8YII3qNfx4gJ5fNvM7m
 +09EpW/gJSoK4zWxGvH2ptSIF/kSEbxksML6Xzc3V62ZXo83EKTU8399k34hko4HFVVP93w3u
 dh9Y8TVq/6vaBf84no8z7Qapra+qXx/lxbbPvfbB+f4k7mlJ47u8tHyJjvNsOjq6nNa7Yr2rI
 0LeWqLbKbC9mtWAstpUBoq8AT4ktCq70+53RRMP9giCg/JNJWjpbh2X90OpHdg6asr0VMWblP
 H75eUoZSL3DaFPMpRe5J28AYtvvGfCxJAaz+or5erq+8kflVE4rA60mVavZa77N/inQecA8qQ
 YW1tUUn
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 25.02.2017 um 20:04 schrieb brian m. carlson:
>>> So I think that the current scope left is best estimated by the
>>> following command:
>>>
>>>   git grep -P 'unsigned char\s+(\*|.*20)' | grep -v '^Documentation'
>>>
>>> So there are approximately 1200 call sites left, which is quite a bit of
>>> work.  I estimate between the work I've done and other people's
>>> refactoring work (such as the refs backend refactor), we're about 40%
>>> done.
> 
> As a note, I've been working on this pretty much nonstop since the
> collision announcement was made.  After another 27 commits, I've got it
> down from 1244 to 1119.
> 
> I plan to send another series out sometime after the existing series has
> hit next.  People who are interested can follow the object-id-part*
> branches at https://github.com/bk2204/git.

Perhaps the following script can help a bit; it converts local and static
variables in specified files.  It's just a simplistic parser which can get
at least shadowing variables, strings and comments wrong, so its results
need to be reviewed carefully.

I failed to come up with an equivalent Coccinelle patch so far. :-/

René


#!/bin/sh
while test $# -gt 0
do
	file="$1"
	tmp="$file.new"
	test -f "$file" &&
	perl -e '
		use strict;
		my %indent;
		my %old;
		my %new;
		my $in_struct = 0;
		while (<>) {
			if (/^(\s*)}/) {
				my $len = length $1;
				foreach my $key (keys %indent) {
					if ($len < length($indent{$key})) {
						delete $indent{$key};
						delete $old{$key};
						delete $new{$key};
					}
				}
				$in_struct = 0;
			}
			if (!$in_struct and /^(\s*)(static )?unsigned char (\w+)\[20\];$/) {
				my $prefix = "$1$2";
				my $name = $3;
				$indent{$.} = $1;
				$old{$.} = qr/(?<!->)(?<!\.)(?<!-)\b$name\b/;
				$name =~ s/sha1/oid/;
				print $prefix . "struct object_id " . $name . ";\n";
				$new{$.} = $name . ".hash";
				next;
			}
			if (/^(\s*)(static )?struct (\w+ )?\{$/) {
				$in_struct = 1;
			}
			if (!$in_struct and ! /\/\*/) {
				foreach my $key (keys %indent) {
					s/$old{$key}/$new{$key}/g;
				}
			}
			print;
		}
	' "$file" >"$tmp" &&
	mv "$tmp" "$file" ||
	exit 1
	shift
done
