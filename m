From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH next 2/2 v2] Remove python 2.5'isms
Date: Fri, 11 Jun 2010 15:28:48 +0200
Message-ID: <4C123A10.6050103@drmicha.warpmail.net>
References: <201006100040.54375.johan@herland.net> <5ep6Hc9Nl3QLKwV46xET5ZLhqo2uNlnUL1-nNsG9p2IWyX-odykArvT4ontRdeBUA9ouCPQGFwQ@cipher.nrlssc.navy.mil> <4C10B02F.9050107@drmicha.warpmail.net> <20100610154114.GC31213@vidar.dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Brandon Casey <casey@nrlssc.navy.mil>, johan@herland.net,
	git@vger.kernel.org, srabbelier@gmail.com, davvid@gmail.com,
	Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 11 15:28:47 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ON4Hv-0006vT-0o
	for gcvg-git-2@lo.gmane.org; Fri, 11 Jun 2010 15:28:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760288Ab0FKN2l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jun 2010 09:28:41 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:60368 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756272Ab0FKN2k (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Jun 2010 09:28:40 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 213B1F840F;
	Fri, 11 Jun 2010 09:28:39 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 11 Jun 2010 09:28:39 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=fN0o/jPmMYNlcXXxiVuy03bf4qs=; b=YiR+qW82/JoKnU33FVXDAGnLwj0uoW39BJ/B6KyHE+7PXbLwNVY61hLeXbBVccO0vCWLsyOZ+2H217G2m5ejMlv6Ie0IHcPvO1lrstzyI4nen0F23xaeWk9xvosBXBQbFr5wKPlwOyfSOaDdBXFp77klmQ11sQDBffbNJpAyyCY=
X-Sasl-enc: uQQdaqubZx7HezlBF3ig++ON8r9MGRwnD9oM6//M/WZ2 1276262918
Received: from localhost.localdomain (p5485A0CC.dip0.t-ipconnect.de [84.133.160.204])
	by mail.messagingengine.com (Postfix) with ESMTPSA id A17174AD440;
	Fri, 11 Jun 2010 09:28:37 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.6pre) Gecko/20100610 Lightning/1.0b2pre Lanikai/3.1.1pre
In-Reply-To: <20100610154114.GC31213@vidar.dreamhost.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148945>

David Ripton venit, vidit, dixit 10.06.2010 17:41:
> On 2010.06.10 11:28:15 +0200, Michael J Gruber wrote:
>> Doesn't P2.4 have
>>
>> 	from hashlib import sha1 as _digest
>>
>> etc.? I haven't checked for "as".
> 
> Hashlib was new in Python 2.5.  See the note at the top of:
> http://docs.python.org/library/hashlib.html
> 
> You may have hashlib in your Python 2.4, but if so it's a third-party
> module, not part of the standard library.  You shouldn't rely on
> everyone having it, when it's so easy to fallback to the sha module.

Well sure, that's why we need the try/except's.
> 
> "import foo as bar" was added in Python 2.0.  "as" became a reserved
> word in Python 2.6.

Thanks!. Then we can use the clean version as suggested above (inside
try/except).

Michael
