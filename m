From: John Keeping <john@keeping.me.uk>
Subject: Re: [RFC/PATCH] CodingGuidelines: add Python code guidelines
Date: Fri, 18 Jan 2013 23:05:57 +0000
Message-ID: <20130118230557.GG31172@serenity.lan>
References: <20130118180639.GD31172@serenity.lan>
 <7vvcauqpn4.fsf@alter.siamese.dyndns.org>
 <20130118193501.GE31172@serenity.lan>
 <7vip6uqlvl.fsf@alter.siamese.dyndns.org>
 <20130118220552.GF31172@serenity.lan>
 <7vwqvap1q9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Eric S. Raymond" <esr@thyrsus.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Pete Wyckoff <pw@padd.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 19 00:06:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwL1K-00073D-Dk
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jan 2013 00:06:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754088Ab3ARXGM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2013 18:06:12 -0500
Received: from hyena.aluminati.org ([64.22.123.221]:44566 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751869Ab3ARXGL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2013 18:06:11 -0500
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 2CAE722B4B;
	Fri, 18 Jan 2013 23:06:10 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bkhow7Ydvw-w; Fri, 18 Jan 2013 23:06:09 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by hyena.aluminati.org (Postfix) with ESMTP id 067801FC46;
	Fri, 18 Jan 2013 23:06:08 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 73A59161E556;
	Fri, 18 Jan 2013 23:06:09 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yBCumDponJXk; Fri, 18 Jan 2013 23:06:09 +0000 (GMT)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 0682B161E3A8;
	Fri, 18 Jan 2013 23:05:59 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <7vwqvap1q9.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213947>

On Fri, Jan 18, 2013 at 02:26:06PM -0800, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
>> On Fri, Jan 18, 2013 at 12:25:34PM -0800, Junio C Hamano wrote:
>>> These early versions may not be unstable in the "this does not
>>> behave as specified in the language specification for 3.x" sense,
>>> but for the purpose of running scripts meant to be executable by
>>> both 2.x and 3.x series, the early 3.x versions are not as good as
>>> later versions where Python folks started making deliberate effort
>>> to support them.
>>
>> As far as I'm aware (and having reviewed the release notes for 3.1, 3.2
>> and 3.3 as well as the planned features for 3.4), Unicode literals are
>> the only feature to have been added that was intended to make it easier
>> to support Python 2 and 3 in the same codebase.
> 
> So there may be some other incompatibility lurking that we may run
> into later?

I doubt it - enough projects are running on Python 2 and 3 now that I
doubt there's anything unexpected left to hit.

>> Given that no code currently on pu uses Unicode literals, I don't see a
>> reason to specify a minimum version of Python 3 since we're already
>> restricting ourselves to features in 2.6.
> 
> OK, at least that reasoning need to be kept somewhere, either in the
> documentation of in the log message.

I'll put it in the log message when I send this as a proper patch.


John
