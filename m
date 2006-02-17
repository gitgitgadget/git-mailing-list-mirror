From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH] Handle branch names with slashes
Date: Fri, 17 Feb 2006 16:01:10 +1300
Message-ID: <43F53C76.6080902@vilain.net>
References: <20060214173509.GA8666@diana.vm.bytemark.co.uk> <20060217014117.12525.21330.stgit@backpacker.hemma.treskal.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@arm.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 17 04:01:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9vs8-0004Ss-Sq
	for gcvg-git@gmane.org; Fri, 17 Feb 2006 04:01:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbWBQDB0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 16 Feb 2006 22:01:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932132AbWBQDB0
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Feb 2006 22:01:26 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:63137 "EHLO mail.utsl.gen.nz")
	by vger.kernel.org with ESMTP id S932074AbWBQDBZ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Feb 2006 22:01:25 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 65534)
	id 97B484F87; Fri, 17 Feb 2006 16:01:21 +1300 (NZDT)
Received: from [127.0.0.1] (longdrop.watts.utsl.gen.nz [192.168.255.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTP id 6BF2C3CEA;
	Fri, 17 Feb 2006 16:01:15 +1300 (NZDT)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
To: =?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>
In-Reply-To: <20060217014117.12525.21330.stgit@backpacker.hemma.treskal.com>
X-Enigmail-Version: 0.92.1.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.watts.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16324>

Karl Hasselstr=F6m wrote:
> Let StGIT grok branch names with slashes in them. It used to fall fla=
t
> on its face when confronted with them.
>=20
> I think I've covered all, or at least most cases, but there are
> probably some bugs left if you look hard enough.

Does `stgit -r patchname/bottom` still work?

Sam.
