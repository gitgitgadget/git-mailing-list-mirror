Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A20392021E
	for <e@80x24.org>; Mon, 21 Nov 2016 05:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751352AbcKUFho (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Nov 2016 00:37:44 -0500
Received: from mout.web.de ([212.227.17.12]:59077 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750787AbcKUFhn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2016 00:37:43 -0500
Received: from [192.168.88.158] ([194.47.243.242]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LwYnz-1cpInK2BBv-018MWh; Mon, 21
 Nov 2016 06:37:33 +0100
Subject: Re: [PATCH] Remove dependency on deprecated Net::SMTP::SSL
To:     Mike Fisher <mfisher@csh.rit.edu>, git@vger.kernel.org
References: <451E4A46-BA43-41A5-9E68-DE0D89BE676A@csh.rit.edu>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <d5f21248-e70a-4adc-52c5-73fd00f62961@web.de>
Date:   Mon, 21 Nov 2016 06:37:28 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:45.0)
 Gecko/20100101 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <451E4A46-BA43-41A5-9E68-DE0D89BE676A@csh.rit.edu>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:tai4FVd2uboaoK80eYkYHOUxPM7jENMTtCHkrovdJqzTNFpuvBS
 qqboyL+m8dEcDFDqRROQuzPM4u69Hxj5qPd76YAQoY6UK5Z6PKAosMM8CPRtRf1zSPjyrG2
 guWlM8h9alWuUVNkAH47aI/8NkPEqSTQSV+kN01obG63RYYZCXujFgxz5hCo5TXO3o9GR49
 P9ixHUMZLCpULCVy4XZPw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:X0wb8wvRFwc=:FKqL+d3nglc+VyzS9gNTFz
 aAnjW4ZivJcUWadI/RrH20eHI09krX0kJYvRiyxV0IV8RBz5QsmoqTdtQG/vj9b6v4iqf+cvP
 8hoy2WSBilnhrJk2QCPXOVmQWImJF9m1AQqcUwSrNVvC+iOq2wp3s4RnRWYz8CqThUCELRnU8
 8zH1J+ILLI5PoqpCH4y7lYXj848PycNhrxtfmAd+WOFl9unZqi7y3eJFQCEq9/UnW9Mr+rzPx
 SCiHrnn8fysQvKzc60k4NUqxKGYRlJpxXNCaTaMkqOe9o7bW8e8xiczKQ5KWIZ1Qm3ZdobRr4
 6orqgLw0a5xg2bAt5dpHrz5hnVwXkmWbG02TZOgXvR6OageCafgds/gtcBnM/Hsl6vVVU0EQA
 AEqN9OwuXvfVy2Wp65N0axc9fHmoorZ+tspxXKGYufV5QL/tGACC3vfVUSJfJqLfcVJk52DDX
 bQWfb5stk6Y5mMLfpe88k1zMx9kN+dhNC+MmEZ1AM4jVNvtE79Qro7ofw3EfXb6hb82oygUwv
 QQgmz2q5WtJRdkPg77KvMSynhl6JGFdcThWLiyUYM/MmPRyiw+Mv97h/Op6+oqGJDTTsnWX13
 hffr371Syayy7dkJLv5JcMeBwRKdSeyvkaMC819gBUeMcvoL3mHuRkiJomJ76TZw1g8+RbRl1
 Zk5Y8Xq993nl+VAyitUcOG9Y2n0NVcxaqMNXSy9RyDdo//7RNZAfpAGxjkmahjweq8MMBY4pD
 qwFDO7wf3QuCEPTGHZukaLljBSrbvUtUsasL/Xc1p9OMFf1kPp7a6N8Pu7/cPrni3SCwuI4/X
 yl11t8g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



>On 20/11/16 22:18, Mike Fisher  wrote:

Thanks for contributing to Git.
One comment on the head line:
 >Refactor send_message() to remove dependency on deprecated
Net::SMTP::SSL
The word "refactor" may be used in other way: Re-structure the code,
and use the same API.


"Remove dependency on deprecated Net::SMTP::SSL"

> Refactor send_message() to remove dependency on deprecated
> Net::SMTP::SSL:
Is there a security risk with require Net::SMTP::SSL ?
If yes, the commit message should state this.
If no:
Even if it is deprecated, is it still in use somewhere ?
Does it hurt someone, is there any OS release where the old code doesn't work 
anymore ?
Or is it "only" nice to have ?
Since when does Net::SMTP include Net::SMTP::SSL ?
On which system has the change been tested ?

I think the commit message could and should give more information like this.

My comments may be over-critical.
Lets see if other people from the list know more than me.

>
> <http://search.cpan.org/~rjbs/Net-SMTP-SSL-1.04/lib/Net/SMTP/SSL.pm#DEPRECATED>
>
> Signed-off-by: Mike Fisher <mfisher@csh.rit.edu>
> ---
>  git-send-email.perl | 54 +++++++++++++++++++++++++----------------------------
>  1 file changed, 25 insertions(+), 29 deletions(-)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index da81be4..fc166c5 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1330,15 +1330,17 @@ Message-Id: $message_id
>          print $sm "$header\n$message";
>          close $sm or die $!;
>      } else {
> -
I can see one refactoring, that is the removal of an empty line.

>
>          if (!defined $smtp_server) {
>              die "The required SMTP server is not properly defined."
>          }
>
> +        require Net::SMTP;
> +        $smtp_domain ||= maildomain();
> +        my $smtp_ssl = 0;
> +
>          if ($smtp_encryption eq 'ssl') {
>              $smtp_server_port ||= 465; # ssmtp
> -            require Net::SMTP::SSL;
> -            $smtp_domain ||= maildomain();
> +            $smtp_ssl = 1;
>              require IO::Socket::SSL;
>
>              # Suppress "variable accessed once" warning.
> @@ -1347,37 +1349,31 @@ Message-Id: $message_id
>                  $IO::Socket::SSL::DEBUG = 1;
>              }
>
> -            # Net::SMTP::SSL->new() does not forward any SSL options
>              IO::Socket::SSL::set_client_defaults(
>                  ssl_verify_params());
> -            $smtp ||= Net::SMTP::SSL->new($smtp_server,
> -                              Hello => $smtp_domain,
> -                              Port => $smtp_server_port,
> -                              Debug => $debug_net_smtp);
>          }
>          else {
> -            require Net::SMTP;
> -            $smtp_domain ||= maildomain();
>              $smtp_server_port ||= 25;
> -            $smtp ||= Net::SMTP->new($smtp_server,
> -                         Hello => $smtp_domain,
> -                         Debug => $debug_net_smtp,
> -                         Port => $smtp_server_port);
> -            if ($smtp_encryption eq 'tls' && $smtp) {
> -                require Net::SMTP::SSL;
> -                $smtp->command('STARTTLS');
> -                $smtp->response();
> -                if ($smtp->code == 220) {
> -                    $smtp = Net::SMTP::SSL->start_SSL($smtp,
> -                                      ssl_verify_params())
> -                        or die "STARTTLS failed! ".IO::Socket::SSL::errstr();
> -                    $smtp_encryption = '';
> -                    # Send EHLO again to receive fresh
> -                    # supported commands
> -                    $smtp->hello($smtp_domain);
> -                } else {
> -                    die "Server does not support STARTTLS! ".$smtp->message;
> -                }
> +        }
> +
> +        $smtp ||= Net::SMTP->new($smtp_server,
> +                     Hello => $smtp_domain,
> +                     Port => $smtp_server_port,
> +                     Debug => $debug_net_smtp,
> +                     SSL => $smtp_ssl);
> +
> +        if ($smtp_encryption eq 'tls' && $smtp) {
> +            $smtp->command('STARTTLS');
> +            $smtp->response();
> +            if ($smtp->code == 220) {
> +                $smtp->starttls(ssl_verify_params())
> +                    or die "STARTTLS failed! ".IO::Socket::SSL::errstr();
> +                $smtp_encryption = '';
> +                # Send EHLO again to receive fresh
> +                # supported commands
> +                $smtp->hello($smtp_domain);
> +            } else {
> +                die "Server does not support STARTTLS! ".$smtp->message;
>              }
>          }
>

