Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC6B91FD99
	for <e@80x24.org>; Tue,  9 Aug 2016 11:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbcHILlj (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 07:41:39 -0400
Received: from mout.gmx.net ([212.227.17.22]:59621 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932105AbcHILli (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 07:41:38 -0400
Received: from virtualbox ([37.24.141.218]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MfiFU-1bu8Zh1JCe-00NA4U; Tue, 09 Aug 2016 13:41:21
 +0200
Date:	Tue, 9 Aug 2016 13:41:18 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	Lars Schneider <larsxschneider@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Eric Wong <e@80x24.org>
Subject: Re: patch submission process, was Re: [PATCH v6 06/16] merge_recursive:
 abort properly upon errors
In-Reply-To: <xmqqr39zf9tt.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1608091339590.5786@virtualbox>
References: <cover.1469547160.git.johannes.schindelin@gmx.de> <cover.1470051326.git.johannes.schindelin@gmx.de> <8ff71aba37be979f05abf88f467ec932aa522bdd.1470051326.git.johannes.schindelin@gmx.de> <xmqqlh0gjpr6.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1608021004080.79248@virtualbox> <xmqqy44ec15p.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1608031021050.79248@virtualbox> <CAPc5daXJzMsJf5K84XBFuQ5=q_OwtYUW2FikZ2QsZWk8fa9jgg@mail.gmail.com> <alpine.DEB.2.20.1608031753431.107993@virtualbox>
 <CAGZ79kYWdZCNW_eBi5aLAacyBZJXQ9xyOWMBmjNsYT5NWjr-Og@mail.gmail.com> <alpine.DEB.2.20.1608041730130.5786@virtualbox> <CAGZ79kaTT3NgKj8akB8t9b1BF3i6sXe7Un9oq5KP8077Wz-E+g@mail.gmail.com> <alpine.DEB.2.20.1608050925240.5786@virtualbox>
 <alpine.DEB.2.20.1608061045240.5786@virtualbox> <CFDF5DDE-C5D9-489E-B099-6D0D2479B331@gmail.com> <xmqqr39zf9tt.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:8e9PKxqbn3hN1CkVocGOGZrlwD/W4f4QUQ4OqGGzpoQi3Ped/95
 0b1cBOmdT20MUKl7/8bw0GtFaCGefcLflrjbUy2VLpsvEG1CPCRbC2BAj/y/ywEBTSeKqaD
 qbaqJybXQ/Cf99pnqEVJsjVqMvThuyxEfnu/MKoGNkoFr81GpONyuCjnI1I74c8/BjgYtYA
 0vTRDtocPCWorT8z/pKFA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:+3k47m27i1o=:o5RlrIFyi2wJhuCUsz9q63
 sIqV27cMUvzO5gRnOQ9pzOomwa7CFONHQ0BeWLBjs+9JiA0DY/Z8/yhPWRqhP2W0w5ItG6H0K
 QFXZgtUzKYp8zVnl2MzL2wtELDrAsFdlp+c4LACvlkdcw6URcTwEZzJlAHF12cycvRZyuw0uN
 yWKrKDy5U5OKNk9Y6rXMMxdoZf48QD720nukXcTu8bS1kBbxHXBta5q5Phc3f2fsn2lYOOjY1
 EfsUYDS7Ma5PB+Q5LbSAkejrB4anijnuYqtGWaYLHBoRNW7ky1o5DPbkoBMdew5p7lKd5P9R/
 lIQZk+QAonecHPnCU3W/JLKqCc9ZBZmFx9GszgZ2eivXATV9K7MAm9m4p06sXr3zO955jKAyQ
 Az406YjFxEQy8geJXMIgOqbQHiYtKmfwj+yunVIYGIXe2Fn7Vvct7W72J4fGgA8xnCqiEItSo
 mTdAJ0JbtbkNwLMrWNrqlO+qj3c3blJQQjUE6NlQ+y7mkGoMOAqKRDRKVqeBMfy9R2gscIAh5
 YABS4mpsHeM3zREKDalmVe/Mm3VNP8kkhGeQkek9RT29PgzV9xvh6hknwIOK218y3PdZ2zKg3
 DKcDRYV5W4bJ9s9rh9Mc45h9BZ+S5Neq/b8X05hoWaruB0MlLSpRfuLQH04vahLUjK/qdoQ4i
 UDHkVgI3SLyV7fn+AEJRjKjGwVzJzQsbpEy4J97qkAwk8LKGKHmTnPLWKiCFE27PeUT1IDAAW
 abN+7zTJNsv1+3HRRtJUxhC0rvuzODucTxx612gH/bK5+DPoevKkjoAiMJ+sDdT7njXcZp/gA
 vdZ/qMn
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Mon, 8 Aug 2016, Junio C Hamano wrote:

> Lars Schneider <larsxschneider@gmail.com> writes:
> 
> > 4.) Reviewing patches is super hard for me because my email client
> > does not support patch color highlighting and I can't easily expand
> > context or look at the history of code touched by the patch (e.g via
> > git blame). I tried to setup Alpine but I wasn't happy with the
> > interface either. I like patches with a GitHub URL for review but then
> > I need to find the right line in the original email to write a
> > comment.
> 
> Unless a patch is about an area you are super familiar with so that you
> know what is beyond the context of the patch to be able to judge if the
> change is good in the context of the file being touched, it is always
> hard to review from inside a mail reader.
> 
> Running "git am" is a good first step to review such a patch, as that
> lets you view the resulting code with the full power of Git.  As you
> gain experience on the codebase, you'll be able to spot more problems
> while in your mail reader.

I am glad that you agree that the requirement to manually transform the
patches back into Git (where they had been originally to begin with) is
cumbersome. This is the first time that I see you admit it ;-)

Ciao,
Dscho
