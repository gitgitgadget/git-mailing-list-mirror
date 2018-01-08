Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD89A1F406
	for <e@80x24.org>; Mon,  8 Jan 2018 10:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756517AbeAHKe6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 05:34:58 -0500
Received: from mut-mta1-se01a-zose1-fr.yulpa.io ([185.49.21.248]:47538 "EHLO
        mut-mta1-se01a-zose1-fr.yulpa.io" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755890AbeAHKe4 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 8 Jan 2018 05:34:56 -0500
Received: from zose-mx-out01.web4all.fr ([185.49.20.46] helo=zose-mta-hub-out-mua-02.web4all.fr)
        by mut-mta1-se01b-fr.yulpa.io with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <git@matthieu-moy.fr>)
        id 1eYUlT-0002Sd-OY; Mon, 08 Jan 2018 11:34:53 +0100
Received: from localhost (localhost [127.0.0.1])
        by zose-mta-hub-out-mua-02.web4all.fr (Postfix) with ESMTP id 7853160E20;
        Mon,  8 Jan 2018 11:34:46 +0100 (CET)
Received: from zose-mta-hub-out-mua-02.web4all.fr ([127.0.0.1])
        by localhost (zose-mta-hub-out-mua-02.web4all.fr [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 4FAWM-FtEY_u; Mon,  8 Jan 2018 11:34:42 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zose-mta-hub-out-mua-02.web4all.fr (Postfix) with ESMTP id 4CF7B60E5B;
        Mon,  8 Jan 2018 11:34:42 +0100 (CET)
X-Virus-Scanned: amavisd-new at zose1.web4all.fr
Received: from zose-mta-hub-out-mua-02.web4all.fr ([127.0.0.1])
        by localhost (zose-mta-hub-out-mua-02.web4all.fr [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id LgPhFGeeZrbo; Mon,  8 Jan 2018 11:34:42 +0100 (CET)
Received: from moylip.lip.ens-lyon.fr (dhcp-13-157.lip.ens-lyon.fr [140.77.13.157])
        (Authenticated sender: matthieu.moy@matthieu-moy.fr)
        by zose-mta-hub-out-mua-02.web4all.fr (Postfix) with ESMTPSA id 735A560E20;
        Mon,  8 Jan 2018 11:34:40 +0100 (CET)
From:   Matthieu Moy <git@matthieu-moy.fr>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Thomas Adam <thomas@xteddy.org>,
        Matthieu Moy <git@matthieu-moy.fr>
Subject: [PATCH v3 2/3] Remove now useless email-address parsing code
Date:   Mon,  8 Jan 2018 11:34:33 +0100
Message-Id: <1515407674-5233-2-git-send-email-git@matthieu-moy.fr>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1515407674-5233-1-git-send-email-git@matthieu-moy.fr>
References: <1515177413-12526-1-git-send-email-git@matthieu-moy.fr>
 <1515407674-5233-1-git-send-email-git@matthieu-moy.fr>
X-Originating-IP: 185.49.20.46
X-SpamExperts-Domain: zose1.web4all.fr
X-SpamExperts-Username: 185.49.20.46
Authentication-Results: yulpa.io; auth=pass smtp.auth=185.49.20.46@zose1.web4all.fr
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (7.69632806835e-05)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5jrx6DXotmGy6vb8yk9DAXHj1g3/PwYZaTCzSym8uE9HPImhfA8k5/zW
 UdbqUfA/+atZAIrjsCRyglG39ay7s40zkSakW8+kgCjGkeOx1qmz3ywmUacsjxjAsJqLMS98bJTN
 iqbXZIDkOGe2FHwUiJMpTgZqLYtJsbXv/ketFafwq+G25XHaa2KawFj0OiLrEH091rP1WLs/7NTd
 f/v9ilzOIBlCHgCawvkuWitWcipbboAfGuY98hZCOSppmWR0f+KVse1sVhWabI0/+PN3sIJgPotx
 C4d5mZiBkvWU8JOmlab7A14bDhsVpYYd7UZLwsivEsJmn1J3i12zQnpjnAkksRzltJtieFUSxnzh
 hYFeh4JLEtnm8ySEiLmvj502SX5iR5s2m8n9hOTmgdU9KKveLgRddK55nMwKlfa186oozmyhDRHa
 NLgbENzE8UYLv0ZqmBjctg3sraCMRH0q8y0f/ewgTZZHnomyLohxA2/JJ6lavGyCMxxrx/V1QkJh
 uHW2G/SF32BkaVUv9IQODMJ47049fv7DynTeLk68Ja5SY5R6BpcvGp3jcY/qUcseg7VRAzeOsvgA
 V5QompPxrkfi9hmPKuiBYMIBAmK2NFHJ2+mjZSBX08/Qa05JAIPdavvg7iEFLP+SSY+Av5+AiC6q
 57wRJX0TOTJHzvd3MM9RlAGcUzJGugIsdSHTBsSYj/aYhl5PbUSZkKp1vJeV4FmhSCf4BF/WdfYJ
 bQ6u3FdnP3h8izjtZsxkRYrv06jIw6W1C84udHc1IZJSv0wxMqxThRWXb/vjhFfnRGEw17v+HDXM
 PVMaQCIb+s/RO6mAGcwYghcXJyLED6jwQGBY36ohzfH4XhSDqdP/cnlEQ4kfqYy08y9qrcIh5f7x
 FiDniFFfEoXm0/FPF8PR0w363lm8oLPYy4YTN6Tnj/EjhZ8pvzjd0/KJo06KSY/Nuo+6Ze58MBvt
 Sp/30FBTc0LHHV5YbaWAq0BDJ73nbtNkWc/zst1ymB3m2xZYS6jH5McCr5LJM700aXzYJC4yKoPz
 E5+rg5zjXjFYo+QNnmYltQOnEF9dSV894wpXF4CTvMURvtge8Z7vJMrDsqwzXs0XHW3yvXuqcc8b
 2Rz+DKDRpNcP
X-Report-Abuse-To: spam@mut-mta1-se01a-fr.yulpa.io
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We now use Mail::Address unconditionaly, hence parse_mailboxes is now
dead code. Remove it and its tests.

Signed-off-by: Matthieu Moy <git@matthieu-moy.fr>
---
No change since v2.

 perl/Git.pm          | 71 ----------------------------------------------------
 t/t9000-addresses.sh | 27 --------------------
 t/t9000/test.pl      | 67 -------------------------------------------------
 3 files changed, 165 deletions(-)
 delete mode 100755 t/t9000-addresses.sh
 delete mode 100755 t/t9000/test.pl

diff --git a/perl/Git.pm b/perl/Git.pm
index ffa09ac..65e6b32 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -880,77 +880,6 @@ sub ident_person {
 	return "$ident[0] <$ident[1]>";
 }
 
-=item parse_mailboxes
-
-Return an array of mailboxes extracted from a string.
-
-=cut
-
-# Very close to Mail::Address's parser, but we still have minor
-# differences in some cases (see t9000 for examples).
-sub parse_mailboxes {
-	my $re_comment = qr/\((?:[^)]*)\)/;
-	my $re_quote = qr/"(?:[^\"\\]|\\.)*"/;
-	my $re_word = qr/(?:[^]["\s()<>:;@\\,.]|\\.)+/;
-
-	# divide the string in tokens of the above form
-	my $re_token = qr/(?:$re_quote|$re_word|$re_comment|\S)/;
-	my @tokens = map { $_ =~ /\s*($re_token)\s*/g } @_;
-	my $end_of_addr_seen = 0;
-
-	# add a delimiter to simplify treatment for the last mailbox
-	push @tokens, ",";
-
-	my (@addr_list, @phrase, @address, @comment, @buffer) = ();
-	foreach my $token (@tokens) {
-		if ($token =~ /^[,;]$/) {
-			# if buffer still contains undeterminated strings
-			# append it at the end of @address or @phrase
-			if ($end_of_addr_seen) {
-				push @phrase, @buffer;
-			} else {
-				push @address, @buffer;
-			}
-
-			my $str_phrase = join ' ', @phrase;
-			my $str_address = join '', @address;
-			my $str_comment = join ' ', @comment;
-
-			# quote are necessary if phrase contains
-			# special characters
-			if ($str_phrase =~ /[][()<>:;@\\,.\000-\037\177]/) {
-				$str_phrase =~ s/(^|[^\\])"/$1/g;
-				$str_phrase = qq["$str_phrase"];
-			}
-
-			# add "<>" around the address if necessary
-			if ($str_address ne "" && $str_phrase ne "") {
-				$str_address = qq[<$str_address>];
-			}
-
-			my $str_mailbox = "$str_phrase $str_address $str_comment";
-			$str_mailbox =~ s/^\s*|\s*$//g;
-			push @addr_list, $str_mailbox if ($str_mailbox);
-
-			@phrase = @address = @comment = @buffer = ();
-			$end_of_addr_seen = 0;
-		} elsif ($token =~ /^\(/) {
-			push @comment, $token;
-		} elsif ($token eq "<") {
-			push @phrase, (splice @address), (splice @buffer);
-		} elsif ($token eq ">") {
-			$end_of_addr_seen = 1;
-			push @address, (splice @buffer);
-		} elsif ($token eq "@" && !$end_of_addr_seen) {
-			push @address, (splice @buffer), "@";
-		} else {
-			push @buffer, $token;
-		}
-	}
-
-	return @addr_list;
-}
-
 =item hash_object ( TYPE, FILENAME )
 
 Compute the SHA1 object id of the given C<FILENAME> considering it is
diff --git a/t/t9000-addresses.sh b/t/t9000-addresses.sh
deleted file mode 100755
index a1ebef6..0000000
--- a/t/t9000-addresses.sh
+++ /dev/null
@@ -1,27 +0,0 @@
-#!/bin/sh
-
-test_description='compare address parsing with and without Mail::Address'
-. ./test-lib.sh
-
-if ! test_have_prereq PERL; then
-	skip_all='skipping perl interface tests, perl not available'
-	test_done
-fi
-
-perl -MTest::More -e 0 2>/dev/null || {
-	skip_all="Perl Test::More unavailable, skipping test"
-	test_done
-}
-
-perl -MMail::Address -e 0 2>/dev/null || {
-	skip_all="Perl Mail::Address unavailable, skipping test"
-	test_done
-}
-
-test_external_has_tap=1
-
-test_external_without_stderr \
-	'Perl address parsing function' \
-	perl "$TEST_DIRECTORY"/t9000/test.pl
-
-test_done
diff --git a/t/t9000/test.pl b/t/t9000/test.pl
deleted file mode 100755
index dfeaa9c..0000000
--- a/t/t9000/test.pl
+++ /dev/null
@@ -1,67 +0,0 @@
-#!/usr/bin/perl
-use lib (split(/:/, $ENV{GITPERLLIB}));
-
-use 5.008;
-use warnings;
-use strict;
-
-use Test::More qw(no_plan);
-use Mail::Address;
-
-BEGIN { use_ok('Git') }
-
-my @success_list = (q[Jane],
-	q[jdoe@example.com],
-	q[<jdoe@example.com>],
-	q[Jane <jdoe@example.com>],
-	q[Jane Doe <jdoe@example.com>],
-	q["Jane" <jdoe@example.com>],
-	q["Doe, Jane" <jdoe@example.com>],
-	q["Jane@:;\>.,()<Doe" <jdoe@example.com>],
-	q[Jane!#$%&'*+-/=?^_{|}~Doe' <jdoe@example.com>],
-	q["<jdoe@example.com>"],
-	q["Jane jdoe@example.com"],
-	q[Jane Doe <jdoe    @   example.com  >],
-	q[Jane       Doe <  jdoe@example.com  >],
-	q[Jane @ Doe @ Jane @ Doe],
-	q["Jane, 'Doe'" <jdoe@example.com>],
-	q['Doe, "Jane' <jdoe@example.com>],
-	q["Jane" "Do"e <jdoe@example.com>],
-	q["Jane' Doe" <jdoe@example.com>],
-	q["Jane Doe <jdoe@example.com>" <jdoe@example.com>],
-	q["Jane\" Doe" <jdoe@example.com>],
-	q[Doe, jane <jdoe@example.com>],
-	q["Jane Doe <jdoe@example.com>],
-	q['Jane 'Doe' <jdoe@example.com>],
-	q[Jane@:;\.,()<>Doe <jdoe@example.com>],
-	q[Jane <jdoe@example.com> Doe],
-	q[<jdoe@example.com> Jane Doe]);
-
-my @known_failure_list = (q[Jane\ Doe <jdoe@example.com>],
-	q["Doe, Ja"ne <jdoe@example.com>],
-	q["Doe, Katarina" Jane <jdoe@example.com>],
-	q[Jane jdoe@example.com],
-	q["Jane "Kat"a" ri"na" ",Doe" <jdoe@example.com>],
-	q[Jane Doe],
-	q[Jane "Doe <jdoe@example.com>"],
-	q[\"Jane Doe <jdoe@example.com>],
-	q[Jane\"\" Doe <jdoe@example.com>],
-	q['Jane "Katarina\" \' Doe' <jdoe@example.com>]);
-
-foreach my $str (@success_list) {
-	my @expected = map { $_->format } Mail::Address->parse("$str");
-	my @actual = Git::parse_mailboxes("$str");
-	is_deeply(\@expected, \@actual, qq[same output : $str]);
-}
-
-TODO: {
-	local $TODO = "known breakage";
-	foreach my $str (@known_failure_list) {
-		my @expected = map { $_->format } Mail::Address->parse("$str");
-		my @actual = Git::parse_mailboxes("$str");
-		is_deeply(\@expected, \@actual, qq[same output : $str]);
-	}
-}
-
-my $is_passing = eval { Test::More->is_passing };
-exit($is_passing ? 0 : 1) unless $@ =~ /Can't locate object method/;
-- 
2.7.4

