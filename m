X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: git-merge-recursive segmentation error
Date: Tue, 19 Dec 2006 18:18:59 -0800 (PST)
Message-ID: <427701.7195.qm@web31811.mail.mud.yahoo.com>
References: <Pine.LNX.4.63.0612200217300.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Wed, 20 Dec 2006 02:19:07 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=GZpD4svT1FZ+ekbO+3OcK+iGETBjDhKVUx/vnpkoq9RrwfHypJ18NJY8quhh8CzV258KmCCTIiy5qx9zCaFGzV+hR/l47SA3rnLMEfkstSy+FVLBCzna2ZCzgwlIrdjOkKtD+EIoFTwp9qON2sjvy1qioRTkBLwg8E+Rm7uc0Lo=;
X-YMail-OSG: _OJLM4QVM1lw4AINn5KTynUMes.wYdgwP98Gd1VdFPCyI8OlgivwEMZpbzSFMC9kIdBEU5KRSiXt_PvzgPpuPmV70pTOPEuGW9pcm.7rfpFksxNZhSQmQX3Qzt_4cEh.YPVS8ZZfeBg-
In-Reply-To: <Pine.LNX.4.63.0612200217300.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34893>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gwr2v-0008Lx-FU for gcvg-git@gmane.org; Wed, 20 Dec
 2006 03:19:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964780AbWLTCTB (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 21:19:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964781AbWLTCTA
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 21:19:00 -0500
Received: from web31811.mail.mud.yahoo.com ([68.142.207.74]:33420 "HELO
 web31811.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 SMTP id S964780AbWLTCTA (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec
 2006 21:19:00 -0500
Received: (qmail 9732 invoked by uid 60001); 20 Dec 2006 02:18:59 -0000
Received: from [64.215.88.90] by web31811.mail.mud.yahoo.com via HTTP; Tue,
 19 Dec 2006 18:18:59 PST
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

--- Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
> 
> On Tue, 19 Dec 2006, Luben Tuikov wrote:
> 
> > Auto-merging init/version.c
> > /home/luben/bin/git-merge: line 394: 12030 
> > Segmentation fault git-merge-$strategy $common -- "$head_arg" "$@"
> 
> Do you have any pointers how to get the two branches you try to merge? I'd 
> be most grateful to have the sha1's of both heads, too...

The source tree is Linus' "master" tree.  The destination tree
is my own "dev" tree, which I use as an intermediate tree, before 
merging into my own kernel trees.

Hopefully with the backtrace I posted and with the big-bisect
results pointing to the culprit commit, someone can get a patch out
to fix this.

    Luben
