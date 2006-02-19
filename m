From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH 2/2] Add 'stg uncommit' command
Date: Mon, 20 Feb 2006 10:15:52 +1300
Message-ID: <43F8E008.3010103@vilain.net>
References: <20060217042728.14175.39928.stgit@backpacker.hemma.treskal.com> <20060217043128.14175.60168.stgit@backpacker.hemma.treskal.com> <43F84D9A.2010905@gmail.com> <20060219134558.GA4784@diana.vm.bytemark.co.uk> <20060219144752.GA5541@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 19 22:16:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FAvug-0006mn-4D
	for gcvg-git@gmane.org; Sun, 19 Feb 2006 22:16:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241AbWBSVQK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 19 Feb 2006 16:16:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932249AbWBSVQK
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Feb 2006 16:16:10 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:54690 "EHLO mail.utsl.gen.nz")
	by vger.kernel.org with ESMTP id S932241AbWBSVQI (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Feb 2006 16:16:08 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 65534)
	id E09635314; Mon, 20 Feb 2006 10:16:04 +1300 (NZDT)
Received: from [127.0.0.1] (longdrop.watts.utsl.gen.nz [192.168.255.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTP id D49ABB47;
	Mon, 20 Feb 2006 10:15:56 +1300 (NZDT)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
To: =?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>
In-Reply-To: <20060219144752.GA5541@diana.vm.bytemark.co.uk>
X-Enigmail-Version: 0.92.1.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.watts.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16450>

Karl Hasselstr=F6m wrote:
>>>I added your name on the copyright since this is a new file.
>>I did that too at first, but then I changed it back since I reckoned
>>more than 50% of the file was copy-pasted from elsewhere. But
>>thanks. :-)
> By the way, it seems like my name got munged when you edited the
> commit.

I have noticed this munging happening, when I am using a UTF-8 locale.

While we are talking about non-linear messing around with the commit
history, can I request a feature?

Currently, I have a patch stack where I want the top of one of the
patches to always be a particular revision.  Consider the last revision
to be like a "difference" revision (ie "what's left" when re-organising
a patch set).

How about a "stg push --fudge-to c033171d..." command for this?

Sam.
