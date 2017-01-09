Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 156EA20756
	for <e@80x24.org>; Mon,  9 Jan 2017 07:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754760AbdAIHqs (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 02:46:48 -0500
Received: from mout.gmx.net ([212.227.17.22]:51738 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754062AbdAIHqp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 02:46:45 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LvUwp-1cYdUf3GiJ-010gRC; Mon, 09
 Jan 2017 08:46:35 +0100
Date:   Mon, 9 Jan 2017 08:46:19 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Segev Finer <segev208@gmail.com>
Subject: Re: [PATCH] connect: handle putty/plink also in GIT_SSH_COMMAND
In-Reply-To: <xmqq4m1911mf.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1701090825510.3469@virtualbox>
References: <2ff29a4d00e0e13d460122d8008e762361ca90aa.1483358673.git.johannes.schindelin@gmx.de> <xmqqy3ym1dsc.fsf@gitster.mtv.corp.google.com> <xmqq4m1911mf.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:du1wkN0XbucOJw+YINZWxT+ji3dWggcE8+BKBy8uGb0Dl1peDog
 zdG38j7RXs2bAtS0rWhFvcHJRZE3dNAvOBgmnbkcslgLDRaWMmb9rGR3y29GJ2vkD7UFg9M
 uRNY58uY1QD6GTlcJm4YVwIwGV3rBvJtJ+uFUldurLCgPuKzS0nT1XqZtxyDy0xUfLQIzDV
 toYoj5tJpenP4fJkV4bmw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EQIa4W4D3WY=:cm5ii13AcI9ASNnXl3phKb
 6UgTbxH+SURKb6/4TMg13G0iuvYb8D7Fl94TqXvSfHbr6YXMPPdfVaZKDuA9rumq7HU91OmbG
 44+a0VD3vxUT5V9d6BHkR8dxDKZGqpNeAtq16JejEEKn3maueMlklRSosyrLCumWvEkzKyuu4
 PyXhRK/GFVCemUcEMsRJFHRgjTWdRV8odYePpX8ineUxnM5UWVXSup291fo7C2MwHZUpjuFoL
 Ie+VA2LLeJuQLFBbT36t1jQiHRfMsQ06UJmhil8j//McjYOLLBJfvkZLx4lOYvwK0y0s0cWzM
 9WK8FX47Dkc9hx3rcF0jg7UcUE5Je4sTZxPEXM2EbV7yKZrAObaE6u1CACGG1o0bmGZyf5jPJ
 ew8VKXZr/YNJwQuBV6AaXVGsai69IOYRnjWQyhGjCdrd7KkaFwpV0ZnoeQNH+PDNobqPdAr4H
 2T284gWo4DOimKgXMz+wVvI+xnP1XRwkqe2P/2OJBlASuwd6wF4Vn0dXYCYWXQ5td6XOJbOrg
 1NL3d9iair1scJ7F4CikCrNNhKswW84inOx95lztFzmIateVi1z8lC54ltdxAJ9niF8gyi962
 wXnVEZb8Pn2QtdezMqULP6P6erlTrRi0wYFBlpSwff7nTdxY5ZzoNDg//C/z8CJ/FpeR+m78+
 6gTskFwt1OKjS3rzHeWLEcYOlXsewydIDxg0OYjzMyulet2S9jAh+DoajTK2SrZZPXn+5sVrJ
 81iZ3YkV9gyXUX5+s9+/Xtbpv6nLDyTdl8e5pu5zbwMuJOXCNoOdfjxjROQdlcI5mCKMXXDPf
 3IZ4YNI/hxShB/qwbEoKCpi8QyoSAXzhWwzCJmoGz1OMk9urm+ktdMNUvq2efigqqwhaKguUS
 OXaBXPtYM7eMJ884x8l7qsmnFx21Z/kOZcdQ/8KnhU1izmmg29IARlEHtXt6jkKDfTHABYBc6
 MbCQHBeaHGDYRTQ/8t9S2OF/LSvDil4NcjZ97K98iL5EH+BJ6sI+/R5+hdyWlLcbqdQq//rbK
 9AzGqjQ/pLlW+b1/yyF1b7m+03/79uNLtYRg4T+9hvqU+LhTQ4BFJ2LBQkr6osqBqA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sun, 8 Jan 2017, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > I suspect that this will break when GIT_SSH_COMMAND, which is meant
> > to be processed by the shell, hence the user can write anything,
> > begins with a one-shot environment variable assignment, e.g.
> >
> > 	[core] sshcommand = VAR1=VAL1 VAR2=VAL2 //path/to/tortoiseplink
> >
> > One possible unintended side effect of this patch is when VAL1 ends
> > with /plink (or /tortoiseplink) and the command is not either of
> > these, in which case the "tortoiseplink" and "putty" variables will
> > tweak the command line for an SSH implementation that does not want
> > such a tweak to be made.  There may be other unintended fallouts.
> 
> Thinking about this further, as the sshcommand (or GIT_SSH_COMMAND)
> interface takes any shell-interpretable commands, the first "token"
> you see is not limited to a one-shot environment assignment.  It
> could even be "cmd1 && cmd2 && ..." or even:
> 
> 	if test -f ${TPLINK:=//path/to/tortoiseplink}
> 	then
> 		exec "$TPLINK" "$@"
> 	elif test -f ${PLINK:=//path/to/plink}
> 		exec "$PLINK" "$@"
> 	else
> 		echo >&2 no usable ssh on this host
> 	fi

Sure, it could be all of that. It could even blast through the environment
limits in some environments on some platforms, but not on others. It could
automatically transfer bitcoins whenever a connection to github.com is
attempted. It could start the camera and build a time-lapse of "every time
I pushed or fetched a repository", as an art project. It could shut down
the computer.

It could do all of that.

In practice, however, what users realistically do is to use
GIT_SSH_COMMAND whenever they need to override the ssh command with
options.

This is the common case, and that is what we must make less cumbersome to
use.

If you feel strongly about your contrived examples possibly being affected
by this patch, we could easily make this conditional on

1) no '&&' or '||' being found on the command-line, and
2) argv[0] not containing an '='

Another approach would be to verify that argv[i] starts with '-' for
non-zero i.

But do we really need to do that?

Let's have a very brief look at the amount of work required to come up
with a false positive (I am not so much concerned about any power user
writing elaborate shell expressions that may call plink.exe: those power
users will simply have to continue to use their own -P => -p and -batch
hacks):

The logic kicks in if the split command-line's first component has a
basename `plink` or `tortoiseplink` (possibly with `.exe` suffix). The
only way this logic can kick in by mistake is if the first component is
*not* the command to call *and* if the first component *still* has a
basename of `plink` or `tortoiseplink`.

That means that the user has to specify something like

	HAHAHA_IT_IS_NOT=/plink.exe ssh

as GIT_SSH_COMMAND.

Now, let's take a *very* brief look at the question how likely it is to
have a basename of `plink` or `tortoiseplink`. Remember, there are two
ways that the basename can be a specific term: either the original string
is already equal to that term, or it ends in a slash followed by the term.
That is, either the first component refers to plink.exe/tortoiseplink.exe, i.e.
it would be a *true* positive. Or the first component would end in
"/plink" or "/tortoiseplink" (possibly with the `.exe` suffix) *and not be
a command*. But how likely is it to specify a non-command (such as a
per-process variable assignment) that specifically mentions plink or
tortoiseplink?

Is it even realistic to expect users to specify values for GIT_SSH_COMMAND
that contain "plink" as a substring when they do *not* want to call plink
at all?

After thinking a bit longer than I had originally planned about it, my
answer is: no. No, I do not think it is realistic. I fully expect *no*
user to have a GIT_SSH_COMMAND containing even a substring "plink"
*anywhere*, unless they do, in fact, want to call plink or tortoiseplink.

My main aim with Git for Windows is to improve the user experience, and
the patch in question does do that. Of course, I also try to avoid
breaking existing setups while improving the user experience, and
I believe that it is safe to assume that the patch in question in all
likelihood does not break any existing setup.

Ciao,
Dscho
