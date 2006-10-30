X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] gitweb: esc_html() author in blame
Date: Mon, 30 Oct 2006 14:49:14 -0800 (PST)
Message-ID: <429284.77209.qm@web31808.mail.mud.yahoo.com>
References: <7vu01lv48z.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Mon, 30 Oct 2006 22:49:46 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=SLZ5BeX0KCjeKEAc7UJxZ9+lvj9JRdPXsFqoHz8bU2ry0Fy4tPwJMD/8sc0X2k4Af9aZ0bOIfqLkSRbxZnZp7VCJy0FYzsXb3vQwQPRBTzt2IFNFch75ciIIRM94vVs1ntNbySiUb3VFSDEdtF3T3flFV7Bcq9B3xbJTAhFon0Y=  ;
X-YMail-OSG: suTvxEkVM1mBD5wHDsqJ.ZcH_bof4ALRsuaLuQ8TkyE28lz0OEEdnBiSYsB37X3g0_M.KRrH4.JWQ6.wMFwr2vu8bsRZSr29d9mHRFVLauMuZ7hQAHaKwhMKFPS7rE9Qe0q.rndSyBc-
In-Reply-To: <7vu01lv48z.fsf@assigned-by-dhcp.cox.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30544>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GefwV-0006QW-3G for gcvg-git@gmane.org; Mon, 30 Oct
 2006 23:49:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422696AbWJ3WtQ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 30 Oct 2006
 17:49:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422730AbWJ3WtQ
 (ORCPT <rfc822;git-outgoing>); Mon, 30 Oct 2006 17:49:16 -0500
Received: from web31808.mail.mud.yahoo.com ([68.142.207.71]:47477 "HELO
 web31808.mail.mud.yahoo.com") by vger.kernel.org with SMTP id
 S1422696AbWJ3WtP (ORCPT <rfc822;git@vger.kernel.org>); Mon, 30 Oct 2006
 17:49:15 -0500
Received: (qmail 77255 invoked by uid 60001); 30 Oct 2006 22:49:14 -0000
Received: from [64.215.88.90] by web31808.mail.mud.yahoo.com via HTTP; Mon,
 30 Oct 2006 14:49:14 PST
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Sender: git-owner@vger.kernel.org

--- Junio C Hamano <junkio@cox.net> wrote:
> Luben Tuikov <ltuikov@yahoo.com> writes:
> 
> > Blame fails for example on
> > block/ll_rw_blk.c at v2.6.19-rc3.
> >
> > Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>
> 
> Some quoting may be needed there, but is esc_html the right quoting?
> Ack, somebody?

I don't know if it is the right quoting.  esc_html() seemed to be
used elsewhere for $author, and it seemed to work in this particular
case.

    Luben
