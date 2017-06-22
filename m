Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16F2E20401
	for <e@80x24.org>; Thu, 22 Jun 2017 03:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752288AbdFVDN1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 23:13:27 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:33244 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751988AbdFVDN0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 23:13:26 -0400
Received: by mail-pf0-f181.google.com with SMTP id e7so2507266pfk.0
        for <git@vger.kernel.org>; Wed, 21 Jun 2017 20:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :disposition-notification-to:mime-version:content-transfer-encoding;
        bh=zzICzvW1UAAg+CDGMICO7M5poLmzf1LUQnbGsbXNlko=;
        b=gluimbBEUpMjIej7cex67c0lRnk/FvPSQi/hAMeE08HOEHyUHjPBVQqPO5/ZHMJtP2
         Kkv7K7IK/oLcTNXJfyiw3PKjlzHCRGacykk71PeQV8i1CQyIoCXiyBoRhvHtI41HI9Jt
         MLB84sJfsQ5mA7hNtv7/W2Wxinba81wwIfPf3k3RzB4fpuanidYpYvjFDdgHsfoTytWN
         kSdiQhnuqLx10HlM2n3zQ+uaG6N0jmt4IziTq6JKnSe//df/wT2H5rrziHX59uB1BWPv
         28IyIaPTg/F5pnzao4Bo44On1d8DrAbyaj7dfo3sgqXs50OL4ewEJdaVQ332AG6D06R3
         LWyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:disposition-notification-to:mime-version
         :content-transfer-encoding;
        bh=zzICzvW1UAAg+CDGMICO7M5poLmzf1LUQnbGsbXNlko=;
        b=ul3shp6OiABJ/RfBV8TUfoDanwJWqjaAW87jxUsRpe0rE21xTlu3ozH1A/7VCEYOeM
         j9yOlkf++tU7vpvTFQt/toEDC0q2JFLTtuGasxtiQ4iTPO0pEDGJ/VcQaHNMNmzOmpVV
         ZIIQIxvpjEU0Sga5N9Q8KScvl9ykcwwXgv86irpRd+6r/DdDlTLmcG0TbaGK6JvrwZoh
         aonuI5x5fdh5m0CPjNkMGDOZMtQ+FWi8/Vl4tJSkmr/fozDqSdOQ0ZfzffS1lHfPcumb
         W0hw/zSOwdfHQNAvVkEWPTT5w+BVUipvu5QGO1RINgQs5rIvihLfrxMr+4NCosPAKy3j
         JFnw==
X-Gm-Message-State: AKS2vOwrULlpZDEIhfmIHWRAhGQLnc2LsgOYoHQwxjWitqDXzI8GRHVW
        Btwhi1EcDmid4Gjl1Lk=
X-Received: by 10.84.128.33 with SMTP id 30mr508821pla.38.1498101205391;
        Wed, 21 Jun 2017 20:13:25 -0700 (PDT)
Received: from unique-pc ([182.73.79.179])
        by smtp.googlemail.com with ESMTPSA id f10sm333470pfd.69.2017.06.21.20.13.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 21 Jun 2017 20:13:24 -0700 (PDT)
Message-ID: <1498101195.1687.4.camel@gmail.com>
Subject: Re: Small issue with "add untracked" option of 'git add -i'
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Date:   Thu, 22 Jun 2017 08:43:15 +0530
In-Reply-To: <xmqqshj5nl3o.fsf@gitster.mtv.corp.google.com>
References: <1497278015.7302.13.camel@gmail.com>
         <xmqqwp8hnm1v.fsf@gitster.mtv.corp.google.com>
         <xmqqshj5nl3o.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, 2017-06-12 at 10:59 -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > After prompting to get the list of desired files, if the user chose
> > nothing, the message is shown.  "No untracked files chosen." is
> > probably what the code wants to say, I would think.
> 
> 
> Together with your other wishes, perhaps something like this is what
> you have in mind.  The original tried to throw in a blank line as a
> separator to help interactive users to more easily tell the boundary
> of blocks of text, but it wasn't consistently doing so (e.g. "update"
> when nothing is dirty was very silent, while "status" gave one blank
> line that is supposed to be shown after the list of changed ones even
> when the list is empty).
> 
>  git-add--interactive.perl | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> index 709a5f6ce6..0ec09361b4 100755
> --- a/git-add--interactive.perl
> +++ b/git-add--interactive.perl
> @@ -537,7 +537,7 @@ sub list_and_choose {
>  				$last_lf = 1;
>  			}
>  		}
> -		if (!$last_lf) {
> +		if (@stuff && !$last_lf) {
>  			print "\n";
>  		}
>  
> @@ -634,7 +634,6 @@ sub prompt_help_cmd {
>  sub status_cmd {
>  	list_and_choose({ LIST_ONLY => 1, HEADER => $status_head },
>  			list_modified());
> -	print "\n";
>  }
>  
>  sub say_n_paths {
> @@ -667,7 +666,6 @@ sub update_cmd {
>  		       map { $_->{VALUE} } @update);
>  		say_n_paths('updated', @update);
>  	}
> -	print "\n";
>  }
>  
>  sub revert_cmd {
> @@ -701,7 +699,6 @@ sub revert_cmd {
>  		refresh();
>  		say_n_paths('reverted', @update);
>  	}
> -	print "\n";
>  }
>  
>  sub add_untracked_cmd {
> @@ -711,9 +708,8 @@ sub add_untracked_cmd {
>  		system(qw(git update-index --add --), @add);
>  		say_n_paths('added', @add);
>  	} else {
> -		print __("No untracked files.\n");
> +		print __("No untracked file chosen.\n");
I guess I should take take back the following statement from my
previous thread,

> That does seem to be a more apt message to be shown. It's
> unambiguous.

The ambiguity persists. It seems that 'Add untracked' is not
differentiating between 'absence of untracked files' and 'not selecting
any untracked files' currently. It seems to be the root cause of the
ambiguity.

As a result the new message "No untracked file chosen." seems absurd
when user tries to choose the '4: add untracked' option in 'git add -i'
and there are no untracked files in his repository.

    $ git add -i

    *** Commands ***
      1: status    	      2: update    	      3: revert    	      4: add untracked
      5: patch    	      6: diff    	      7: quit    	      8: help
    What now> 4
    No untracked file chosen.


>  	}
> -	print "\n";
>  }
>  
>  sub run_git_apply {

