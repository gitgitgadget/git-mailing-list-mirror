Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B990E207EC
	for <e@80x24.org>; Mon,  3 Oct 2016 12:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751687AbcJCM57 (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 08:57:59 -0400
Received: from relay5.ptmail.sapo.pt ([212.55.154.25]:34580 "EHLO sapo.pt"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750975AbcJCM56 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 08:57:58 -0400
Received: (qmail 8842 invoked from network); 3 Oct 2016 12:57:55 -0000
Received: (qmail 22767 invoked from network); 3 Oct 2016 12:57:55 -0000
Received: from unknown (HELO catarina) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <patthoyts@users.sourceforge.net>; 3 Oct 2016 12:57:53 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
Message-ID: <1475499472.1776.26.camel@sapo.pt>
Subject: Re: [PATCH 1/5] git-gui i18n: mark strings for translation
From:   Vasco Almeida <vascomalmeida@sapo.pt>
To:     patthoyts@users.sourceforge.net
Cc:     git@vger.kernel.org, "Shawn O . Pearce" <spearce@spearce.org>
Date:   Mon, 03 Oct 2016 12:57:52 +0000
In-Reply-To: <8760p9wwr3.fsf@red.patthoyts.tk>
References: <1462704778-4722-1-git-send-email-vascomalmeida@sapo.pt>
         <8760p9wwr3.fsf@red.patthoyts.tk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A Seg, 03-10-2016 às 11:30 +0100, Pat Thoyts escreveu:
> Vasco Almeida <vascomalmeida@sapo.pt> writes:
> 
> > 
> > Mark strings for translation in lib/index.tcl that were seemingly
> > left behind by 700e560 ("git-gui: Mark forgotten strings for
> > translation.", 2008-09-04) which marks string in
> > do_revert_selection
> > procedure.
> > These strings are passed to unstage_help and add_helper procedures.
> > 
> > Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
> > ---
> > lib/index.tcl | 6 +++---
> > 1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/lib/index.tcl b/lib/index.tcl
> > index 74a81a7..3a3e534 100644
> > --- a/lib/index.tcl
> > +++ b/lib/index.tcl
> > @@ -291,7 +291,7 @@ proc do_unstage_selection {} {
> > 
> > 	if {[array size selected_paths] > 0} {
> > 		unstage_helper \
> > -			{Unstaging selected files from commit} \
> > +			[mc "Unstaging selected files from
> > commit"] \
> > 			[array names selected_paths]
> > 	} elseif {$current_diff_path ne {}} {
> > 		unstage_helper \
> > @@ -343,7 +343,7 @@ proc do_add_selection {} {
> > 
> > 	if {[array size selected_paths] > 0} {
> > 		add_helper \
> > -			{Adding selected files} \
> > +			[mc "Adding selected files"] \
> > 			[array names selected_paths]
> > 	} elseif {$current_diff_path ne {}} {
> > 		add_helper \
> > @@ -385,7 +385,7 @@ proc do_add_all {} {
> > 			set paths [concat $paths $untracked_paths]
> > 		}
> > 	}
> > -	add_helper {Adding all changed files} $paths
> > +	add_helper [mc "Adding all changed files"] $paths
> > }
> > 
> > proc revert_helper {txt paths} {
> 
> This series looks good. Especially noticing the misuse of the append
> command. Applied to my pu for now.
> Thank you,

I think Junio Hamano added PATCH 1/5 of this series to Git 'next'
branch and added the Portuguese translation of git-gui too.
