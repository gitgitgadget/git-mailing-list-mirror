From: John Keeping <john@keeping.me.uk>
Subject: Re: [RFC/PATCH] CodingGuidelines: add Python code guidelines
Date: Fri, 18 Jan 2013 22:05:52 +0000
Message-ID: <20130118220552.GF31172@serenity.lan>
References: <20130118180639.GD31172@serenity.lan>
 <7vvcauqpn4.fsf@alter.siamese.dyndns.org>
 <20130118193501.GE31172@serenity.lan>
 <7vip6uqlvl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Eric S. Raymond" <esr@thyrsus.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Pete Wyckoff <pw@padd.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 18 23:06:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwK4y-00051S-Kh
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jan 2013 23:06:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754318Ab3ARWGH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2013 17:06:07 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:33943 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753963Ab3ARWGG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2013 17:06:06 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 9DE7E866050;
	Fri, 18 Jan 2013 22:06:05 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g6My2i+TMAFb; Fri, 18 Jan 2013 22:06:04 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by jackal.aluminati.org (Postfix) with ESMTP id 1D5A486600B;
	Fri, 18 Jan 2013 22:06:03 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id D2350161E4FB;
	Fri, 18 Jan 2013 22:06:03 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eGv+HAnuw-z2; Fri, 18 Jan 2013 22:06:03 +0000 (GMT)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id D0CC0161E3E9;
	Fri, 18 Jan 2013 22:05:54 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <7vip6uqlvl.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213942>

On Fri, Jan 18, 2013 at 12:25:34PM -0800, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
>> As more people have started trying to support Python 3 in the wild, it
>> has become clear that it is often easier to have a single codebase that
>> works with both Python 2 and Python 3, and not use 2to3.
>>
>> It is for this reason that the Unicode literal prefix was reintroduced.
> 
> Yes, and from that perspective, placing floor on earlier 3.x makes
> tons of sense, no?
> 
> These early versions may not be unstable in the "this does not
> behave as specified in the language specification for 3.x" sense,
> but for the purpose of running scripts meant to be executable by
> both 2.x and 3.x series, the early 3.x versions are not as good as
> later versions where Python folks started making deliberate effort
> to support them.

As far as I'm aware (and having reviewed the release notes for 3.1, 3.2
and 3.3 as well as the planned features for 3.4), Unicode literals are
the only feature to have been added that was intended to make it easier
to support Python 2 and 3 in the same codebase.

Given that no code currently on pu uses Unicode literals, I don't see a
reason to specify a minimum version of Python 3 since we're already
restricting ourselves to features in 2.6.


John
