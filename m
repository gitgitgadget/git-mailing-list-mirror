From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v2] INSTALL: git-p4 doesn't support Python 3
Date: Sun, 20 Jan 2013 19:28:31 +0000
Message-ID: <20130120192831.GB7498@serenity.lan>
References: <20130120110620.GJ31172@serenity.lan>
 <7vwqv7lm6b.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Pete Wyckoff <pw@padd.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 20 20:29:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tx0Zg-0004c7-EK
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jan 2013 20:29:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752400Ab3ATT2k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2013 14:28:40 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:35532 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752389Ab3ATT2j (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2013 14:28:39 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id F326ACDA5D9;
	Sun, 20 Jan 2013 19:28:38 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xbSS7Su8yJK4; Sun, 20 Jan 2013 19:28:38 +0000 (GMT)
Received: from aardwolf.aluminati.org (aardwolf.aluminati.org [10.0.7.189])
	by jackal.aluminati.org (Postfix) with ESMTP id 8C90CCDA5D1;
	Sun, 20 Jan 2013 19:28:38 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by aardwolf.aluminati.org (Postfix) with ESMTP id 68B59276DFE;
	Sun, 20 Jan 2013 19:28:38 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from aardwolf.aluminati.org ([127.0.0.1])
	by localhost (aardwolf.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A-vbgdOUwJ+P; Sun, 20 Jan 2013 19:28:38 +0000 (GMT)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by aardwolf.aluminati.org (Postfix) with ESMTPSA id E05C1276DFD;
	Sun, 20 Jan 2013 19:28:33 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <7vwqv7lm6b.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214039>

On Sun, Jan 20, 2013 at 10:54:52AM -0800, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
> 
>> git-p4 supports Python 2.6 and later versions of Python 2.  Since Python
>> 2.8 will never exist [1], it is most concise to just list the supported
>> versions.
> 
> Thanks; Eric's patch recently updated git-p4.py to require 2.4 I
> think. Shouldn't it also be updated?

I haven't done a thorough audit to check what the actual minimum
supported version is, this is just the minimal change to say "not
Python 3".

Personally, I'm not sure of the value of having version checks at the
top of the Python scripts, I would rather set a project-wide minimum
supported version (as in my recent CodingGuidelines patch) and check it
once in the Makefile.


John
