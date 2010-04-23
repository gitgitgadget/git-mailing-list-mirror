Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=1.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INVALID_MSGID,MSGID_NOFQDN1,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: (qmail 16798 invoked by uid 107); 23 Apr 2010 15:03:58 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.180.67)
    by peff.net (qpsmtpd/0.40) with ESMTP; Fri, 23 Apr 2010 11:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755444Ab0DWPDo (ORCPT <rfc822;peff@peff.net>);
	Fri, 23 Apr 2010 11:03:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:57793 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755060Ab0DWPDn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Apr 2010 11:03:43 -0400
Received: (qmail invoked by alias); 23 Apr 2010 15:03:41 -0000
Received: from dinoc9.indmath.uni-linz.ac.at (EHLO localhost) [140.78.117.79]
  by mail.gmx.net (mp049) with SMTP; 23 Apr 2010 17:03:41 +0200
X-Authenticated: #25381063
X-Provags-ID: V01U2FsdGVkX1+hRrJY0PKhBiMPm/7WXxSbRhq7jPE2CMRBulsrVZ
	NbZhR+o4823vua
Date:	Fri, 23 Apr 2010 17:03:38 +0200
From:	Konrad Karl <kk_konrad@gmx.at>
To:	Michael J Gruber <git@drmicha.warpmail.net>
Cc:	Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
Subject: Re: multiple .gitignore and friends in same workdir possible?
Message-ID: <20100423150338.GA26487localhost>
References: <4526533254752708319@unknownmsgid>
 <y2kfabb9a1e1004230601zcede9e2ah2db8cb0f082bcbb4@mail.gmail.com>
 <7537.06050240925$1272033186@news.gmane.org>
 <4BD1B3AD.50407@drmicha.warpmail.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4BD1B3AD.50407@drmicha.warpmail.net>
User-Agent: Mutt/1.5.20 (2009-08-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64000000000000001
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Apr 23, 2010 at 04:50:21PM +0200, Michael J Gruber wrote:
> Konrad Karl venit, vidit, dixit 23.04.2010 16:32:
> > Hi
> > 
> > On Fri, Apr 23, 2010 at 03:01:42PM +0200, Sverre Rabbelier wrote:
> >> Heya,
> >>
[ ...... ]
> > so if there was some way to _not_ consider the standard .gitignore &friends
> > I would be happy to live with.
> 
> If you control the creation of the repos, why don't you simply leave the
> standard .gitignore empty and use the config as suggested by Sverre?

Because this information does not getting transfered with git clone.

People have the chance to forget to set this variable after cloning the
source repo and they will. 

Konrad

> 
> Michael
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
