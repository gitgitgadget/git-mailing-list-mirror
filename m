From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: Re: [BUG] encoding problem with format-patch + send-email
Date: Mon, 19 Nov 2007 11:49:50 +0100
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20071119104950.GB8645@informatik.uni-freiburg.de>
References: <20071115105726.GA18555@bre-cln-ukleine.digi.com> <20071116104907.GA13087@sigill.intra.peff.net> <7vlk8xwvbu.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Brian Swetland <swetland@google.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Nicolas Pitre <nico@cam.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 19 11:50:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iu4D7-0002LV-Kk
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 11:50:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751818AbXKSKuU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Nov 2007 05:50:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751666AbXKSKuU
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 05:50:20 -0500
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:55863 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751498AbXKSKuS (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Nov 2007 05:50:18 -0500
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.68)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1Iu4Cn-00062w-1M; Mon, 19 Nov 2007 11:50:17 +0100
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id lAJAo2ls009692;
	Mon, 19 Nov 2007 11:50:02 +0100 (MET)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id lAJAnolv009613;
	Mon, 19 Nov 2007 11:49:50 +0100 (MET)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, Brian Swetland <swetland@google.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Nicolas Pitre <nico@cam.org>
Content-Disposition: inline
In-Reply-To: <7vlk8xwvbu.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65422>

Hello Jeff

Brian sent another mail to the linux-arm-kernel mailing list, now
spotting:

	Content-Type: text/plain; charset=3DUTF-8

but no Content-Transfer-Encoding:.  This yield a 7bit mail with 8bit
characters.

I think we should add

	Content-Transfer-Encoding: 8bit

, too.

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig

$ dc << EOF
[d1-d1<a]sa99d1<a1[rdn555760928P*pz1<a]salax
EOF
