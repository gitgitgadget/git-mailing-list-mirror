Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B60A5208DB
	for <e@80x24.org>; Sat, 26 Aug 2017 00:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754690AbdHZAcd (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Aug 2017 20:32:33 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:32964 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754171AbdHZAcd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Aug 2017 20:32:33 -0400
Received: by mail-pg0-f41.google.com with SMTP id t3so6872160pgt.0
        for <git@vger.kernel.org>; Fri, 25 Aug 2017 17:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OWx3g2G2SnUTSthol1I0KCP4iuZt6PmkrM77O92EyKU=;
        b=CxRRhMXJ6xQHd5+psCU1X4zeiA76Lg2DCB1rJzEs25mvQBiyHo4divKNjH5+10Uz3M
         CRSFgmJvheiF1ReCmU3nKja6+tmZNvf7wA6pG8z3M21n8DEZYBAOBHRSZrNsQ/zn1D9B
         TncNtP9lZ80qARWwT09/6IjlSX7qnK4itoi42zvcvexTe+0dmKlXWEgZDGdVxduR3aOm
         VCWIDm9mameQslQO9nYhqSE1ObTXuWmYGDjNXRF2QlzNlpm7FTSPFVNlkb9BczhK0lIg
         wB62UE+N2asFfMNwk3LeB7CcOinLxQqu8L2gBxqA4T945FKrAdGjCCG1l5tcoFiBI8EI
         cC8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OWx3g2G2SnUTSthol1I0KCP4iuZt6PmkrM77O92EyKU=;
        b=eyhm2L8D+IRF1yV7v2VN+GlYo5t1+w+YuLDfemJz49lHGka7boUSuDL58iow1w+rSD
         zjv+2BAgwmaYzgf70zpjIQ704PkUi73lXO0bkia74Hmc+njT77VDMaDzsnvAYZNKCuRG
         zNpnavz9LNrQxcox8ddXCi3h68hP3EsuS/uJMShXvEPeV71ojd9LTTfR965FwoZtg/7K
         qhnVa2AGdAOGsfGe3gZitg/HhHXuL/c25QyStHsW03edJWpKNiwRPaxm9t9s0Uq3X540
         tvUCUsVB3w7WDSXBrYHBpMQksyeX/aiaJC27rJezZsZapHDD3HLEg8gdVl8o6Sinng4a
         3xiQ==
X-Gm-Message-State: AHYfb5hLvO51zTn48WyANxfPB3GuOgPL2/vbxQHNBtDY/fyrnvCSqTLQ
        QjZ8S1bTJ3Mezw==
X-Received: by 10.98.90.131 with SMTP id o125mr252656pfb.222.1503707551895;
        Fri, 25 Aug 2017 17:32:31 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:8815:a6fe:ee7d:9520])
        by smtp.gmail.com with ESMTPSA id u72sm14035426pfk.122.2017.08.25.17.32.31
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 25 Aug 2017 17:32:31 -0700 (PDT)
Date:   Fri, 25 Aug 2017 17:32:29 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Ian Jackson <ijackson@chiark.greenend.org.uk>
Cc:     git@vger.kernel.org, Dave Borowitz <dborowitz@google.com>
Subject: Re: git signed push server-side
Message-ID: <20170826003229.GL13924@aiede.mtv.corp.google.com>
References: <22944.38288.91698.811743@chiark.greenend.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22944.38288.91698.811743@chiark.greenend.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

+Dave Borowitz, who implemented push cert handling in JGit and Gerrit
Hi Ian,

Ian Jackson wrote[1]:

> I have been investigating git signed pushes.  I found a number of
> infelicities in the server side implementation which make using this
> in practice rather difficult.  I'm emailing here (before writing
> patches) to see what people think of my proposed changes.
>
> 1. PUSH_CERT_KEY has truncated keyid (Debian #852647)
>
> I see this:
>   GIT_PUSH_CERT_KEY=A3DBCBC039B13D8A
>
> There is almost no purpose for which this 64-bit keyid can be safely
> used.  The full key fingerprint should be provided instead.
>
> Proposed change: provide the full fingerprint instead.  Do this
> for every caller of gpg-interface.c.

Sounds sane.

> 2. git-receive-pack calls gpg (Debian #852684)
>
> It would be better if it called gpgv.  gpg does all sorts of
> complicated things, including automatically starting or connecting to
> a gpg-agent, which are not appropriate for use in a daemon on a
> server.
>
> Additionally, I find that passing -c gpg.program=/usr/bin/gpgv
> to git receive-pack is not effective, and there seems to be no
> sensible way to specify the keyrings to use (although that could be
> done by setting GNUPGHOME perhaps).
>
> Proposed change: call gpgv instead (and make any needed changes to
> adapt to gpgv).  Do this only when we are in git-receive-pack; other
> call sites of gpg-interface.c will continue to use gpg.

I think respecting gpg.program would be nicer.  Is there a reason not
to do that?

I suspect receive-pack just forgot to call git_gpg_config.

> 3. No way to specify keyring (Debian #852684, side note)
>
> There should be a way to specify the keyring used by
> git-receive-pack's gpgv invocation.  This should probably be done with
> a config option, receive.certKeyring perhaps.

How is the keyring configured for other commands that use GPG, like
"git tag -v"?  (Forgive my laziness in not looking it up.)

> 4. Trouble with the nonce (Debian #852688 part 2)
>
> To use the signed push feature it is necessary to provide a nonce seed
> to git-receive-pack.
>
> The docs say the seed must be secret but there is no documented way to
> pass this seed to git that does not either write it to a git
> configuration file somewhere, or pass it on a command line.  The git
> configuration system is unsuited to keeping secrets.  Command lines
> can be seen in ps etc.
[...]
> Proposed fix (in two parts):
>
> (i) Provide a new config option receive.certNonceSeedsFile.  It
> contains seeds, one per line.  When stateless_rpc, we send a nonce
> computed from the first seed.  We accept nonces computed from any of
> the listed seeds.  The documentation will say that the file should
> normally contain two seeds; rollover is achieved by mving into place a
> new seed at the top, and dropping one from the bottom.  An example
> script will be provided.

I like it.

I also wonder why you say the git configuration system is unsuited to
keeping secrets.  E.g. passing an include.path setting with -c or
GIT_CONFIG_PARAMETERS should avoid the kinds of trouble you described.
Is there a change we could make to make it work better?  That said, I
think being able to name a file is a good idea.

> (ii) At some later point, the following enhancement: When
> !stateless_rpc, certNonceSeedsFile is ignored except that if neither
> it nor the old certNonceSeed is set, the signed push feature is
> disabled.

That seems like an awkward interface.  Shouldn't there be at least
another config variable to enable signed push without making up a seed
or filename?

>            In this state we always get a fresh nonce (from a suitable
> system random source).

How does this work with stateless_rpc?  (See "Session State" in
Documentation/technical/http-protocol.txt.)

>                         Nontrivial because current git doesn't seem to
> have a "get suitable random number" function, and the mess that is the
> semantics of /dev/*random* files means that providing one is going to
> be controversial.

I think you're overestimating how much pushback adding such a thing
would get.

> 5. There are no docs on how to use this feature properly
>    (Debian #852695, #852688 part 1)
>
> Using the signed push feature requires careful programming on the
> server side.  There should be a doc explaining how to do this.
>
> Proposed fix: provide a .txt file containing much the same contents as
> seen here:
>   https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=852695

Yes, that sounds like a very welcome kind of thing to add.

More references:

- JGit's push cert handling:
  https://git.eclipse.org/r/#/q/message:cert

- Gerrit's push cert handling:
  https://gerrit-review.googlesource.com/q/project:gerrit+message:gpg

I haven't been able to find much in terms of docs for the feature.
There is https://gerrit-review.googlesource.com/Documentation/config-gerrit.html#receive.trustedKey
and https://gerrit-review.googlesource.com/Documentation/config-project-config.html#receive.enableSignedPush.
If signed push is enabled but not required for a repository then if I
remember correctly it is able to show whether an upload was signed by
a trusted key, as context during a review.

Thanks and hope that helps,
Jonathan

[1] https://public-inbox.org/git/22944.38288.91698.811743@chiark.greenend.org.uk/
