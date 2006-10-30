X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Edgar Toernig <froese@gmx.de>
Subject: Re: [PATCH/RFC (take 2)] gitweb: New improved patchset view
Date: Mon, 30 Oct 2006 23:30:17 +0100
Message-ID: <20061030233017.19f25117.froese@gmx.de>
References: <850923.44762.qm@web31812.mail.mud.yahoo.com>
	<200610302250.06733.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 30 Oct 2006 22:33:59 +0000 (UTC)
Cc: ltuikov@yahoo.com, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #271361
In-Reply-To: <200610302250.06733.jnareb@gmail.com>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30536>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GefeI-0002f7-LC for gcvg-git@gmane.org; Mon, 30 Oct
 2006 23:30:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965183AbWJ3Wa0 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 30 Oct 2006
 17:30:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965518AbWJ3Wa0
 (ORCPT <rfc822;git-outgoing>); Mon, 30 Oct 2006 17:30:26 -0500
Received: from mail.gmx.net ([213.165.64.20]:40856 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S965183AbWJ3Wa0 (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 30 Oct 2006 17:30:26 -0500
Received: (qmail invoked by alias); 30 Oct 2006 22:30:24 -0000
Received: from p50903DB1.dip0.t-ipconnect.de (EHLO dialup) [80.144.61.177] by
 mail.gmx.net (mp039) with SMTP; 30 Oct 2006 23:30:24 +0100
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski wrote:
>
> I'm just saying that with HTML diffs, presented via gitweb in graphical
> web browser, you have more possibilities, more formatting to use.

It would be nice though, when the gitweb output would be readable
on non css-capable browsers (i.e. w3m) too.  At the moment, gitweb
is mostly usable - the only problematic case is code and diffs.
These are presented via div-tags so in a non-css browser, all spaces
are collapsed thereby removing all indentation.  Couldn't code
fragments be presented via (styled) pre-tags for backward compatibility?
Pretty please :)

Btw, while the css version looks nice, Opera seems to have extreme
performance problems with gitweb's project page when there are a lot
of repositories.  I.e. trying to view http://gitweb.freedesktop.org/
brings my system to its knees.  Turning off style sheets cures it
but then diffs are unusable ...

