Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9E061F453
	for <e@80x24.org>; Tue, 29 Jan 2019 09:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfA2Jqh (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 04:46:37 -0500
Received: from mout.gmx.net ([212.227.15.15]:43047 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726456AbfA2Jqh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 04:46:37 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M2ts6-1h7sXG1m8U-00shkv; Tue, 29
 Jan 2019 10:46:32 +0100
Date:   Tue, 29 Jan 2019 10:46:13 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Alban Gruin <alban.gruin@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/4] built-in rebase: call `git am` directly
In-Reply-To: <dc6830ab-d31c-fb9b-4f8d-24a79a978764@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1901291033180.41@tvgsbejvaqbjf.bet>
References: <pull.24.git.gitgitgadget@gmail.com> <pull.24.v2.git.gitgitgadget@gmail.com> <3c4031868204862ea4e2a53a03cd8d7ec066a891.1547824162.git.gitgitgadget@gmail.com> <dc6830ab-d31c-fb9b-4f8d-24a79a978764@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1027158103-1548755192=:41"
X-Provags-ID: V03:K1:rzhUg8T7+qfKIgpvtIP7GB0yqh3KV1UYfkIkcXwcjgNnUK99696
 vB84XA5NHZwCrInPJlRriMR22MJ10cWG62M7iC6V2Mz1juhF/dLfdmsxxgegGMYz5WtdIwk
 dVL49Vtx4vG0yCfTAQ3roHfWJunIK79e4RxWMAYTMLM5YUsAU9dhQR9/0aEhTOLRGOJtKlZ
 WiohwQbKTaD9ear6CRzJA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Cz/AGbC+zpU=:SDT4J5InFJomY/mYrt7XX0
 NDigc9Q9deZwvmh9dgGRbwnbrvmbJYO4d1RCh/dFsE5mA8ynB8wCzFsWk7LyrpCcIrlKf02pa
 hXATX+hfI/fr2wAxHrJdiWYSrTmiPoT9z3xwyOdddbm+UsWA7OEM2BMZNXoe8xJIPZ5UmEurX
 8BJ7lPjXVCmI6Bd3ZVhr0hciZxKRgds8hvW7FIEhbXb1j7ElId8Zl0ZXo+8lEpytzZ2zCAY+e
 Sceh0OzkSBTUigDTEjAZPLCVEg3l75DCNw6L0H1zAPbpSrzvT4tXcjYQJWQ+lHJadI9cDXCYy
 x9xwYkqWlnvknnZZkaQbwy7iDXh4bgtfdc2PXP6rIEozIde3blqMPJ3JWs7mVDRrNtjADy8MK
 Ivv1JpQXEt2JY6CIQdddQq4XRpOf+g7KpeZf6riZ8LjDpLpFIpj/TWWF7vruZvQWulNLVKfII
 Md6bVhNL5YPz3IdeFxjvS+OuRn5LzNDxWnFbdgELRWzA08KB2yZM2tKE06Oud48mvntRuC0n/
 5rv4kn7ndM+Ec/aap00IbD0Cx0Lg3GB2fnogHcCCHumfeeyEuy9IjQTvLIQNcmV2sXV+OkZUe
 r1houECZ5xhh63XXrVkHrcsu1Te7b+m9ZreORa2+AW+ArfnHaOaNd9KHHCAXyP+wYOpXKdPX8
 SP0oU5lrMjKG2C7qfaEaaTuRxHtINAEl6kQ0X7BQ4QW4CH7Gf9zff3k+Tsiw3LJHzg3wdeu7l
 GldvTevv+2WgPlWuY/6wETZQkWJqPdEhTfA2UbCl2HCgC4dsA2+fUhw6lDo0GUjLrjlfRS20/
 dufrFL/1jjFucXV+VTDTqZHTRxmNMk5Qcs0u69l1+wpsNiQJWCp2NZOCOqGbraQbd2fbrApSm
 qoQxsy82MdsupiPWPllv5dBe2wyFMyJJ7ovhrkEfHVBNyqxWGZVEenGSKtF/qITEXSRza0Yhp
 UIdJbBIb2lQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1027158103-1548755192=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Alban,

On Sat, 26 Jan 2019, Alban Gruin wrote:

> Le 18/01/2019 à 16:09, Johannes Schindelin via GitGitGadget a écrit :
> > -%<-
> > +static int run_am(struct rebase_options *opts)
> > +{
> > -%<-
> > +
> > +	if (!status) {
> > +		return move_to_original_branch(opts);
> > +	}
> > +
> > +	if (is_directory(opts->state_dir))
> > +		write_basic_state(opts);
> > +
> > +	return status;
> > +}
> > +
> 
> This means that the state directory will be created only if there is a
> problem (ie. a conflict), not if the user cancels the rebase by hitting
> ^C.  In this case, the user will be left in a corrupted state where the
> builtin rebase cannot abort the rebase properly.

This is an almost literal translation of
https://github.com/git/git/blob/v2.20.1/git-rebase--am.sh#L77-L83:

```sh
if test 0 != $ret
then
        test -d "$state_dir" && write_basic_state
        return $ret
fi

move_to_original_branch
```

All I did was to switch the order to handle the simple (and common) case
first.

So I do not think that this changes the behavior of the shell-scripted
`am` backend.

Looking at the code, for a moment I thought that I had introduced a bug
where the state_dir is not cleaned up after move_to_original_branch() is
called, but I call run_am() in run_specific_rebase() and skip directly to
the finished_rebase label after that, which does take care of calling
finish_rebase() (which removes the state_dir, among other things such as
applying the autostash).

Ciao,
Dscho
--8323328-1027158103-1548755192=:41--
