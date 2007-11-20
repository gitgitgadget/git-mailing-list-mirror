From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: Re: [PATCH] send-email: add transfer encoding header with content-type
Date: Tue, 20 Nov 2007 14:49:34 +0100
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20071120134934.GA546@informatik.uni-freiburg.de>
References: <20071115105726.GA18555@bre-cln-ukleine.digi.com> <20071116104907.GA13087@sigill.intra.peff.net> <7vlk8xwvbu.fsf@gitster.siamese.dyndns.org> <20071119104950.GB8645@informatik.uni-freiburg.de> <20071120125404.GB7998@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Brian Swetland <swetland@google.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Nicolas Pitre <nico@cam.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 20 14:50:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuTUP-0006Sf-T7
	for gcvg-git-2@gmane.org; Tue, 20 Nov 2007 14:50:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752083AbXKTNtw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Nov 2007 08:49:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752015AbXKTNtw
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Nov 2007 08:49:52 -0500
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:33752 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752013AbXKTNtv (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Nov 2007 08:49:51 -0500
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.68)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1IuTU6-0005Bv-1d; Tue, 20 Nov 2007 14:49:50 +0100
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id lAKDnaFb000565;
	Tue, 20 Nov 2007 14:49:36 +0100 (MET)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id lAKDnY5G000564;
	Tue, 20 Nov 2007 14:49:34 +0100 (MET)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, Brian Swetland <swetland@google.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Nicolas Pitre <nico@cam.org>
Content-Disposition: inline
In-Reply-To: <20071120125404.GB7998@sigill.intra.peff.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65546>

Hello,

Jeff King wrote:
> We add the content-type header only when we have non-7bit
> characters from the 'From' header, so we really need to
> specify the encoding (in other cases, where the commit text
> needed a content-type, git-format-patch will already have
> added the encoding header).
>=20
> Signed-off-by: Jeff King <peff@peff.net>
Acked-by: Uwe Kleine-K=F6nig <ukleinek@informatik.uni-freiburg.de>

--=20
Uwe Kleine-K=F6nig

$ dc << EOF
[d1-d1<a]sa99d1<a1[rdn555760928P*pz1<a]salax
EOF
