X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Edgar Toernig <froese@gmx.de>
Subject: Re: [PATCH/RFC (take 2)] gitweb: New improved patchset view
Date: Tue, 31 Oct 2006 23:41:01 +0100
Message-ID: <20061031234101.38e59ac9.froese@gmx.de>
References: <850923.44762.qm@web31812.mail.mud.yahoo.com>
	<200610302250.06733.jnareb@gmail.com>
	<20061030233017.19f25117.froese@gmx.de>
	<200610302339.55128.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 31 Oct 2006 22:41:21 +0000 (UTC)
Cc: ltuikov@yahoo.com, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #271361
In-Reply-To: <200610302339.55128.jnareb@gmail.com>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30603>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gf2IE-0006Hp-8W for gcvg-git@gmane.org; Tue, 31 Oct
 2006 23:41:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423864AbWJaWlJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 31 Oct 2006
 17:41:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423865AbWJaWlJ
 (ORCPT <rfc822;git-outgoing>); Tue, 31 Oct 2006 17:41:09 -0500
Received: from mail.gmx.net ([213.165.64.20]:24530 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1423864AbWJaWlG (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 31 Oct 2006 17:41:06 -0500
Received: (qmail invoked by alias); 31 Oct 2006 22:41:05 -0000
Received: from p50900B8B.dip0.t-ipconnect.de (EHLO dialup) [80.144.11.139] by
 mail.gmx.net (mp046) with SMTP; 31 Oct 2006 23:41:05 +0100
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski wrote:
>
> Edgar Toernig wrote:
>  
> > Btw, while the css version looks nice, Opera seems to have extreme
> > performance problems with gitweb's project page when there are a lot
> > of repositories.  I.e. trying to view http://gitweb.freedesktop.org/
> > brings my system to its knees.  Turning off style sheets cures it
> > but then diffs are unusable ...
> 
> Strange. It's just a simple table. Could you and would you be able to
> debug it further (e.g. by bisecting CSS)?

It's the combination of tr.light/dark:hover and background-color.
Changing the foreground instead of the background color is fast.
Maybe it recalculates the complete table when the background of
a table cell changes.

I've reported the problem to Opera ...

