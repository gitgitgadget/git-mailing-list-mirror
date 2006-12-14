X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Arkadiusz Miskiewicz <arekm@maven.pl>
Subject: Re: svn versus git
Date: Thu, 14 Dec 2006 23:13:27 +0100
Organization: SelfOrganizing
Message-ID: <200612142313.27741.arekm@maven.pl>
References: <200612132200.41420.andyparkins@gmail.com> <200612142000.54409.arekm@maven.pl> <4581CB38.8050401@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Thu, 14 Dec 2006 22:13:50 +0000 (UTC)
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.5
In-Reply-To: <4581CB38.8050401@op5.se>
Content-Disposition: inline
X-Authenticated-Id: arekm
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34416>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Guypo-0000Pb-8S for gcvg-git@gmane.org; Thu, 14 Dec
 2006 23:13:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751841AbWLNWNp convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006 17:13:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751850AbWLNWNp
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 17:13:45 -0500
Received: from outgoing1.smtp.agnat.pl ([193.239.44.83]:57479 "EHLO
 outgoing1.smtp.agnat.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1751841AbWLNWNo convert rfc822-to-8bit (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006 17:13:44 -0500
Received: from [83.11.30.20] (helo=[192.168.0.64]) by tekla.agnat.pl with
 esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256) (Exim 4.63) (envelope-from
 <arekm@maven.pl>) id 1GuypX-0006Uu-9X; Thu, 14 Dec 2006 23:13:31 +0100
To: Andreas Ericsson <ae@op5.se>
Sender: git-owner@vger.kernel.org

On Thursday 14 December 2006 23:07, Andreas Ericsson wrote:

> > ps. I'm blind or there is no documentation about what utilities are
> > needed to get git fully working? (like sed, coreutils, grep, rcs pa=
ckage
> > (merge tool afaik needed)...).
>
> perl and the standard coreutils, which afaik are required to be prese=
nt
> on all unix systems.=20
That's not all. sed and grep is also used. There may be some others hid=
den=20
deep in git and it would be good to have that docummented (I've hit the=
=20
problem already with missing some tool when preparing chroot for git).

> We no longer require external merge tools.=20
Starting from which version?

--=20
Arkadiusz Mi=B6kiewicz        PLD/Linux Team
