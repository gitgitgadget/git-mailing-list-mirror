Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F6EF1F453
	for <e@80x24.org>; Sun, 27 Jan 2019 19:06:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbfA0TGE (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Jan 2019 14:06:04 -0500
Received: from mout.gmx.net ([212.227.17.21]:49115 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726630AbfA0TGE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jan 2019 14:06:04 -0500
Received: from [192.168.0.171] ([37.201.193.149]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MMkgl-1gogpM0Xdf-008Xp5; Sun, 27
 Jan 2019 20:05:59 +0100
Date:   Sun, 27 Jan 2019 20:05:53 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v4 10/21] ci: move the Windows job to the top
In-Reply-To: <xmqq7eev54gv.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1901272003560.45@tvgsbejvaqbjf.bet>
References: <pull.31.v3.git.gitgitgadget@gmail.com>        <pull.31.v4.git.gitgitgadget@gmail.com>        <5bdc6a08a8b8040de3082b1690f16538fcc08682.1548254412.git.gitgitgadget@gmail.com> <xmqq7eev54gv.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:VkViaLK1hHL3wesoEkq+JLar5BbDWP5h8JXm6tPsbMHtf4r4ZhU
 A0vQbFOlDTqc01Az6CzpPESTk9lbmJPLn392mDR3rJ2QPtNY2yw1hWa8184UIfs8sbEqP2W
 OMqK6QPKtRZypIWo51qcs2ktEktumOrf1zuZpPfkqXtjmPoD/CQqhNwJ8siJMjt5BQMn4OV
 Z8FXY8EU22yXKCGIVKbgg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JoLXBfXy7No=:HrGkiFHX/SLnuC0kVToXC8
 cjqntT+jKdJ044j33i/cPJeBC/IvIg/PZrrOSok3ih37MZDNRaRgSfkcHPXqxq7W+7XXEU3cQ
 zo+4BoE57YiaFFuB707xCMrxlqKiaI+o1XCEvgW02gYf8ddC2xviXztDGtGQsT/mhmkpD/zD4
 L3agPZtMt3C9LR01oEFDkX3FP0p2fHEoCIb3DdGaiWeQ5eZW0iJFl9rfPv1HANaBB8mQOJg1z
 aXla3QyunTFqz/EeP5owVQNM7X+vSxdh4OM++i7Zl9zKtYNkfQtW82RQhzflZmyaUEK5E5G8V
 mNq+Ta7KogQ7aAeYhhmEzQS7FR7EkL0hgd2zARzLTwMqSJesN90c+XaFPyL1R5v/QepjA2Gdb
 7aO+fNY8j4r1ImJkHCy+ZVU18D9n/G84Wk5illL6vbUIXPyYG5z4I+ZPAPWmNy+bnZhftcY+0
 xx1aaw2Kc+4ROOIN1rGytGYKhSGIVIEjBb8/zSRX/dGu12L5wlUGh67bdZa1WnhTw4TQ7viA0
 Xh/UuUZfcn30EKhsIP/b2QieOqmLhBDiwjRypgJbKPyYGVxN0QuiqehBoRCJPdyxuxw6Xd0Bo
 HaOLW0B1DmLS1bVC94fqT62UGTHQZ4iYJlyibjNA6w9aGMsmYK+BtYWK/hNcoBx5gI2Ky77Yb
 GT+oQDWKDA6yFT3RJT0cGjntCB0ywdeA+RlHzO6FpbH0npa7Kcr5IMvf77ejfYi3oO8MHUBzy
 xDCPyeyzvt0yI8NK3YcOw+IKqCAoArDWTAcJhpzcf9s4SXT4xFQVL0IurjmYuWr16cb93rZ8S
 MVMeQXFuVMLYv2SQn6joimxNbVefRO6U9O2DZc8SVtyo8kMYzTnuojb4jEnspoeXN3/D9Ox8F
 v/v88glLT+m4IxATcKk0suGL06wtepDdBhF/poffVNauKxTe1+cGgHwQM4ydoBqhC2wajlYNg
 dgSVqJuDOuQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 23 Jan 2019, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > The Windows job currently takes a whopping ~1h20m to complete. Which is
> > *far* longer than the next-longest job takes (linux-gcc, ~35m). As such,
> > it makes sense to start the Windows job first, to minimize the overall
> > run time (which is now pretty safely the run time of the Windows job).
> 
> Is the reason why Windows job gets started first is to make sure
> that it, which is known to take the longest time, never has to wait
> before starting while other jobs run, in case there is limited
> parallelism?  The last part of this sentence is what readers of this
> step will need in order to be convinced by the justification given,
> because (1) if the jobs run totally serially, the order does not
> matter much---if anything, running shorter jobs first would give
> results from more jobs sooner, and (2) if the jobs run totally in
> parallel, the order does not matter as long as we have enough
> parallelism.

See my response to the other mail you sent (which seemed to be a first
draft of this mail I am replying to?).

> > This commit is best viewed with `--color-moved`.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  azure-pipelines.yml | 172 ++++++++++++++++++++++----------------------
> >  1 file changed, 86 insertions(+), 86 deletions(-)
> 
> For those who are seeing this azure-pipelines series for the first
> time, it would probably be unclear what the point of adding an
> entire file in 09/21 and them moving lines around in 10/21 is.  If
> somebody asked me why, I wouldn't be able to explain why it is a
> good idea.
> 
> The same comment applies to 11/21.
> 
> Would it hurt readability if these steps are combined?
> 
> If 09/21 were "copy travis.yml to create a moral-equivalent set-up
> for azure.yml", then it is an entirely different story (i.e. "we
> start from an equivalent setup as we have, and then tweak to match
> our needs better, and we can view the tweak easier as a separate
> step"), but I did not get the impression that it was what happened
> there in 09/21.

Indeed, that *was* the intention. I tried to clarify that, by just *not*
adding the Windows-specific part in the commit that adds
azure-pipelines.yml, as it really should imitate .travis.yml closely.

Ciao,
Dscho
