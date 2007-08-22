From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [StGit PATCH 1/6] Split git.merge into two functions
Date: Wed, 22 Aug 2007 03:04:37 -0700
Message-ID: <7v7innkhqi.fsf@gitster.siamese.dyndns.org>
References: <11875975232619-git-send-email-davidk@lysator.liu.se>
	<1187597523433-git-send-email-davidk@lysator.liu.se>
	<87odh2d1q7.fsf@morpheus.local>
	<7vejhxrcgl.fsf@gitster.siamese.dyndns.org>
	<20070821193504.GA20823@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David =?utf-8?Q?K=C3=A5gedal?= <davidk@lysator.liu.se>,
	git <git@vger.kernel.org>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
X-From: git-owner@vger.kernel.org Wed Aug 22 12:05:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INn5A-0002m3-74
	for gcvg-git@gmane.org; Wed, 22 Aug 2007 12:05:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756078AbXHVKEo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 22 Aug 2007 06:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754583AbXHVKEo
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 06:04:44 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:39768 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754547AbXHVKEn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Aug 2007 06:04:43 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 479D61260FC;
	Wed, 22 Aug 2007 06:05:02 -0400 (EDT)
In-Reply-To: <20070821193504.GA20823@informatik.uni-freiburg.de> (Uwe
	=?utf-8?Q?Kleine-K=C3=B6nig's?= message of "Tue, 21 Aug 2007 21:35:05
 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56364>

Uwe Kleine-K=C3=B6nig  <ukleinek@informatik.uni-freiburg.de> writes:

> Hello David,
>
> Junio C Hamano wrote:
>> David K=C3=A5gedal <davidk@lysator.liu.se> writes:
>>=20
>> > David K=C3=A5gedal <davidk@lysator.liu.se> writes:
>> >
>> > It seems that git-send-email didn't like me for some reason.  Doub=
le
>> > UTF-8 encoding is not very pretty.
>>=20
>> I believe Uwe (CC'ed) had a few patches to deal with this area.
>> Do they help?
>
> My patches are already in next, the relevant being probably
> v1.5.3-rc4-38-g94638f8.

It is in 'master' and in -rc5/-rc6.
