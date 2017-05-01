Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 318811F790
	for <e@80x24.org>; Mon,  1 May 2017 11:07:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S377145AbdEALHP (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 07:07:15 -0400
Received: from mout.gmx.net ([212.227.17.22]:54023 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S939098AbdEALHN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 07:07:13 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M6zvN-1dz9Z026uz-00wknF; Mon, 01
 May 2017 13:06:59 +0200
Date:   Mon, 1 May 2017 13:06:57 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Phillip Wood <phillip.wood@talktalk.net>, git@vger.kernel.org,
        Philip Oakley <philipoakley@iee.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 1/9] rebase -i: generate the script via
 rebase--helper
In-Reply-To: <xmqqtw55jta7.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1705011305570.3480@virtualbox>
References: <cover.1493128210.git.johannes.schindelin@gmx.de> <cover.1493207864.git.johannes.schindelin@gmx.de> <c44a15ed1f1015d7e9377e18610a0c428786995b.1493207864.git.johannes.schindelin@gmx.de> <8c1f3519-0768-69d9-4d15-782da0be8390@talktalk.net>
 <xmqqtw55jta7.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:GxtAk0sXIDFzWjISuNWe4TXMWt/K2IF6h1F5GBJ1WKZkvhkK9CM
 fOaXuJpDZPBQd4X6/m19/SU+pKwEzq5qENqYTbW6gzbUg3SUMh1OzYTtSQJgheaQVqgjmDc
 AsbD6MKUynQPrvUQb8zbq7/U0XqEuVdkAktsfkp8Tlji606dPrfZh61DZoQb4E16Css9oiB
 /UvOSbhGrcpr4hscEqkhg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:je/y08IYaw0=:qcp6fxxNBNqDdizCSw0wjE
 e3K8cACf14tk4U8n5GsopwPgD83ZCge4eU965WY5qccas353KFay3D8eAI9XkuTQfw9MmL+eI
 c8XdDC1HkhOxoY9Up4Sc9VNFtsn+6DPz2A8dfa+Jior+6JK+vTGQffkBaoJb+SZDE0gur89r2
 qQfU9ooKejsNS53Y91nV+B3KHxHnvh2t5x+9bEgwqz5T2MgfogdXobE7EKnJJ07Jqo1yYzpzw
 aMM+TCMMTxi+LrXitW+9o8lGZaZv1FSkGrAhHF+n9yJRRH+wZF+82QRjJGX7WJ97VS68bt9+9
 bvHu8smn1rFoR+2yTIVXvzmLSNOkNWcQo+mDjZM/BCYTyfN3ll9U58BBwYlYMulGL5rbbSo76
 sfxeeaBkh+BtqfQR8Sx2bYbGDznakUjkoBVAAVeFDB/Vemb5t9IickwxhNWrbSkY/kk62ftO+
 8U1MgO9TCqNzXi2LRE9pwp+nz+84eCwxDQSdm7lMdScBNuesKBlaOBhJhh3OTQmkkqPcWcSjg
 +dFDTYWaRDXVRbu3F5+u4qVPJDvej+LgZBy6RpQ2PVeCdS+41AWF50Q4grH3AQoBFDiH44qgl
 0tmivFuW2+5eXcf/rnMKbr0mK29zlM/mksUN/KpiipHHIQMQUFH6OCxQlSPl0HceBLzpP6nmT
 omEvZ8XhIWqEAOK1s2oAtCxhG/2+eYWACrwyVMQZLG07l6KWzMrka7wVwqetmzMZpNCdH++mY
 tdMI3PWgHj8izlklosUxSwAMo9wPT4vC+HVli4v8ajnpCMEzmeR7OnN6ij7VLuyhOj5tLwKRL
 ASw3IuN
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sun, 30 Apr 2017, Junio C Hamano wrote:

> Phillip Wood <phillip.wood@talktalk.net> writes:
> 
> > This changes the behaviour of
> > git -c rebase.instructionFormat= rebase -i
> > The shell version treats the rebase.instructionFormat being unset or set
> > to the empty string as equivalent. This version generates a todo list
> > with lines like 'pick <abbrev sha1>' rather than 'pick <abbrev sha1>
> > <subject>'
> >
> > I only picked this up because I have a script that does 'git -c
> > rebase.instructionFormat= rebase -i' with a custom sequence editor.
> 
> Sorry to hear that.  As there is no way to unset a configuration
> variable from the command line, "git -c var=" like you did above is
> the best we can do, and that why treating unset and empty variable
> the same way is often necessary.  It seems that Dscho gave an ack to
> your message, so hopefully the final version would not have such a
> regression.

As I mentioned in the cover letter of v4, unless you take v3 for the final
version, the final version won't have such a regression:

> - the todo list is generated is again generated in the same way as
>   before when rebase.instructionFormat is empty: it was interpreted as
>   if it had not been set

Ciao,
Dscho
