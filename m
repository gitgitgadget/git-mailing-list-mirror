X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Arkadiusz Miskiewicz <arekm@maven.pl>
Subject: Re: reexporting git repository via git-daemon
Date: Sun, 10 Dec 2006 18:43:45 +0100
Organization: SelfOrganizing
Message-ID: <200612101843.45941.arekm@maven.pl>
References: <200612082212.09682.arekm@maven.pl> <elhgcf$m4r$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Sun, 10 Dec 2006 17:44:26 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.5
In-Reply-To: <elhgcf$m4r$1@sea.gmane.org>
Content-Disposition: inline
X-Authenticated-Id: arekm
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33907>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtSit-0006Xr-Qq for gcvg-git@gmane.org; Sun, 10 Dec
 2006 18:44:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1762284AbWLJRoV convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006 12:44:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762286AbWLJRoV
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 12:44:21 -0500
Received: from outgoing1.smtp.agnat.pl ([193.239.44.83]:55731 "EHLO
 outgoing1.smtp.agnat.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1762284AbWLJRoU convert rfc822-to-8bit (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 10 Dec 2006 12:44:20 -0500
Received: from [83.11.40.170] (helo=[192.168.0.64]) by tekla.agnat.pl with
 esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256) (Exim 4.63) (envelope-from
 <arekm@maven.pl>) id 1GtSih-00017y-Eo for git@vger.kernel.org; Sun, 10 Dec
 2006 18:44:13 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Sunday 10 December 2006 18:35, Jakub Narebski wrote:
> Arkadiusz Miskiewicz wrote:
> > I have weird problem wit git (1.4.4.2).
>
> I have tried to reproduce this error, but no luck.

Now I tracked that down to git-daemon in version 1.4.2.4 not 1.4.4.2. S=
eems=20
that something was later fixed, so 1.4.4.2 is OK.
|
--=20
Arkadiusz Mi=B6kiewicz        PLD/Linux Team
