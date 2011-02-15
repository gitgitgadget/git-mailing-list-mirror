From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 2/7] push: describe --porcelain just like commit and status
Date: Tue, 15 Feb 2011 07:50:39 +0100
Message-ID: <4D5A223F.6000605@drmicha.warpmail.net>
References: <cover.1297695910.git.git@drmicha.warpmail.net> <3b6a87b585eea1722bd31bc9cf5ba2c80e37aefa.1297695910.git.git@drmicha.warpmail.net> <7vmxlys89t.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 15 07:53:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpEnJ-0000q7-7c
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 07:53:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753254Ab1BOGxq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Feb 2011 01:53:46 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:47047 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751750Ab1BOGxp (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Feb 2011 01:53:45 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 4F4B92030A;
	Tue, 15 Feb 2011 01:53:44 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Tue, 15 Feb 2011 01:53:44 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=3KuNNqNqrt9MkKCPtq+df0tpOYQ=; b=rzEviNF/Mz3rVvkggVuaAZrYcDwXRZgFKF5e+470qOF4Z+GzGahmqVJ+Qv4evN5T4K+7Jwl+ER4wDn6+MusKGv9mjIZR0fwjr9E2PXtt1yTYJtRRbyMwKVWYSdk/Yr/nWIXeRxNqzCxLc+bK5KsS0WkAtOER3c6NAEyG2uCo8Y0=
X-Sasl-enc: N2TTEl/JUydzgMRXKBCwzGvM+m9dU0myBHEqeNb+IvHK 1297752824
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id D42C54022C1;
	Tue, 15 Feb 2011 01:53:43 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <7vmxlys89t.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166815>

Junio C Hamano venit, vidit, dixit 14.02.2011 20:53:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> -		OPT_BIT( 0,  "porcelain", &flags, "machine-readable output", TRANSPORT_PUSH_PORCELAIN),
>> +		OPT_BIT( 0,  "porcelain", &flags, "show porcelain output format", TRANSPORT_PUSH_PORCELAIN),
> 
> Thanks, but I wonder if machine-readable is more descriptive than
> "porcelain output format", iow, updating commit/status may be better.
> 
> The option was meant to mean "output format for Porcelain script writers
> to stay machine readable" but it can be misunderstood as "output format
> a Porcelain command would produce with chromes and glitters".

I'm happy with that, too. Generally, I tried to go with the majority
with this unifying series. In fact, we've been unhappy with the name of
that option as well, but the usage text is easier to change.

Michael
