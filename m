Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 857E42027B
	for <e@80x24.org>; Thu, 18 May 2017 12:11:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932499AbdERMLX (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 08:11:23 -0400
Received: from mout.gmx.net ([212.227.17.22]:52270 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932342AbdERKuX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 06:50:23 -0400
Received: from virtualbox ([95.208.59.37]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LaaVn-1dqN7w0WwZ-00mKCe; Thu, 18
 May 2017 12:49:59 +0200
Date:   Thu, 18 May 2017 12:49:57 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] rebase -i: silence stash apply
In-Reply-To: <20170518100233.30559-3-phillip.wood@talktalk.net>
Message-ID: <alpine.DEB.2.21.1.1705181246430.3610@virtualbox>
References: <20170518100233.30559-1-phillip.wood@talktalk.net> <20170518100233.30559-3-phillip.wood@talktalk.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:GRl8lDk476X+HZe7v5kQiJBf+zPCKffY8qjy3flJ5yMUBrQwvgm
 oF8/zxv+RnGnqG0IJQgVx8aW/J2v89XHciyvo51PeZ7oBHg7IWssrIOIMzC9gxGO2Mr1KFX
 R4IKzJ9JuxMQl1HqrU75BVfoz+geXRul8KCxHxvArC8sY2OjB4VOvzLYfLw96tsb9niRGqa
 lcBLl0ZxGNPkLHihTmDww==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JhzJ2s2RmAQ=:9es2CXP3oH1a8e6c7gTXCf
 6nSJztIFp3zCNeJXNGv4ZlIwVON+IvIau/6/7XnpypUXrkG/XzC9LVyI7H2IX0+uptlkfDHc8
 0ul4dWbwjZQ4Xtviok9V/JFEBs5hgNBp2iX0vZCm7ef7rztK7FEaGvgZi4gfQk63IuKay7krS
 cnIHXSmuANX7e9U2LZIO3H8VF1QTJZB25zuCjeDgQVI6be4NCaklNNipFQigbHJd5V5JG8/PB
 1NGWQGGsALExYoOyfnpkpiD47HFI1p8Z7E5uuu79aCXOph2CU6hLgXsWR4y5sImA+B/0CDGkv
 JlHROuftxwlEaXt15SfmJ8xJ8IJaPhS+jqFGcvjqkPJrt1eJTDZzdTIyhV8pXoYu4bgzkP05o
 Zu0RGNOnGl6dWgU0XXYX30vDKQhZs3gVjEGTpJbis8QQSETEWx3AhLiRK3wucq/DSEz4eHRI/
 +zVQEsj2km0tNa4p0l0UO9zMplN2R+jTOil2r3XU63m+kRIuFdGf8t5r8eSuzZEdcFZwSaTsQ
 tYH6lsIy8zWZWfi479CKji0CZ5pqmA4aO/Z3KRI7TzN6nwLR4fSHpmz9qqelhICAuHNnq6//9
 tF6U6CeHw/504nqh4a7BwoN0K+BPGT1nsOKsRmIHyM2NGT4BHS0r+1mVaaboVw5S1Ce5Fz1NI
 hFZWxVTTFbJSk2Z8smPMcj8bli3aRDuu+KZegsdRNRHy3eNr/+FR0IP5JRqWRv5P8gKxZHgP8
 lLf5iq8a2zcthYoUgrkaYPZ5TCpm4jYOEojrGdrDVjXisjlleltNnets4GYwi/C6lpFKrFWor
 vNRiHRz
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Thu, 18 May 2017, Phillip Wood wrote:

> diff --git a/sequencer.c b/sequencer.c
> index f8bc18badf1a3fb1b39656501c5a316e229968d2..311728a145dfc66e230334221a2610468239932d 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -1914,6 +1914,8 @@ static int apply_autostash(struct replay_opts *opts)
>  	strbuf_trim(&stash_sha1);
>  
>  	child.git_cmd = 1;
> +	child.no_stdout = 1;
> +	child.no_stderr = 1;
>  	argv_array_push(&child.args, "stash");
>  	argv_array_push(&child.args, "apply");
>  	argv_array_push(&child.args, stash_sha1.buf);

If I remember correctly, then the shell version prints the output in case
of an error.

We already imitated that behavior in `git commit`
(https://github.com/git-for-windows/git/blob/v2.13.0.windows.1/sequencer.c#L674-L684):

		/* hide stderr on success */
		struct strbuf buf = STRBUF_INIT;
		int rc = pipe_command(&cmd,
				      NULL, 0,
				      /* stdout is already redirected */
				      NULL, 0,
				      &buf, 0);
		if (rc)
			fputs(buf.buf, stderr);
		strbuf_release(&buf);

I think that would be the appropriate approach here, too.

Ciao,
Johannes

P.S.: it may be a very good idea to accompany this patch (as well as the
previous one) by a patch to the test suite to verify that the fixed code
does not regress.
