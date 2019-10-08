Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 393E41F4BD
	for <e@80x24.org>; Tue,  8 Oct 2019 19:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730607AbfJHToz (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Oct 2019 15:44:55 -0400
Received: from mout.gmx.net ([212.227.15.15]:50699 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730008AbfJHToy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Oct 2019 15:44:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570563891;
        bh=QeyQykLyvd8N8euyRizqK7T4u5Fl1V07OLlleqIyLmg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=CnfqWsVygMGRSqZibUYsZ93O0NAvgFNr7deCg4asLfBMPugDgq+XeiAhPw/HWiy13
         DAR9LWNeHWkFoF86UqUSQT59h++NtwQ6A3PFE/b765IyKZUEVa0MdkLLxfrKJoXzsP
         Vg0ruj2UXazzqohNWzTffYtLevaruATqiECOljio=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N8ofE-1i3wkn0eow-015rPE; Tue, 08
 Oct 2019 21:44:51 +0200
Date:   Tue, 8 Oct 2019 21:44:50 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Thomas Gummerer <t.gummerer@gmail.com>
cc:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        git@vger.kernel.org, entwicklung@pengutronix.de
Subject: Re: [PATCH v2] range-diff: don't segfault with mode-only changes
In-Reply-To: <20191008173843.GC74671@cat>
Message-ID: <nycvar.QRO.7.76.6.1910082144250.46@tvgsbejvaqbjf.bet>
References: <20191007110645.7eljju2h6g7ts7lf@pengutronix.de> <20191007134831.GA74671@cat> <20191008173843.GC74671@cat>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-920009355-1570563891=:46"
X-Provags-ID: V03:K1:WmiYP+0A4qVUbj7W6v9P1XVWbrAzxLeExwuYnj4X+QoTnIUdbSn
 Onoy37aCRFAHFsE/EpE6UagURzUsCLWUYZHk7g/ohIuJmOUBY+a6krtLm92AQLbINeVG2Dx
 ekHmzL2gYbpTdz/23lBdfCQetE0iM1O6ZAGe/OMMHTPLog1SaFsvsA5pOT5Xk20ZqwUSwwC
 KfF61AZeZP9IT/E+KeUDA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Snpc9jLiqjo=:bBmXGGF1qXnTMDYNHpOMx5
 qubsYgbaf5H/FR4yatcvVVUl8cAQBSgL+Nf6efbWxj8zZboqeh96GO/ttSggFGzdEwHYsjJOA
 KdqarefhT1oa6YmJM114rxWKVFERoIgjFHyolLf/sAqpdHXt0VCgGO4FwiOHTyZZmkF+rB2mA
 XyTS6Ys/qGt4nriPjNJTz8fxgFLwJOAhboSx4bajYDRaw2FJkXxsxOVBKAvANkV9IVYqSucBH
 B7rPK3uN6xnsOqy5a7kDXMwX+qZUT74VCb2DCfAnYcxjXwmw6FBHcHL3x5B0E6pFev3rKzIph
 LcLPYQsm0HGY9owrzea3dPypFfgGwaeGWhpgLhOoe9sJKSEP7qBzjazvIkTeGYGkhky0hAhG3
 ghWHQa9c39NOIutNEebfNsn+lXXnOfjRF7PPfjd6GbK3TC3As4WwAm/3xzpheM//vJSenTp3P
 yDw6IhmuWXSgclewoHVudUxtcoZFMk0g8xY3/ZPR8VGdheMAclBOR+5Rpy96iSLu6hCuaRcch
 JG11CZVUnv5aB5YC+0mGzfPXNE+dh+fqWpdxrevDrfz7vORrt70mcGMifOwWSAux/j+Pl/b2D
 f6hahKWDSKRbx/PFueBEWroRhMIcM2pFDrsQ8cD+mFNI02GvtkVxUUn4EGiiyZtFBpAPGuhXs
 zw6VB8+GMVl/bS3wyAjFn17yB0Osw2lFm7k6kUUkUljnCJOjYwNVnrokGrPMOy5j4/imqfQmL
 d4eC9MvF6IFKi2YLnzUb+/B6AHCBvdY2JOXdaaUotk5W4tvz0IVq1KsAZbwYH5F+5uNlDlDSb
 D/6+ansmXDbaL4RV9mq1CqLSYNsPt2wdgRtTLhBU2UmFv9LHJdhruWGwxRfOsJJs+aLQJ75Qi
 QkrSKUe5MJlkgxA3bQQ2ZDtYNqNp6pOFnUQuEQ2g37pArGLhWRE5nvpin+D8qKPG2mJuKwx+3
 LHUzX+FwLKbvFnKKVz9jtDAJlRwq7tYq/Dlw2JubvTGbMoZszO6GnNhD/u1f9X9CaIU+G4Pom
 Qmhs4pviq8NjHOcWDN979DctbSYMOts7bvlKAuf5aKQBS4cK6Ul4alZ1Z0/AxIs97apwXN38q
 JGlFpRggTA3bLlh8IS2U7gOHehDiJV2WwK4XWu4DTjJl6vsLkhc8lcr+GE7AtOxYz3+Q0FCI6
 zCOznoS0m5xJSGre5rA6vRv4EoYcFmZ1pMp/ZzruRZYaAG/HoNpYkj6xdPelXpw16nQ9iy2WS
 h/stiarRHgN5iGAni8jIfW2kDZnZD58XQni2Nd0H/mJOmg83r2oS5v8JLKsY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-920009355-1570563891=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

On Tue, 8 Oct 2019, Thomas Gummerer wrote:

> In ef283b3699 ("apply: make parse_git_diff_header public", 2019-07-11)
> the 'parse_git_diff_header' function was made public and useable by
> callers outside of apply.c.
>
> However it was missed that its (then) only caller, 'find_header' did
> some error handling, and completing 'struct patch' appropriately.
>
> range-diff then started using this function, and tried to handle this
> appropriately itself, but fell short in some cases.  This in turn
> would lead to range-diff segfaulting when there are mode-only changes
> in a range.
>
> Move the error handling and completing of the struct into the
> 'parse_git_diff_header' function, so other callers can take advantage
> of it.  This fixes the segfault in 'git range-diff'.
>
> Reported-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Ciao,
Dscho

> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
>
> Thanks Junio and Dscho for your reviews.  I decided to lift the whole
> error handling behaviour from find_header into parse_git_diff_header,
> instead of just filling the two names with xstrdup(def_name) if
> (!old_name && !new_name && !!def_name).  I think the additional
> information presented there can be useful.  For example we would have
> gotten some "error: git diff header lacks filename information"
> instead of a segfault for the problem described in
> https://public-inbox.org/git/20191002141615.GB17916@kitsune.suse.cz/T/#m=
e576615d7a151cf2ed46186c482fbd88f9959914.
>
> Dscho, I didn't re-use your test case here as I had already written
> one, and think what I have is slightly nicer in that it follows what
> most other range-diff tests do in using the fast-exported history.  It
> also expands the test coverage slightly, as we currently don't have
> any coverage of the mode-change header, but will with this test.
>
> The downside is of course that the fast export script is harder to
> understand than the test you had, at least for me, but I think the
> tradeoff of having the additional test coverage, and having it similar
> to the rest of the test script is worth it.  If you strongly prefer
> your test though I'm not going to be unhappy to use that :)
>
>  apply.c                | 43 +++++++++++++++++++++---------------------
>  t/t3206-range-diff.sh  | 40 +++++++++++++++++++++++++++++++++++++++
>  t/t3206/history.export | 31 +++++++++++++++++++++++++++++-
>  3 files changed, 92 insertions(+), 22 deletions(-)
>
> diff --git a/apply.c b/apply.c
> index 57a61f2881..f8a046a6a5 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -1361,11 +1361,32 @@ int parse_git_diff_header(struct strbuf *root,
>  			if (check_header_line(*linenr, patch))
>  				return -1;
>  			if (res > 0)
> -				return offset;
> +				goto done;
>  			break;
>  		}
>  	}
>
> +done:
> +	if (!patch->old_name && !patch->new_name) {
> +		if (!patch->def_name) {
> +			error(Q_("git diff header lacks filename information when removing "
> +				 "%d leading pathname component (line %d)",
> +				 "git diff header lacks filename information when removing "
> +				 "%d leading pathname components (line %d)",
> +				 parse_hdr_state.p_value),
> +			      parse_hdr_state.p_value, *linenr);
> +			return -128;
> +		}
> +		patch->old_name =3D xstrdup(patch->def_name);
> +		patch->new_name =3D xstrdup(patch->def_name);
> +	}
> +	if ((!patch->new_name && !patch->is_delete) ||
> +	    (!patch->old_name && !patch->is_new)) {
> +		error(_("git diff header lacks filename information "
> +			"(line %d)"), *linenr);
> +		return -128;
> +	}
> +	patch->is_toplevel_relative =3D 1;
>  	return offset;
>  }
>
> @@ -1546,26 +1567,6 @@ static int find_header(struct apply_state *state,
>  				return -128;
>  			if (git_hdr_len <=3D len)
>  				continue;
> -			if (!patch->old_name && !patch->new_name) {
> -				if (!patch->def_name) {
> -					error(Q_("git diff header lacks filename information when removing=
 "
> -							"%d leading pathname component (line %d)",
> -							"git diff header lacks filename information when removing "
> -							"%d leading pathname components (line %d)",
> -							state->p_value),
> -						     state->p_value, state->linenr);
> -					return -128;
> -				}
> -				patch->old_name =3D xstrdup(patch->def_name);
> -				patch->new_name =3D xstrdup(patch->def_name);
> -			}
> -			if ((!patch->new_name && !patch->is_delete) ||
> -			    (!patch->old_name && !patch->is_new)) {
> -				error(_("git diff header lacks filename information "
> -					     "(line %d)"), state->linenr);
> -				return -128;
> -			}
> -			patch->is_toplevel_relative =3D 1;
>  			*hdrsize =3D git_hdr_len;
>  			return offset;
>  		}
> diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
> index ec548654ce..5b87fead2e 100755
> --- a/t/t3206-range-diff.sh
> +++ b/t/t3206-range-diff.sh
> @@ -226,6 +226,46 @@ test_expect_success 'renamed file' '
>  	test_cmp expected actual
>  '
>
> +test_expect_success 'file with mode only change' '
> +	git range-diff --no-color --submodule=3Dlog topic...mode-only-change >=
actual &&
> +	sed s/Z/\ /g >expected <<-EOF &&
> +	1:  fccce22 ! 1:  4d39cb3 s/4/A/
> +	    @@ Metadata
> +	    ZAuthor: Thomas Rast <trast@inf.ethz.ch>
> +	    Z
> +	    Z ## Commit message ##
> +	    -    s/4/A/
> +	    +    s/4/A/ + add other-file
> +	    Z
> +	    Z ## file ##
> +	    Z@@
> +	    @@ file
> +	    Z A
> +	    Z 6
> +	    Z 7
> +	    +
> +	    + ## other-file (new) ##
> +	2:  147e64e ! 2:  26c107f s/11/B/
> +	    @@ Metadata
> +	    ZAuthor: Thomas Rast <trast@inf.ethz.ch>
> +	    Z
> +	    Z ## Commit message ##
> +	    -    s/11/B/
> +	    +    s/11/B/ + mode change other-file
> +	    Z
> +	    Z ## file ##
> +	    Z@@ file: A
> +	    @@ file: A
> +	    Z 12
> +	    Z 13
> +	    Z 14
> +	    +
> +	    + ## other-file (mode change 100644 =3D> 100755) ##
> +	3:  a63e992 =3D 3:  4c1e0f5 s/12/B/
> +	EOF
> +	test_cmp expected actual
> +'
> +
>  test_expect_success 'file added and later removed' '
>  	git range-diff --no-color --submodule=3Dlog topic...added-removed >act=
ual &&
>  	sed s/Z/\ /g >expected <<-EOF &&
> diff --git a/t/t3206/history.export b/t/t3206/history.export
> index 7bb3814962..4c808e5b3b 100644
> --- a/t/t3206/history.export
> +++ b/t/t3206/history.export
> @@ -55,7 +55,7 @@ A
>  19
>  20
>
> -commit refs/heads/topic
> +commit refs/heads/mode-only-change
>  mark :4
>  author Thomas Rast <trast@inf.ethz.ch> 1374485014 +0200
>  committer Thomas Rast <trast@inf.ethz.ch> 1374485014 +0200
> @@ -678,3 +678,32 @@ s/12/B/
>  from :55
>  M 100644 :9 renamed-file
>
> +commit refs/heads/mode-only-change
> +mark :57
> +author Thomas Rast <trast@inf.ethz.ch> 1374485024 +0200
> +committer Thomas Gummerer <t.gummerer@gmail.com> 1570473767 +0100
> +data 24
> +s/4/A/ + add other-file
> +from :4
> +M 100644 :5 file
> +M 100644 :49 other-file
> +
> +commit refs/heads/mode-only-change
> +mark :58
> +author Thomas Rast <trast@inf.ethz.ch> 1374485036 +0200
> +committer Thomas Gummerer <t.gummerer@gmail.com> 1570473768 +0100
> +data 33
> +s/11/B/ + mode change other-file
> +from :57
> +M 100644 :7 file
> +M 100755 :49 other-file
> +
> +commit refs/heads/mode-only-change
> +mark :59
> +author Thomas Rast <trast@inf.ethz.ch> 1374485044 +0200
> +committer Thomas Gummerer <t.gummerer@gmail.com> 1570473768 +0100
> +data 8
> +s/12/B/
> +from :58
> +M 100644 :9 file
> +
> --
> 2.23.0.501.gb744c3af07
>
>

--8323328-920009355-1570563891=:46--
