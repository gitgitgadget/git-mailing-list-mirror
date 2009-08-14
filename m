From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC PATCH 0/2] add a --delete option to git push
Date: Fri, 14 Aug 2009 22:25:38 +0200
Message-ID: <200908142225.38610.jnareb@gmail.com>
References: <1250226349-20397-1-git-send-email-srabbelier@gmail.com> <200908141050.56900.jnareb@gmail.com> <fabb9a1e0908140953w2d3f571cv3e7415817c2758a7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 14 22:26:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mc3Ld-0006Ze-8q
	for gcvg-git-2@gmane.org; Fri, 14 Aug 2009 22:26:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932777AbZHNUZx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Aug 2009 16:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757141AbZHNUZx
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Aug 2009 16:25:53 -0400
Received: from mail-bw0-f222.google.com ([209.85.218.222]:57610 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754924AbZHNUZx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2009 16:25:53 -0400
Received: by bwz22 with SMTP id 22so1343866bwz.18
        for <git@vger.kernel.org>; Fri, 14 Aug 2009 13:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=MRM6sWoFVs5yS1XTfGcO2a+hGiFIkj8kkH/UbDF27IM=;
        b=vcC1rVH32a7FCQ+M+n4rvXMLfqkvPk2ZEZbBrRSn8JjfykISUDQWMWn8l89wvF/JpV
         uc8KsZNu1hDS0LBCeyJ0lRG6pR+03D6WQc1oCchRkHTt3K+7mHpjSjsm7e/tqnDdnp8B
         9tnPuFcIIAxqAfqLgWj+2lGv6qCKJ02GSwuV4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=IdsW3oVTORw2WFYuJN2pBUL8K3pay64qtauW1bGdPsKHujGyuUQgdvFLnSN9F71s7J
         qa+U0utR8QldzmTns8Ui2a4N4gCSWFP1qNSQOmeqaCR7aF4AZgKd2uxKTwi9CErrqFW8
         aiAVZoo7TuTFkoFMtSPxnL5+HDyT/C8IN+I2I=
Received: by 10.103.219.17 with SMTP id w17mr709388muq.103.1250281553216;
        Fri, 14 Aug 2009 13:25:53 -0700 (PDT)
Received: from ?192.168.1.13? (abwe173.neoplus.adsl.tpnet.pl [83.8.228.173])
        by mx.google.com with ESMTPS id s10sm8373181mue.8.2009.08.14.13.25.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 14 Aug 2009 13:25:52 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <fabb9a1e0908140953w2d3f571cv3e7415817c2758a7@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125947>

Dnia pi=B1tek 14. sierpnia 2009 18:53, Sverre Rabbelier napisa=B3:
> 2009/8/14 Jakub Narebski <jnareb@gmail.com>:
>> On Fri, 14 August 2009, Sverre Rabbelier wrote:
>>>
>>> This is in reply to a brief conversation I had with jnareb on #git
>>> about the blogpost "5 things git could learn from hg", or something
>>> like that (can't find it right now).
>>
>> Thanks.
>=20
> What do you think would be the best solution? There seem to be a lot
> of opinions on how to proceed.

I think we can begin with simple and strict: "--delete=3D<branch>"
is long version of equivalent ":<branch>" (like long option equivalent
to short one).

--=20
Jakub Narebski
Poland
