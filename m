Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8894F202DA
	for <e@80x24.org>; Tue,  7 Mar 2017 14:32:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932555AbdCGOcb (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Mar 2017 09:32:31 -0500
Received: from mout.gmx.net ([212.227.15.15]:52888 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755577AbdCGOcS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2017 09:32:18 -0500
Received: from virtualbox ([37.201.194.72]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LzblK-1cFl8l3r98-014jhr; Tue, 07
 Mar 2017 15:31:46 +0100
Date:   Tue, 7 Mar 2017 15:31:43 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 0/9] Fix the early config
In-Reply-To: <20170304073952.drfgy7jacnlm6tum@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1703071314180.3767@virtualbox>
References: <cover.1488506615.git.johannes.schindelin@gmx.de> <cover.1488562287.git.johannes.schindelin@gmx.de> <20170304073952.drfgy7jacnlm6tum@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:JbzeKwv0jX3e7Zh3SQm0cu+f1xw9jLmYtsGruaIb7cZC3AHopZC
 gduHyOMkJYrO89qVhL9R/+ieabuqds6+SocRSfV40ptkCykg2laTcdwk+TLf0KOAELOKjC2
 YoNl65ZbBKNyTj2iN3pQaZvRJr1rR93/8SSkziqF3pF4wEaIOoDkmd1pzgf96QrPmyKTt3f
 lr0B3W0Rb7fXnVhQvbMcA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LbEhlj4hjUY=:laZDMsf+L2VmBA62gBCdvn
 wXlzPBgY6H5h9Ehj3VhlGCfhiVN1u1d85S0lX1qGPyVMzIStPOYP/E3vgTH/FQA1rlaJsutEV
 ma2RbRVu89NdbFilOnJY/gSvLxxictxC9VDd1B6hfvs1w9cFLWI2/heV59hEljeIEe0zI4TY0
 JQKF+OQ0jdoy1w5Z8ihg2Wg3amsDOQ7JrCLM8WykD4Ea639Kvy/XVvVcvW3uJPHMISEa7+Dgj
 pTZvDI3hLFFcEbO3B1i/xtrZdHfZ78Lqow9IEWoBPS3axfpNbxcHQ2Z3+CUKyguoMSjX9z2Xx
 Uhgl/eYgbT634INq3nPUUo5nJ86ORQN2zZW5sjjT95M5hVMpimyuD7HMt9i37PmSevGdm55Qj
 KWQFJ+orVXbDAcHhzvOng3rQlI3G65vsB5T2hPRPah89r1HCZor/Rv7gooFn/q1VJenu+1Uj/
 ySDr4SyTaVMvhbb7nvNGi2ZkfcyEZwv2kso8e5pURNVCSnKKBFfYKrKpuSvvv81H1jkYCDUVn
 Bewb1zpu2XcZrecIkDVQVjDeGU9Iic6WRaBbU6sBoBxO4EcX8QV3BN82erPzPdGCBoAPbCcW9
 9LojpMyKAb1j6MF7tkfIGSiJntX+Ia3gfqNAdqkamqmdJaSRTT+eIEEFX/QKgyKlFHfIm6eM7
 NfvJd0Bp/Et4Bw0V7V0T+uiNzTqB8gj9/Rvf4UfUHXIUHYCOZAQNlvilrVIiML2+zwobrRc/y
 CW4pan3fLDPOPbBYCJl7PVlY7JeLo6hB2jWBNcjjAx0jFQYMUPzAjlAFD2bcSBvjzE3xR5TBJ
 P0JEYl8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Sat, 4 Mar 2017, Jeff King wrote:

> On Fri, Mar 03, 2017 at 06:31:55PM +0100, Johannes Schindelin wrote:
> 
> > Interdiff vs v2:
> > [...]
> >  +	 * When we are not about to create a repository ourselves (init or
> >  +	 * clone) and when no .git/ directory was set up yet (in which case
> >  +	 * git_config_with_options() would already have picked up the
> >  +	 * repository config), we ask discover_git_directory() to figure out
> >  +	 * whether there is any repository config we should use (but unlike
> >  +	 * setup_git_directory_gently(), no global state is changed, most
> >  +	 * notably, the current working directory is still the same after
> >  +	 * the call).
> >   	 */
> >  -	if (!startup_info->creating_repository && !have_git_dir() &&
> >  -	    discover_git_directory(&buf)) {
> >  +	if (!have_git_dir() && discover_git_directory(&buf)) {
> 
> I think this "when we are not about to..." part of the comment is no
> longer true, given the second part of the hunk.

Yep, that was a stale part of that patch. Thanks for noticing!

> >  @@ -721,8 +721,10 @@ static const char *setup_discovered_git_dir(const char *gitdir,
> >   	if (offset == cwd->len)
> >   		return NULL;
> >   
> >  -	/* Make "offset" point to past the '/', and add a '/' at the end */
> >  -	offset++;
> >  +	/* Make "offset" point past the '/' (already the case for root dirs) */
> >  +	if (offset != offset_1st_component(cwd->buf))
> >  +		offset++;
> 
> Nice. I was worried we would have to have a hacky "well, sometimes we
> don't add one here..." code, but using offset_1st_component says
> exactly what we mean.

Right. I also wanted to avoid that very, very much. My initial version
actually tried to detect whether cwd already has a trailing slash, but
then I figured that we can be much, much more precise here (and I am
really pleased how offset_1st_component() is *semantically* precise, i.e.
it describes very well what the code is supposed to do here).

> > +/* Find GIT_DIR without changing the working directory or other global state */
> >  extern const char *discover_git_directory(struct strbuf *gitdir);
> 
> The parts that actually confused me were the parameters (mostly whether
> gitdir was a directory to start looking in, or an output parameter). So
> maybe:
> 
>   /*
>    * Find GIT_DIR of the repository that contains the current working
>    * directory, without changing the working directory or other global
>    * state. The result is appended to gitdir. The return value is NULL
>    * if no repository was found, or gitdir->buf otherwise.
>    */

I changed it a little bit more. In particular, I changed the
discover_git_directory() function to return the pointer to the path
itself: it provides additional value, and if that is not what the caller
wants, they can use git_dir->buf just as well.

> This looks good to me aside from those few comment nits.

Thanks.

It is not obvious from the interdiff, but I had an incorrect fixup to 8/9
that actually wanted to go to 5/9: the code in
discover_git_repository() tests the repository version should be part of
the initial version of this function, of course.

There is one more thing I included in v4: when I (re-)implemented that
pre-command/post-command hook I was hinting at earlier, the test suite
identified a problem where an invalid .git file would prevent even `git
init` from working (it was actually much more complicated than that, but
the gist is that `git -p init` would fail, no matter how much sense it
may make to you to paginate an `init` run, it should still not fail,
right?). So I added a patch on top to fix that.

And another change: the GIT_DIR_NONE value was handled incorrectly in
discover_git_directory().

I am slightly disappointed that the these additional problems were not
spotted in any review but my own. And I had not even included a Duck.

> I'm still not sure I understand how ceil_offset works in
> setup_git_directory_gently_1(), but I don't think your patch actually
> changed it. I can live with my confusion.

Yes, that code is very confusing. It also does not help that the naming is
inconsistent in that it abbreviates "ceiling" but not "offset". What makes
it even worse is that the function name `longest_ancestor_length()` is
highly misleading: in Git's context, "ancestor" of sth pretty much always
refers to a commit reachable from sth, but in this context it refers to
the path of a directory containing sth.

So basically, we set ceil_offset to the offset of the last directory
separator in our path that corresponds to the most precise match in
GIT_CEILING_DIRECTORIES.

Example: given GIT_CEILING_DIRECTORIES /foo:/:/bar and a path of /foo/bar,
ceil_offset would be 4, pointing to the slash at the end of /foo/ because
that is the most precise match in GIT_CEILING_DIRECTORIES ("/" would also
match, but is less precise).

Later, setup_git_directory_gently_1() ensures that it does not go beyond
ceil_offset when looking for the parent directory as the next candidate to
test for .git/.

Hopefully that clears up the picture?

Ciao,
Dscho
