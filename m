X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<zeisberg@informatik.uni-freiburg.de>
Subject: Re: [PATCH] Fix documentation copy&paste typo
Date: Tue, 19 Dec 2006 15:16:18 +0100
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20061219141618.GA2539@cepheus>
References: <11655782712452-git-send-email-zeisberg@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Tue, 19 Dec 2006 15:00:01 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Greylist: delayed 2597 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Dec 2006 09:59:48 EST
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <zeisberg@informatik.uni-freiburg.de>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <11655782712452-git-send-email-zeisberg@informatik.uni-freiburg.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34830>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GwgRh-0005wi-2f for gcvg-git@gmane.org; Tue, 19 Dec
 2006 15:59:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932822AbWLSO7t convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006 09:59:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932823AbWLSO7t
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 09:59:49 -0500
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:40129 "EHLO
 atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
 with ESMTP id S932822AbWLSO7s (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19
 Dec 2006 09:59:48 -0500
Received: from login.informatik.uni-freiburg.de ([132.230.151.6]) by
 atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168) (Exim
 4.60) (envelope-from <zeisberg@informatik.uni-freiburg.de>) id
 1Gwfle-0003qD-QZ; Tue, 19 Dec 2006 15:16:30 +0100
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1]) by
 login.informatik.uni-freiburg.de (8.13.7+Sun/8.12.11) with ESMTP id
 kBJEGS7D014980; Tue, 19 Dec 2006 15:16:28 +0100 (MET)
Received: (from zeisberg@localhost) by login.informatik.uni-freiburg.de
 (8.13.7+Sun/8.12.11/Submit) id kBJEGRhs014979; Tue, 19 Dec 2006 15:16:27
 +0100 (MET)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Hello Junio,

Uwe Kleine-K=F6nig wrote:
> From: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
>=20
> This was introduced in 45a3b12cfd3eaa05bbb0954790d5be5b8240a7b5
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <zeisberg@informatik.uni-freiburg.d=
e>
> ---
> [...]
you took that patch as bbee1d971dc07c29f840b439aa2a2c890a12cf9f, thanks
for that.

Somehow the '=F6' (o-umlaut) in my name was messed up.  If I do

	git cat-file -p bbee1d971dc07c29 | xxd | grep eine

I get:

	0000160: 6569 6e65 2d4b 1b2c 4143 361b 2842 6e69 eine-K.,AC6.(Bni

That is, the '=F6' became 8 byte long.  Can you tell me what went wrong
there?

The commits by Karl Hasselstr=F6m <kha@treskal.com> (e.g. e67c66251a416=
5)
use UTF-8.

Does there exist a (maybe project specific) convention for the encoding
of commit logs?

Best regards
Uwe

--=20
Uwe Kleine-Koenig

