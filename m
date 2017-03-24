Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39BA71FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 14:59:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935408AbdCXO7X (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 10:59:23 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:50034 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932434AbdCXO7V (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 10:59:21 -0400
Received: from skimbleshanks.math.uni-hannover.de ([130.75.46.4]) by
 mrelayeu.kundenserver.de (mreue001 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 0M8WFH-1bwhWS3cot-00wFrK; Fri, 24 Mar 2017 15:59:07 +0100
Subject: Re: report on a possible bug: git commit -p myfile.py unexpected
 output
To:     Joan Aguilar <joan.aguilar.lorente@gmail.com>, git@vger.kernel.org
References: <CAG+Y4s8m2MqA0yAiZFzv2bAx7g5xktNRb=S-Ej0tvMwU-Un0Og@mail.gmail.com>
From:   Michael J Gruber <git@grubix.eu>
Message-ID: <26915be5-8749-7f66-4d60-516e7ed60adc@grubix.eu>
Date:   Fri, 24 Mar 2017 15:59:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CAG+Y4s8m2MqA0yAiZFzv2bAx7g5xktNRb=S-Ej0tvMwU-Un0Og@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:O47w+UUkHimTUxJV57FFkgTx3gyNL1iwmPAS8YAijo6BbXnW2So
 QmHAMOa954GEk5jjeVKcG5t5ZIARw8t8daBz8jOEptc5R7oxLKOlqgDYlCmTxL818V8GCAr
 EnjyjfMhFCqtAQpxvCT54+jwpjXZ45lLY0kW/pJhu3zW6qU3DYiXNFFqq7m5cGBoTVtaDCe
 EZ8r/k5nbquII7kWbtwDQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nFv7eUrfJng=:zBN45Q/tGtpcYapKpamwb8
 dd2jKzjYPSvk5HkD65+IAfgx3s+wCgJfZ3bGHRs35dYEPK0R7XIxCNMs/ZjNPMr9CKLgTcEv5
 FpKjTMqNrsM9aOIjDEiYg0TXpqafK2y9NBMPQXYmGDEL1Cza+PgaD+DDfj7hx5CU5rj2GZXC/
 vMHY3L+5MGClF5ANeu3KJQxcxkcobZdBzG5hI/GPcn+JOjXlGLC99pKMAf6pUfKMO1E5qohM2
 vet6uWl9QInHS+ZrN+ZmTU4tewxJN7D1WOhpM6NfZhgaQPhux6orn6FsfmLgt6+QAAFZJ3zrF
 pXa7Du/OBL9ZAUifw50U+6BUtWoYmEzKa/o0BMfT/GcPU7xE06v+T6VCS4HupIuQTi3+6Eoov
 LR2/a+dKhQi8oGrQoWdaM6KK0Qc5lNOQjeZ+WlYfBAdjd+Qv1jbuhNdtgrqxS6Sehx/qZ7FIU
 OKmOuR+wb/b3AjmAs9r3dDs2ZEkDm/iH+44e261TOC0GtQZoOxN7KleT32Tuy35RJ3OC2bEl6
 PZvy8L47lrYbTM4VHJBxGvZGbwYlcaEtATUy5Saxbcom7az2alSQkDCf3oYlQulpnX/PkILXi
 jtQR3fcns8hp5MxYNakQ+tcJnhOfH/OPd7SztyKv3lyVxW2ilZHKa13Fdm1RYP1yHNfGtzsPi
 7vphZcPCuIwauubwFVzIZcTE7d5rKr12wv477WF3jXO6nco4fQTHRmnt1NIMYKqFlZT0cBrJ4
 5OA+PfWQhMspt4Fg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Joan Aguilar venit, vidit, dixit 24.03.2017 11:27:
> Hello there
> 
> this is the first bug report of my life and I am not a native English
> speaker so, first of all, I would like to apologize for my English
> skills and the report itself (if it is not precise enough).
> 
> I have already read this 'guidelines'
> http://www.chiark.greenend.org.uk/~sgtatham/bugs.html and I will try
> to attach to them as much as I can.
> 
> What System I am running:
> * Linux 4.9.0-1-amd64 #1 SMP Debian 4.9.6-3 (2017-01-28) x86_64 GNU/Linux
> * git version 2.11.0. Well actually, according to the apt-get install
> output (of course after apt-get update) -> git is already the newest
> version (1:2.11.0-2).
> * VIM - Vi IMproved 8.0 (2016 Sep 12, compiled Feb 13 2017 00:56:16)
> Included patches: 1-197, 322
> 
> What happened:
> I was working on my git repository yesterday and did a lot of changes
> in the file myfile.py. After a little bit of testing I was ready to
> commit them. I decided not to commit all of them at once (because
> these are non related changes), but instead I decided to use the -p
> option (as I always do in this case). For the first patch I decided to
> commit only all methods I have removed because these are not needed
> anymore. So my Idea was to jump from hunk to hunk and split them
> (using 's') to select (with 'y') only the parts I wanted to commit,
> ie, lines I had removed because they are not useful for me anymore. So
> I went for it and I did:
> 
> git commit -p myfile.py
> 
> Until this point all went as expected. The first hunk was printed in
> the console and the it waited for my decision. As always. After a
> couple of hunks I realized it was not possible to split all of them in
> a proper way (to select only removed lines) because new methods were
> mixed up with the old ones. So I cancel the process (ctrl + c) and
> started again using 'e' instead to manually edit the hunks.
> 
> So I repeated the last command: git commit -p myfile.py but this time
> I only used 'y', 'n' and 'e'. All in all I edited ('e') two big hunks.
> By doing this, the default editor (vim in my case) opened showing the
> hunk and with the instructions in how to edit at the bottom.
> Everything as used to be. Until this point all went as I expected.
> 
> In the two hunk I edited I did the same. I removed all + lines by
> deleting them and I make some - lines as context. Like explained in
> the bottom of the file.
> 
> When I was done with each of the hunks, I saved and closed the editor.
> No error was produced (I sometimes make mistakes while editing a hunk
> and know you can get an error (patch does not apply) here, but in this
> case were no errors there so the next hunk was printed and the commit
> procedure kept going.
> 
> When I was done with all hunks, the editor (vim) started again to
> write the commit message. I wrote (something like) this:
> 
>     myfile.py -> old unused methods removed...
> 
>     1) mymethod1
>     2) mymethod2
>     3) mymethod3
>     4) mymethod4
>     5) mymethod5
> 
> Yes, not the best commit ever ;) but enough for us in this case.
> Anyway, I saved it and close the editor and I was surprised by the git
> output.
> 
> [master 96d1c24] myfile.py -> old unused methods removed...
>  1 file changed, 182 insertions(+), 302 deletions(-)
>  rewrite myfile.py (60%)
> 
> What?? I thought to myself... Insertions?? This can't be true? I
> removed all + lines, my idea was to commit only deletions... What did
> I wrong?
> 
> To check this I did
> * git show 96d1c24
> and I saw only red minus lines , ie, deletions. As I expected.

What dows "git show --stat" say?

> To check it twice I used tig too.
> 
> tig showed the same for this specific commit
> myfile.py | 120
> ---------------------------------------------------------------------------------------------------------------------
> 1 file changed, 120 deletions(-)
> 
> Conclusion:
> After these two checks I am sure I did what I intended to do. What I
> do not understand is the output of git when I was done with the
> commit.
> 
> Maybe is just me, because I do not understand how git commit -p when
> using 'e' to edit hunks works. But as user I would expect to see only
> deletions in the output message if I am picking only deletions.
> 
> If this is a bug, I hope you can reproduce it on your system. If not,
> do not hesitate to contact me for further information.
> 
> 
> Kind regards,
> 
> Joan Aguilar
> --
> Joan Aguilar Lorente
> 

182-302 = -120

Did you make any changes in the lines that you left? Apparantly, that's
what the rewrite looked like to git commit.

Michael
