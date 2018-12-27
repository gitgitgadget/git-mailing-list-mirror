Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65B10211BB
	for <e@80x24.org>; Thu, 27 Dec 2018 21:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730093AbeL0VZL (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Dec 2018 16:25:11 -0500
Received: from mout.gmx.net ([212.227.15.15]:42287 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728503AbeL0VZK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Dec 2018 16:25:10 -0500
Received: from DESKTOP-QUA364F ([46.183.103.8]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MD9NE-1gZOYF1duO-00GVHD; Thu, 27
 Dec 2018 22:25:04 +0100
Date:   Thu, 27 Dec 2018 22:24:51 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        git@vger.kernel.org, t.gummerer@gmail.com
Subject: Re: [PATCH v12 04/26] ident: add the ability to provide a "fallback
 identity"
In-Reply-To: <xmqqpntoq8zs.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1812272221380.45@tvgsbejvaqbjf.bet>
References: <cover.1545331726.git.ungureanupaulsebastian@gmail.com> <57a654887e652251ae966ec31b4604dc8222f9c6.1545331726.git.ungureanupaulsebastian@gmail.com> <xmqqpntoq8zs.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:BiL7W4SozWpd+z2BUYlzNPznpZ9xxxO8n00pHZta0e4Akuc7UTJ
 VshXfIZSdn3xfc7HnqcPy6IqwjInVhUIVXY2eNqk0wyKjwR184zB6cY3NK0Lj2fLSEm/Gwj
 5QBlbJ3eGyET89CbJUUORfFapK51+7ogXIs3rfm+6uLlOHtu4Crcw8reDl//X4/hAjlw6Ha
 VGTm4j2Uzh8HGa8aXz3WQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:m0dJESZkCco=:OnPKGHG/z0jEZ77ivKQllk
 Yc4KFb53R/Oe49BwUfhk0O9oDPcopT6VQpkwolHdZIUcL4huAOPXsVhQJVii36W+2mF9AXTMv
 kQcIvWl+rgB5Es7C4PNJ4taYg2GRQFIgAb5QRuiN34cw6BCM9lGSd37k5a+Px5ZnK6gttap+j
 bU+s5cukxGDkHs7aLhuIxbP6iBS2LjmSzuD160kOr8vwFMmm0G14taG2JXx9sp7wb0NDnUH61
 U6DdrGv+qM4ezJZK+53Vt2f5gh/dsClmTeMiMiGrafZ6BZIEgr8kY6smQ6o7LT/d6WDIUnqaJ
 zWLbfzlVz9Bj2vEg+APBCmdy8gjMDBCdHeufJpnu6giQzPBIM+qO9e2mmXTRmO9W2ayiyp9T7
 XKgZk42gQ9mKlqKoV/ebKOlZxixFkxq3x63sOhX+EAorLl+qKs9GC8spu8B8Ge7cZZo3wYLc1
 vENaNmX61sz+daXjKuekjEdH29gKER1yEIKzXzsO0f7Kf+LxkH7/pBZqCfTWR6JYIFyUh9n/J
 2884mUoBDWkugEcBPW/iNMz+RUj4CaCocy/WLa34lZbGeIPr5uSIhqpBx5Z8fKVM5vJLC/zEZ
 3TN10dOchq8Vc31dJGDyZwtyYaADhFrHcwpxQTKcTgSaQPVu1N6+5+sW9ztPIjybh7ZxPIVp9
 5i67mAfCKdn0vXRGlN3uzBc3feE0zKz+kJJb6vs2ayubpknE1ESD6C8dFmSEamk3nZCrZeCBO
 jHpBAv/iv/t7+11228ubqxP4Cme7sXNC6Qs+4jZQvXipvqoQu8OSE77bytybyKHLUY5ZOF2dy
 4IAOI/wh/HmRFQSl/skex0L9YQ5Q66DM2BzOEofa0QX7uEsHnVaeSQ/cJUMPHM/QRuKOn2kQs
 l92ptNfNE/Y6uEdvFPae4PzkG1ePrc86jkG6axUTJXSW2vPIYQfbcq13NUUnx8P/SlZAuGgQ+
 SL7caN9Ly1w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 26 Dec 2018, Junio C Hamano wrote:

> Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com> writes:
> 
> > +static void set_env_if(const char *key, const char *value, int *given, int bit)
> > +{
> > +	if ((*given & bit) || getenv(key))
> > +		return; /* nothing to do */
> > +	setenv(key, value, 0);
> > +	*given |= bit;
> > +}
> 
> We call setenv(3) with overwrite=0 but we protect the call with a
> check for existing value with getenv(3), which feels a bit like an
> anti-pattern.  Wouldn't the following be simpler to follow, I wonder?
> 
> 	if (!(*given & bit)) {
> 		setenv(key, value, 1);
> 		*given |= bit;
> 	}
> 
> The only case these two may behave differently is when '*given' does
> not have the 'bit' set but the environment 'key' already exists.

Indeed, this is the case where your version would actually do the wrong
thing. Imagine that GIT_AUTHOR_NAME is set already. Your code would
*override* it. But that is not what we want to do here. We want to *fall
back* if there is no already-configured value.

And of course we won't set the `given` bit if we don't fall back here;
that should be done somewhere else, where that environment variable (that
we *refuse* to overwrite) is *actually* used.

Ciao,
Dscho

> The proposed patch will leave 'bit' in '*given' unset, so when a
> later code says "let's see if author_ident is explicitly given, and
> complain otherwise", such a check will trigger and cause complaint.
> 
> On the other hand, the simplified version does not allow the
> "explicitly-given" bits to be left unset, so it won't cause
> complaint.
> 
> Isn't it a BUG() if *given lacks 'bit' when the corresponding
> environment variable 'key' is missing?  IOW, I would understand
> an implementation that is more elaborate than the simplified one I
> just gave above were something like
> 
> 	if (!(*given & bit)) {
> 		if (getenv(key))
> 			BUG("why does %s exist and no %x bit set???", key, bit);
> 		setenv(key, value, 0);
> 		*given |= bit;
> 	}
> 
> but I do not quite understand the reasoning behind the "check either
> the bit, or the environment variable" in the proposed patch.
> 
> > +void prepare_fallback_ident(const char *name, const char *email)
> > +{
> > +	set_env_if("GIT_AUTHOR_NAME", name,
> > +		   &author_ident_explicitly_given, IDENT_NAME_GIVEN);
> > +	set_env_if("GIT_AUTHOR_EMAIL", email,
> > +		   &author_ident_explicitly_given, IDENT_MAIL_GIVEN);
> > +	set_env_if("GIT_COMMITTER_NAME", name,
> > +		   &committer_ident_explicitly_given, IDENT_NAME_GIVEN);
> > +	set_env_if("GIT_COMMITTER_EMAIL", email,
> > +		   &committer_ident_explicitly_given, IDENT_MAIL_GIVEN);
> > +}
> 
> Introducing this function alone without a caller and without
> function doc is a bit unfriendly to future callers, who must be
> careful when to call it, I think.  For example, they must know that
> it will be a disaster if they call this before they call
> git_ident_config(), right?
> 
> > +
> >  static int buf_cmp(const char *a_begin, const char *a_end,
> >  		   const char *b_begin, const char *b_end)
> >  {
> 
> 
> 
