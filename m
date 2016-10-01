Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,URIBL_PH_SURBL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53B5420986
	for <e@80x24.org>; Sat,  1 Oct 2016 16:50:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750940AbcJAQta (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Oct 2016 12:49:30 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34534 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750820AbcJAQt2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Oct 2016 12:49:28 -0400
Received: by mail-wm0-f65.google.com with SMTP id b201so2670814wmb.1
        for <git@vger.kernel.org>; Sat, 01 Oct 2016 09:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=OTXWkZF8dHPJzX20GrPB4NUrITboFTdUUoZEwLeqOUg=;
        b=e7zrOw7vQf7WIApwkZKb3Nj1oCksDhuvbwrJPFIbU5R9FjsLQRWkGPQp0dEbNnMr72
         r4bLIHtVE8x5EGvsZukrkCEapw96JY4aDEMeFgSFpjw0tK1tm6AFoc26VuHHSAXw2PEw
         mdNtWIK0VnFiqlx6e42nLccx+BxRyZLqRrSBh+OlXq/nipNhQqtZZj0dqYYabIsDnzKX
         Satib7yYh7+TQQbls6BlkSP2UUhGsKoBYpjtnDpJiRkcaZ233DCX3lOhtocjaGWoBk4w
         Qn1DxckXXN63jhdzfhkb5MtjeOY85zep8xEXhI7dc259ZmDDgCKCzIwA75YTnYeyb9OU
         sfVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=OTXWkZF8dHPJzX20GrPB4NUrITboFTdUUoZEwLeqOUg=;
        b=jBvqrXQDshW8GrQH4/yYwVh50bYzcvb8b9ZBkLM6bQy0Q4qda/LWN1g6hGuiYkalrF
         vrkn3/yYIZ3/8U2HM9uYJw2gAt/XRnfN86XO99qzkeMl5GOVla1qrbhtlUm52M6f0OH/
         1I0fVOe2dbqOKXSGNcLRw+JlrW4VfnK307Ca2tFHXnGRqUDv+mGTknjlGyLs/Ha4e9NP
         c96sUrVj0yiJkJQylEAHPuPyd0xmHIXhR0L383Z/BCs27tOky4f99U2WwAzhaLhGq/fu
         bNqCzFm0EZ5qi2IXcApMcnEYMsRNJ36LmkGwZR0AUXN62/VKadgUUyoTX1/FGSqnsYBa
         ngLw==
X-Gm-Message-State: AA6/9RlmfNExe5VFEOIYVlm3ZLl4ZousSLm8IcnmCEj954ofOlNKIR4XllmqjibUgFxxtQ==
X-Received: by 10.194.250.106 with SMTP id zb10mr10320057wjc.99.1475340566827;
        Sat, 01 Oct 2016 09:49:26 -0700 (PDT)
Received: from [192.168.1.26] (abrc125.neoplus.adsl.tpnet.pl. [83.8.96.125])
        by smtp.googlemail.com with ESMTPSA id r1sm3076205wjc.43.2016.10.01.09.49.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Oct 2016 09:49:25 -0700 (PDT)
Subject: Re: [PATCH v2 04/11] i18n: add--interactive: mark plural strings
To:     Vasco Almeida <vascomalmeida@sapo.pt>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <1472646690-9699-1-git-send-email-vascomalmeida@sapo.pt>
 <1472646690-9699-5-git-send-email-vascomalmeida@sapo.pt>
 <1474913721.1035.9.camel@sapo.pt>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        David Aguilar <davvid@gmail.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <a46dc5cb-85d9-88f2-865c-734204832101@gmail.com>
Date:   Sat, 1 Oct 2016 18:49:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <1474913721.1035.9.camel@sapo.pt>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 26.09.2016 o 20:15, Vasco Almeida pisze:
> A Qua, 31-08-2016 às 12:31 +0000, Vasco Almeida escreveu:
>>
>> Mark plural strings for translation.  Unfold each action case in one
>> entire sentence.
>>
>> Pass new keyword for xgettext to extract.
>>
>> Update test to include new subrotine Q__() for plural strings handling.

Why use Q__() as the name of the subroutine? [looks further]. Oh, I see
that you are following the example of C shortcut functions (_, Q_ and N_).

But this is Perl, not C.  The standard shortcut functions are those
defined in Locale::TextDomain, even if we can't use this module directly.
Those that deal with plural strings handling are __n and __nx / __xn.

The Perl equivalent of Q_ shorthand function in C, C++, etc. is __n.
There is also a function __nx for combining handling plural strings
together with variable interpolation.

  __n MSGID, MSGID_PLURAL, COUNT
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

  That is the reason for the existance of the function ngettext(),
  that __n() is a short-cut for:

    print __n"One file has been deleted.\n", 
             "All files have been deleted.\n",
             $files_deleted;

  Alternatively:

    print __n ("One file has been deleted.\n",
               "All files have been deleted.\n",
               $files_deleted);


  __nx MSGID, MSGID_PLURAL, COUNT, VAR1 => VAL1, VAR2 => VAL2, ...
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

  Bringing it all together:

    print __nx ("One file has been deleted.\n",
                "{count} files have been deleted.\n",
                $num_files,
                count => $num_files);

  The function __nx() [and its alias __xn()] picks the correct plural
  form (also for English!) and it is capable of interpolating variables
  into strings.


>>
>> Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
>> ---
>>  Makefile                  |  3 ++-
>>  git-add--interactive.perl | 24 ++++++++++++++++--------
>>  perl/Git/I18N.pm          |  4 +++-
>>  t/t0202/test.pl           | 11 ++++++++++-
>>  4 files changed, 31 insertions(+), 11 deletions(-)

>> diff --git a/Makefile b/Makefile
>> index de5a030..eedf1fa 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -2061,7 +2061,8 @@ XGETTEXT_FLAGS_C = $(XGETTEXT_FLAGS) --language=C \
>>  	--keyword=_ --keyword=N_ --keyword="Q_:1,2"
>>  XGETTEXT_FLAGS_SH = $(XGETTEXT_FLAGS) --language=Shell \
>>  	--keyword=gettextln --keyword=eval_gettextln
>> -XGETTEXT_FLAGS_PERL = $(XGETTEXT_FLAGS) --keyword=__ --language=Perl
>> +XGETTEXT_FLAGS_PERL = $(XGETTEXT_FLAGS) --language=Perl \
>> +	--keyword=__ --keyword="Q__:1,2"

So this would be

   +XGETTEXT_FLAGS_PERL = $(XGETTEXT_FLAGS) --language=Perl \
   +	--keyword=__ --keyword=__x --keyword=__n:1,2 --keyword=__nx:1,2

(assuming that __x was used for interpolation)
 
>>  LOCALIZED_C = $(C_OBJ:o=c) $(LIB_H) $(GENERATED_H)
>>  LOCALIZED_SH = $(SCRIPT_SH) git-parse-remote.sh
>>  LOCALIZED_PERL = $(SCRIPT_PERL)
[...]

>> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
>> index 4e1e857..08badfa 100755
>> --- a/git-add--interactive.perl
>> +++ b/git-add--interactive.perl
>> @@ -666,12 +666,18 @@ sub status_cmd {
>>  sub say_n_paths {
>>  	my $did = shift @_;
>>  	my $cnt = scalar @_;
>> -	print "$did ";
>> -	if (1 < $cnt) {
>> -		print "$cnt paths\n";
>> -	}
>> -	else {
>> -		print "one path\n";
>> +	if ($did eq 'added') {
>> +		printf(Q__("added one path\n", "added %d paths\n",
>> +			   $cnt), $cnt);
>> +	} elsif ($did eq 'updated') {
>> +		printf(Q__("updated one path\n", "updated %d paths\n",
>> +			   $cnt), $cnt);
>> +	} elsif ($did eq 'reverted') {
>> +		printf(Q__("reverted one path\n", "reverted %d paths\n",
>> +			   $cnt), $cnt);
>> +	} else {
>> +		printf(Q__("touched one path\n", "touched %d paths\n",
>> +			   $cnt), $cnt);
>>  	}
>>  }

One one hand side, it is recommended to avoid lego-like construction
of sentences.

  Translatable strings should be entire sentences. It is often not
  possible to translate single verbs or adjectives in a substitutable
  way.

I think however that the action part ($did in original non-i18n code)
is whole part in any language, so something like the following would
be enough:

  	# this hash is as much for validation, as for translation
   	my %actions = map { $_ => 1 } (N__"added", N__"updated", N__"reverted");
   	if (exists $actions{$did}) {
   		print __nx("{did} one path\n", "{did} {count} paths\n", $cnt,
   			   did => __($did), count => $cnt);
  	} else {
   		print __nx("touched one path\n", "touched {count} paths\n", $cnt,
   			   count => $cnt);
   	}

Please correct me if I am wrong, and you know language where
"added %d paths", "updated %d paths", "reverted %d paths" etc. must have
different word order.

> When $cnt is 1 I get the following warning:
> Redundant argument in printf at .../libexec/git-core/git-add--interactive line 680.

I wonder what is the case of C code - is similar warning here, or is
gettext smarter in that case...

> The singular form does not have a %d to consume $cnt argument to
> printf(). Either we find a way to suppress that warning or we change
> the singular form to contain %d.

Anyway, with __nx there should be no such problem.

> 
>> @@ -1508,8 +1514,10 @@ sub patch_update_file {
>> ...
>> -					print colored $header_color, "Split into ",
>> -					scalar(@split), " hunks.\n";
>> +					print colored $header_color, sprintf(
>> +						Q__("Split into %d hunk.\n",
>> +						    "Split into %d hunks.\n",
>> +						    scalar(@split)), scalar(@split));
>
> Like we do with this.

Note that it is a bit of change in behavior: previously Git would
say "Split into 0 hunks.\n".


Though this is probably more work that you wanted to do.  The __n would
take place of Q__, while the __nx function might be defined like this
(borrowing from Locale::TextDomain), which needs to be put into Git::I18N:

# Plural with interpolation.
sub __nx ($$$@)
{
    my ($msgid, $msgid_plural, $count, %args) = @_;
    
    return __expand ((__n $msgid, $msgid_plural, $count),
		     %args);
}

Best regards,
-- 
Jakub Narębski

