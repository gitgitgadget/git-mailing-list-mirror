From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/3] archive: specfile syntax change: "$Format:%PLCHLDR$" instead of just "%PLCHLDR"
Date: Thu, 06 Sep 2007 16:17:17 -0700
Message-ID: <7vwsv38juq.fsf@gitster.siamese.dyndns.org>
References: <46DC4D45.4030208@lsrfire.ath.cx>
	<7vtzqb8fw2.fsf@gitster.siamese.dyndns.org> <46DCF0EF.9020604@op5.se>
	<Pine.LNX.4.64.0709041139140.28586@racer.site>
	<46DDE69C.1080908@lsrfire.ath.cx>
	<7vzm02klip.fsf@gitster.siamese.dyndns.org>
	<46E028B9.2090908@lsrfire.ath.cx>
	<Pine.LNX.4.64.0709061803590.28586@racer.site>
	<46E0647A.10000@lsrfire.ath.cx> <46E068BB.5080202@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andreas Ericsson <ae@op5.se>,
	Git Mailing List <git@vger.kernel.org>,
	Michael Gernoth <simigern@cip.informatik.uni-erlangen.de>,
	Thomas Glanzmann <thomas@glanzmann.de>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Fri Sep 07 01:17:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITQbM-0002gM-OL
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 01:17:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932599AbXIFXR1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 6 Sep 2007 19:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932592AbXIFXR1
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 19:17:27 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:33089 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932586AbXIFXR1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Sep 2007 19:17:27 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 085D212F7A8;
	Thu,  6 Sep 2007 19:17:42 -0400 (EDT)
In-Reply-To: <46E068BB.5080202@lsrfire.ath.cx> (=?utf-8?Q?Ren=C3=A9?=
 Scharfe's message of
	"Thu, 06 Sep 2007 22:53:15 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57944>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Just noticed: if the memcmp() above finds a difference, the code shou=
ld
> *not* break out of the loop.  Ahem.  Perhaps I should first add memme=
m()
> after all...

That sounds like a sensible thing to do. =20

Will drop this copy and use updated 4/3 and 3.5/3; thanks.
