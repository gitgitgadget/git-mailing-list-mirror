Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B65AE1F42B
	for <e@80x24.org>; Thu,  9 Nov 2017 08:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753699AbdKIIt6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Nov 2017 03:49:58 -0500
Received: from mail-yw0-f195.google.com ([209.85.161.195]:48690 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753691AbdKIIt5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Nov 2017 03:49:57 -0500
Received: by mail-yw0-f195.google.com with SMTP id q1so4671154ywh.5
        for <git@vger.kernel.org>; Thu, 09 Nov 2017 00:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=G6TKar9Wbe4LjtMsqw7xIhglqZdqCyKr+2WwYKTAC/g=;
        b=ROLtHSmAAV/6JxksxkZRehXXy+1Uv3wimbB40d1maTExZYF/gldp9lLZzSMZbbMExY
         /cMQzdWo+q+UN4ZZcReQ/B3SR3pzSKa3mXDJ8Hzferi+6bVTQD+Jau5bOBABaGulg2tv
         wK0BeQzxhJqqnKJfEXCED06F3Kjm+jZVWhWKCw1q9rUX5yQ2nwFLfsYYeohlsK+Emg9O
         U1fB7Xbf2QwBTXHQk+BRh6SiJaMFu7MwKUOZ19dxw4N1EznY9IoNkHb0MVqMNEBrPv1+
         zo8hL4MnnODN5Yj28ELvsNaqBvgCt9uc9lDUS1855FzjYz20xNL9PC9wkMhCXPKUq09c
         xwmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=G6TKar9Wbe4LjtMsqw7xIhglqZdqCyKr+2WwYKTAC/g=;
        b=oEItepanOy+jcxcfXnU5UOyxAh9sftGycgdWRTu/rUjXCahMJY1kmVokXy6DTZbSG7
         4YLaHXqEpjp0FM+xQPXmTM64RQcyd+SkGSpZYYRJ/V0kpSjMgT/VsK34ldZQiiHqR7us
         jkHdTXzx0l0AwR2N9UitXlCmEkXWLwt7RkejJm1M0XOqwtNipOEb8MBEA7QZ95Dln4bj
         EEyzSYZCNtD0vr9AKUc2vUUTuVl0bbA3++9PEWTQgKfx/SIL0MphmY/Nyb2Ggxp3eU8v
         eZmZtcj95fSwkT0SFIrjxk8NymaIPsgvXuOREkNwC0+c/MBI/LYPz/TxFbThUyQmADGD
         a5HA==
X-Gm-Message-State: AJaThX6jj8XkmTMNQCLNbY8S9EhkJaukvMljdm1veWsRn/KpRzB6Edi/
        G+/AGvIOEfR99Od+9AaUiRl7gxrboxaW22qhv079Tw==
X-Google-Smtp-Source: ABhQp+Q42TynWfuuYe9jpQlKYmRm2qzG1zjd1Uh+8OBbBh1QgcJ76peeR7a2F0wtWRWOc5y2POGWcSgSyDQosSL0cz0=
X-Received: by 10.37.175.145 with SMTP id g17mr1966094ybh.22.1510217396318;
 Thu, 09 Nov 2017 00:49:56 -0800 (PST)
MIME-Version: 1.0
Received: by 10.129.197.6 with HTTP; Thu, 9 Nov 2017 00:49:55 -0800 (PST)
In-Reply-To: <xmqqk1zawwd3.fsf@gitster.mtv.corp.google.com>
References: <20171030223444.5052-1-nathan.payre@etu.univ-lyon1.fr>
 <20171030223444.5052-2-nathan.payre@etu.univ-lyon1.fr> <xmqqk1zawwd3.fsf@gitster.mtv.corp.google.com>
From:   Nathan PAYRE <second.payre@gmail.com>
Date:   Thu, 9 Nov 2017 09:49:55 +0100
Message-ID: <CAGb4CBVjjh7VgY0OQJJOjU9Q2+eCH9Z3wkLBV_JhcaSpCHpLag@mail.gmail.com>
Subject: Re: [PATCH 1/2] quote-email populates the fields
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        MOY Matthieu <matthieu.moy@univ-lyon1.fr>,
        Timothee Albertin <timothee.albertin@etu.univ-lyon1.fr>,
        Daniel Bensoussan <daniel.bensoussan--bohm@etu.univ-lyon1.fr>,
        Tom Russello <tom.russello@grenoble-inp.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I Will send the modification in the next patch, I prefer to refractor
a part of the code before.

>> diff --git a/git-send-email.perl b/git-send-email.perl
>> index 2208dcc21..665c47d15 100755
>> --- a/git-send-email.perl
>> +++ b/git-send-email.perl
>> @@ -57,6 +57,7 @@ git send-email --dump-aliases
>>      --[no-]bcc              <str>  * Email Bcc:
>>      --subject               <str>  * Email "Subject:"
>>      --in-reply-to           <str>  * Email "In-Reply-To:"
>> +    --quote-email           <file> * Populate header fields appropriately.

> Likewise.  If what's "appropriate" is clear to the readers, the word
> in this description adds no value because everybody would know how
> fields are populated.  Otherwise, it does not add any value because
> everybody would have no clue how fields are populated.

Remove "approprietly" done.


>> @@ -652,6 +654,70 @@ if (@files) {
>>       usage();
>>  }
>>
>> +if ($quote_email) {
>> +     my $error = validate_patch($quote_email);
>> +     die "fatal: $quote_email: $error\nwarning: no patches were sent\n"
>> +             if $error;

> validate_patch() calls sendemail-validate hook that is expecting to
> be fed a patch email you are going to send out that might have
> errors so that it can catch it and save you from embarrassment.  The
> file you are feeding it is *NOT* what you are going to send out, but
> is what you are responding to with your patch.  Even if it had an
> embarassing error as a patch, that is not something you care about
> (and it is something you received, so catching this late won't save
>  the sender from embarrassment anyway).

I will remove lines which use validate_patch().


>> +                     chomp($header[$#header]);
>> +                     s/^\s+/ /;
>> +                     $header[$#header] .= $_;
>> +             } else {
>> +                     push(@header, $_);
>> +             }
>> +     }

> You do not use $fh after this point.  Do not force readers to
> realize that fact by scanning to the end of the function--instead,
> close it here.

In fact $fh is reuse at the end of the if($quote_email) {} but if you
don't see it maybe it's because it's anormal to reuse it after a
long block of code, that's why I think to create a subroutine
for the following code which is similar to the part of if($compose).

foreach (@header) {
   my $initial_sender = $sender || $repoauthor || $repocommitter || '';

   chomp;

   if (/^Subject:\s+(.*)$/i) {
      my $prefix_re = "";
      my $subject_re = $1;
      if ($1 =~ /^[^Re:]/) {
         $prefix_re = "Re: ";
      }
      $initial_subject = $prefix_re . $subject_re;
   } elsif (/^From:\s+(.*)$/i) {
      $recipient = $1;
      push @initial_to, $recipient;
   } elsif (/^To:\s+(.*)$/i) {
      foreach my $addr (parse_address_line($1)) {
         if (!($addr eq $initial_sender)) {
            push @initial_cc, $addr;
         }
      }
   } elsif (/^Cc:\s+(.*)$/i) {
      foreach my $addr (parse_address_line($1)) {
         my $qaddr = unquote_rfc2047($addr);
         my $saddr = sanitize_address($qaddr);
         if ($saddr eq $initial_sender) {
            next if ($suppress_cc{'self'});
         } else {
            next if ($suppress_cc{'cc'});
         }
         push @initial_cc, $addr;
      }
   } elsif (/^Message-Id: (.*)/i) {
      $initial_reply_to = $1;
   } elsif (/^References:\s+(.*)/i) {
      $initial_references = $1;
   } elsif (/^Date: (.*)/i) {
   $date = $1;
   }
}


I close $fh after the second call then.


>> +     # Parse the header
>> +     foreach (@header) {
>> +             my $initial_sender = $sender || $repoauthor || $repocommitter || '';
>> +
>> +             chomp;
>> +
>> +             if (/^Subject:\s+(.*)$/i) {
>> +                     my $prefix_re = "";
>> +                     my $subject_re = $1;

> What does "_re" mean in the variable name $subject_re?

"_re" mean regular expression but maybe it's clumsy because
it contain the result of a regular expression. What do you think
about rename it into "$prefix" and "$subject" ?


2017-11-01 3:44 GMT+01:00 Junio C Hamano <gitster@pobox.com>:
> Payre Nathan <second.payre@gmail.com> writes:
>
>> From: Tom Russello <tom.russello@grenoble-inp.org>
>>
>> ---
>
> Missing something here???
>
>>  Documentation/git-send-email.txt |   3 +
>>  git-send-email.perl              |  70 ++++++++++++++++++++++-
>>  t/t9001-send-email.sh            | 117 +++++++++++++++++++++++++--------------
>>  3 files changed, 147 insertions(+), 43 deletions(-)
>>
>> diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
>> index bac9014ac..710b5ff32 100644
>> --- a/Documentation/git-send-email.txt
>> +++ b/Documentation/git-send-email.txt
>> @@ -106,6 +106,9 @@ illustration below where `[PATCH v2 0/3]` is in reply to `[PATCH 0/2]`:
>>  Only necessary if --compose is also set.  If --compose
>>  is not set, this will be prompted for.
>>
>> +--quote-email=<email_file>::
>> +     Fill appropriately header fields for the reply to the given email.
>> +
>
> The cover letter said:
>
>     This patch allows send-email to do most of the job for the user, who can
>     now save the email to a file and use:
>
>       git send-email --quote-email=<file>
>
>     "To" and "Cc" will be added automaticaly and the email quoted.
>     It's possible to edit the email before sending with --compose.
>
> and I somehow expected to see the body of the e-mail this option is
> "quoting" to be also inserted in the text.  After all, that is what
> "quote" means.
>
> But the description above (and the code below, judging from the way
> the reading from $fh that was opened form $quote_email stops at the
> first blank line, aka end of header) says what is happening is quite
> different.  The contents of the file is used to extract what the
> user would have given to --cc/--to/--in-reply-to from the command
> line by looking at it, if this option were not available.
>
> I personally prefer the "pick up the header information so that the
> user do not have to formulate the command line options" behaviour
> that does *NOT* quote the body of the message into the outgoing
> message.  So:
>
>  * Do not call this option "quote" anything; you are not quoting,
>    just using some info from the given file.
>
>    I wonder if we can simply reuse "--in-reply-to" option for this
>    purpose.  If it is a message id and not a file on the filesystem,
>    we behave just as before.  Otherwise we try to open it as a file
>    and grab the "Message-ID:" header from it and use it.
>
>  * The description "Fill *appropriately* header fileds" is useless,
>    as what looks "appropriate" to you is not clear/known to
>    readers.  Instead, say what header is filled with what
>    information (e.g. "find Message-Id: and place its value on
>    In-Reply-To: header").
>
>    For that matter, "To and CC will be added automatically" in the
>    coer letter is still vague; are you reading To/CC in the given
>    file and placing their values on some (unnamed) header of the
>    outgoing message?  Or are you reading some (unnamed) header in
>    the given file and placing their values on To/CC header of the
>    outging message?
>
>> diff --git a/git-send-email.perl b/git-send-email.perl
>> index 2208dcc21..665c47d15 100755
>> --- a/git-send-email.perl
>> +++ b/git-send-email.perl
>> @@ -57,6 +57,7 @@ git send-email --dump-aliases
>>      --[no-]bcc              <str>  * Email Bcc:
>>      --subject               <str>  * Email "Subject:"
>>      --in-reply-to           <str>  * Email "In-Reply-To:"
>> +    --quote-email           <file> * Populate header fields appropriately.
>
> Likewise.  If what's "appropriate" is clear to the readers, the word
> in this description adds no value because everybody would know how
> fields are populated.  Otherwise, it does not add any value because
> everybody would have no clue how fields are populated.
>
>> @@ -652,6 +654,70 @@ if (@files) {
>>       usage();
>>  }
>>
>> +if ($quote_email) {
>> +     my $error = validate_patch($quote_email);
>> +     die "fatal: $quote_email: $error\nwarning: no patches were sent\n"
>> +             if $error;
>
> validate_patch() calls sendemail-validate hook that is expecting to
> be fed a patch email you are going to send out that might have
> errors so that it can catch it and save you from embarrassment.  The
> file you are feeding it is *NOT* what you are going to send out, but
> is what you are responding to with your patch.  Even if it had an
> embarassing error as a patch, that is not something you care about
> (and it is something you received, so catching this late won't save
> the sender from embarrassment anyway).
>
>> +
>> +     my @header = ();
>> +
>> +     open my $fh, "<", $quote_email or die "can't open file $quote_email";
>> +
>> +     # Get the email header
>> +     while (<$fh>) {
>> +             # Turn crlf line endings into lf-only
>> +             s/\r//g;
>> +             last if /^\s*$/;
>> +             if (/^\s+\S/ and @header) {
>
> I wonder how significant this requirement to have at least one "\S"
> on the line is.  I know you copied&pasted this from the main sending
> loop, so this is not a new issue and not something we may want to
> fix in this patch.
>
>> +                     chomp($header[$#header]);
>> +                     s/^\s+/ /;
>> +                     $header[$#header] .= $_;
>> +             } else {
>> +                     push(@header, $_);
>> +             }
>> +     }
>
> You do not use $fh after this point.  Do not force readers to
> realize that fact by scanning to the end of the function--instead,
> close it here.
>
>> +     # Parse the header
>> +     foreach (@header) {
>> +             my $initial_sender = $sender || $repoauthor || $repocommitter || '';
>> +
>> +             chomp;
>> +
>> +             if (/^Subject:\s+(.*)$/i) {
>> +                     my $prefix_re = "";
>> +                     my $subject_re = $1;
>
> What does "_re" mean in the variable name $subject_re?
>
>> +                     if ($1 =~ /^[^Re:]/) {
>> +                             $prefix_re = "Re: ";
>> +                     }
>> +                     $initial_subject = $prefix_re . $subject_re;
>> +             } elsif (/^From:\s+(.*)$/i) {
>> +                     push @initial_to, $1;
>> +             } elsif (/^To:\s+(.*)$/i) {
>> +                     foreach my $addr (parse_address_line($1)) {
>> +                             if (!($addr eq $initial_sender)) {
>
> This if() condition makes a policy decision; shouldn't it honor the
> setting of "--[no-]suppress-from", "--suppress-cc" and friends?
>
>> +                                     push @initial_cc, $addr;
>> +                             }
>> +                     }
>> +             } elsif (/^Cc:\s+(.*)$/i) {
>> +                     foreach my $addr (parse_address_line($1)) {
>> +                             my $qaddr = unquote_rfc2047($addr);
>> +                             my $saddr = sanitize_address($qaddr);
>> +                             if ($saddr eq $initial_sender) {
>> +                                     next if ($suppress_cc{'self'});
>> +                             } else {
>> +                                     next if ($suppress_cc{'cc'});
>> +                             }
>> +                             push @initial_cc, $addr;
>> +                     }
>> +             } elsif (/^Message-Id: (.*)/i) {
>> +                     $initial_reply_to = $1;
>> +             } elsif (/^References:\s+(.*)/i) {
>> +                     $initial_references = $1;
>> +             }
>> +     }
>> +     $initial_references = $initial_references . $initial_reply_to;
>
> I cannot see how this can produce correct result by simply
> concatenating them with nothing in between.  Shouldn't you make sure
> there is a SP in between, at least?
>
> By the way, if you are adding a new variable $initial_references,
> make sure it is initialized to either an empty string or an undef
> (and if you choose to do the latter, the right hand side of this
> assignment cannot blindly reference $initial_references that could
> still be undef); the way the existing code handles $initial_reply_to
> may serve as an example.
