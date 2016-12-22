Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 996FB20968
	for <e@80x24.org>; Thu, 22 Dec 2016 21:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757551AbcLVVho (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Dec 2016 16:37:44 -0500
Received: from mout.gmx.net ([212.227.15.18]:64998 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752839AbcLVVhn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2016 16:37:43 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MDyil-1cM9fB0Cw3-00HN1A; Thu, 22
 Dec 2016 22:37:22 +0100
Date:   Thu, 22 Dec 2016 22:37:20 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Johannes Sixt <j6t@kdbg.org>
cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Beat Bolli <dev+git@drbeat.li>
Subject: Re: [PATCH v2 3/3] mingw: replace isatty() hack
In-Reply-To: <e9f8a015-4106-fa88-082a-9e8c06ff61f3@kdbg.org>
Message-ID: <alpine.DEB.2.20.1612222235200.155951@virtualbox>
References: <cover.1482342791.git.johannes.schindelin@gmx.de> <cover.1482426497.git.johannes.schindelin@gmx.de> <5e3c505a206a735e6ba0bfaf4c73965e95a928eb.1482426497.git.johannes.schindelin@gmx.de> <e9f8a015-4106-fa88-082a-9e8c06ff61f3@kdbg.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:eCkkXbrfqS17oGpGVHJrJvDCW0v8K2xzYZMy9ki7isuhzx1sKL5
 Fngg9OWvyyvxh3k/FH/4Vol0a/CE3tDsSFXOmKhvSlbGS6iB+ZVhZuijhitWsJWf0PUm7k5
 NMVp3UcXXkly318vlcybe72dSSCNjfIeDcyUYeh5jw/OOaH6uPKuE8ddxIxj0PzajLf2LP4
 jE5DLSWx+h2aGXJvHtUeA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:aNeOyFssvTw=:DA76CuI/GUEvs9S/v93R1l
 brAv+YoDWHgUk6QRgzNzYPrrsREH6mWpZYQcdC9z1DHbFniVFfduh/8aLpzp+PXPlhnzwCclL
 MB8f3h96m2OdNHn++Bn1Y/l9aB4t5QydGVCilPUTkbiVnfWEk3mxjxlkcXVo29nvDrtGe1LaU
 cVNw25LAvlW1tINcD3RzXtubbWvudCAI9UiCLr3AXZdfzkhHP+oksPLgypi+f4o3dCLNgvrIW
 /MCEPlSsF31rv64gYCpqvAuYXR8akyGJqi/89yJu/o+I+sDlXlnlgilC23jdrZsWDFvdJ+oQZ
 Z+OjP+2NjHuqNN53r8WJihlLuIjM5fxzfNJp2b9wElS8Mcv+wVRm12EdYUq50AWDayCvLKXVe
 jA+moXD0IRPLdbjQgiEF1m2q0ohDPJ/E0zsrybwEky3ZXc4agBGWvjCq3PfjMpWL9VJTOXRQ8
 E6vQW0qsi6HM0+6bqj9Qbu06ZRPEOdzz1FYQUprH6nu93F5R6lJko+7DGI2nabp/FNaORRvgb
 i2VlhmMMRva47oWHBr0864OP/ms45GR4378y2n6bGNmVNEGVHTpg9L6oSbEH4JFqEOHR8qGmn
 QkjSJOMrbkIc/qKnp+U8aGiQPxNnspeZTrTfGJMSnKj3UOhZenjdukA83zK/4hssoFrw2bzjr
 RrIrwzNKEAUfzJh9GFLzOHrQo86BQ03jSVwsocCLQbGRfjvLQ/eMfZjW1kRj9vkL0T08rDzZA
 3sikTDW4ZyRto5fB0hO54GByQOFI2ouVYGYZa6Q9hBxnK8XjOXrg4VF3WGqprEMPYpDkUHFyE
 lKvShoa
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hannes,

On Thu, 22 Dec 2016, Johannes Sixt wrote:

> Am 22.12.2016 um 18:09 schrieb Johannes Schindelin:
> > +static HANDLE swap_osfhnd(int fd, HANDLE new_handle)
> > +{
> > +	/*
> > +	 * Create a copy of the original handle associated with fd
> > +	 * because the original will get closed when we dup2().
> > +	 */
> > +	HANDLE handle = (HANDLE)_get_osfhandle(fd);
> > +	HANDLE duplicate = duplicate_handle(handle);
> >
> > +	/* Create a temp fd associated with the already open "new_handle". */
> > +	int new_fd = _open_osfhandle((intptr_t)new_handle, O_BINARY);
> >
> > +	assert((fd == 1) || (fd == 2));
> >
> > +	/*
> > +	 * Use stock dup2() to re-bind fd to the new handle.  Note that
> > +	 * this will implicitly close(1) and close both fd=1 and the
> > +	 * originally associated handle.  It will open a new fd=1 and
> > +	 * call DuplicateHandle() on the handle associated with new_fd.
> > +	 * It is because of this implicit close() that we created the
> > +	 * copy of the original.
> > +	 *
> > +	 * Note that the OS can recycle HANDLE (numbers) just like it
> > +	 * recycles fd (numbers), so we must update the cached value
> > +	 * of "console".  You can use GetFileType() to see that
> > +	 * handle and _get_osfhandle(fd) may have the same number
> > +	 * value, but they refer to different actual files now.
> 
> Certainly, the OS does not recycle handle values that are in use (open). Then
> I do not quite get the point of this paragraph. See...
> 
> > +	 *
> > +	 * Note that dup2() when given target := {0,1,2} will also
> > +	 * call SetStdHandle(), so we don't need to worry about that.
> > +	 */
> > +	dup2(new_fd, fd);
> > +	if (console == handle)
> > +		console = duplicate;
> 
> ... This is where "the cached value of console is updated", right? If console
> == handle, then this is not because a handle value was recycled, but because
> fd *was* console. Since the old value of console has been closed by the
> dup2(), we must refer to the back-up value in the future. Am I missing
> something?

You are correct, we must update `console` because `handle` is no longer
the handle we want.

The comment above only meant to reinforce that we have to forget about the
previous handle, too, as we might access something completely different
than a console otherwise.

Would you have a suggestion how to rephrase the comment to make it less
confusing?

Ciao,
Dscho
