Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8905F1FC96
	for <e@80x24.org>; Tue, 29 Nov 2016 18:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751168AbcK2Su1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Nov 2016 13:50:27 -0500
Received: from sym2.noone.org ([178.63.92.236]:53589 "EHLO sym2.noone.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752844AbcK2SuZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2016 13:50:25 -0500
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 3tSt0H0BN4zQWdP; Tue, 29 Nov 2016 19:50:20 +0100 (CET)
Date:   Tue, 29 Nov 2016 19:50:20 +0100
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] RelNotes: typo fix in 2.11.0 notes
Message-ID: <20161129185017.GA22467@distanz.ch>
References: <xmqqinrdlr3o.fsf@gitster.mtv.corp.google.com>
 <20161129095725.13280-1-tklauser@distanz.ch>
 <xmqqbmwygmmd.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqbmwygmmd.fsf@gitster.mtv.corp.google.com>
X-Editor: Vi IMproved 7.3
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2016-11-29 at 19:35:38 +0100, Junio C Hamano <gitster@pobox.com> wrote:
> Tobias Klauser <tklauser@distanz.ch> writes:
> 
> > s/paht/path/ in the "Backwards compatibility notes" section of the
> > 2.11.0 release notes.
> >
> > Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> > ---
> 
> This looks somewhat familiar.  Perhaps
> 
>   https://public-inbox.org/git/1477668782.1869.4.camel@seestieto.com/

Oops, certainly didn't read carefiul enough. Sorry for the noise and
thanks for the reference.

> >  Documentation/RelNotes/2.11.0.txt | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/RelNotes/2.11.0.txt b/Documentation/RelNotes/2.11.0.txt
> > index b7b7dd361ef0..4c8a9be60f52 100644
> > --- a/Documentation/RelNotes/2.11.0.txt
> > +++ b/Documentation/RelNotes/2.11.0.txt
> > @@ -5,7 +5,7 @@ Backward compatibility notes.
> >  
> >   * An empty string used as a pathspec element has always meant
> >     'everything matches', but it is too easy to write a script that
> > -   finds a path to remove in $path and run 'git rm "$paht"' by
> > +   finds a path to remove in $path and run 'git rm "$path"' by
> >     mistake (when the user meant to give "$path"), which ends up
> >     removing everything.  This release starts warning about the
> >     use of an empty string that is used for 'everything matches' and
> 
