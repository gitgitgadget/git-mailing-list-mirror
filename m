From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 1/4] rev-parse: deprecate use as an option sifter
Date: Fri, 14 May 2010 21:22:47 +0200
Message-ID: <4BEDA307.2010400@drmicha.warpmail.net>
References: <20100505033536.GB8779@coredump.intra.peff.net> <m3y6fmcx0n.fsf@localhost.localdomain> <4BED9C09.8010801@drmicha.warpmail.net> <201005142101.16317.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 14 21:22:54 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OD0TE-0003fC-2c
	for gcvg-git-2@lo.gmane.org; Fri, 14 May 2010 21:22:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756897Ab0ENTWr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 May 2010 15:22:47 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:44454 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753991Ab0ENTWq (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 May 2010 15:22:46 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 4139BF7EAE;
	Fri, 14 May 2010 15:22:43 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Fri, 14 May 2010 15:22:43 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=BBw/VlmBVAzTe9FlKEEca6OvXvg=; b=YZ0M6NGwO4GApfllky63vZpxNnYYADiLGmLn8B/+606cKJefjMw9TxXHdLFP/AYWYFtp9MRLw3YyJLVWzXFcnrVksf5lURUxPzBCIzpL3bs+CxLTE0IwCt+kMaWioA8HfPij+FuE4XkZ3zlpHiyjw+iaLPAISx7zKGSqmdYlUco=
X-Sasl-enc: auuuNigi3mCRJuJ3QOuIR7PIbLiFJlC9hZA87fd7TYdL 1273864962
Received: from localhost.localdomain (p5485982A.dip0.t-ipconnect.de [84.133.152.42])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 054E44C1584;
	Fri, 14 May 2010 15:22:41 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100503 Lightning/1.0b2pre Lanikai/3.1b2pre
In-Reply-To: <201005142101.16317.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147115>

Jakub Narebski venit, vidit, dixit 14.05.2010 21:01:
> Dnia pi=B1tek 14. maja 2010 20:52, Michael J Gruber napisa=B3:
>> Jakub Narebski venit, vidit, dixit 14.05.2010 17:41:
>>> Michael J Gruber <git@drmicha.warpmail.net> writes:
>>>
>>>>  NAME
>>>>  ----
>>>> -git-rev-parse - Pick out and massage parameters
>>>> +git-rev-parse - Parse symbolic names into object names
>>>
>>> What about "git rev-parse --parseopt"?  Isn't it massaging paramete=
rs?
>>>
>>
>> Sure it is. But if you read the part of the patch that you cut out (=
i.e.
>> the comment and relevant diff) you see that the massaging part is th=
e
>> deprecated part of it. That's why I suggest not mentioning it at the
>> most prominent place. (I don't suggest removing that functionality.)
>=20
> "git rev-parse --parseopt" is not deprecated.  What is deprecated is
> --revs-only, --flags, etc.
>=20

Still, I would say that "massage parameters" refers to all parameter
massaging including '--flags' etc. And, my paragraph about deprecation
mentions the option sifting part only.

Cheers,
Michael
