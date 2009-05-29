From: Sam Vilain <sam@vilain.net>
Subject: Re: RFE: "git bisect reverse"
Date: Fri, 29 May 2009 16:20:31 +1200
Message-ID: <4A1F628F.9010407@vilain.net>
References: <4A1C6B70.4050501@zytor.com> <4A1CACB2.7000702@vilain.net> 	<4A1CBF7A.3090708@zytor.com> <200905270726.59883.chriscool@tuxfamily.org> 	<efe2b6d70905271411g4e1616b5w548141ee9fab2c14@mail.gmail.com> 	<20090527211836.GA14841@localhost> <efe2b6d70905271507s187babe9yf19a25268ab0b95e@mail.gmail.com> 	<4A1DC7D8.2050601@vilain.net> <efe2b6d70905281329s1ae5a94coe5875714f341d5a9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Clemens Buchacher <drizzd@aon.at>,
	Christian Couder <chriscool@tuxfamily.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
To: Ealdwulf Wuffinga <ealdwulf@googlemail.com>
X-From: git-owner@vger.kernel.org Fri May 29 06:21:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9tay-0005CX-LS
	for gcvg-git-2@gmane.org; Fri, 29 May 2009 06:21:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbZE2EVT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2009 00:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbZE2EVS
	(ORCPT <rfc822;git-outgoing>); Fri, 29 May 2009 00:21:18 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:48248 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751024AbZE2EVS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2009 00:21:18 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 8C6B821C3ED; Fri, 29 May 2009 16:20:43 +1200 (NZST)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id B377D21C2EB;
	Fri, 29 May 2009 16:20:32 +1200 (NZST)
User-Agent: Mozilla-Thunderbird 2.0.0.19 (X11/20090103)
In-Reply-To: <efe2b6d70905281329s1ae5a94coe5875714f341d5a9@mail.gmail.com>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120247>

Ealdwulf Wuffinga wrote:
>> Sounds like interesting stuff, can you make a patch out of it?
>>     
>
> The code as it stands will actually work with an unmodified git.
> What it doesn't yet have is a 'git-bisect'-like frontend, which is the only
> part which would actually require modifying (or just adding to) git itself.
>
> It does already interface to the git plumbing, so you can try it out if you
> don't mind using a slightly ungitlike  interface.
>
> I assume it's not worth doing a patch which would just copy my tree
> into the git source tree?
>
> There was also, last time I mentioned this on the list, some question
> as to whether it was acceptable to add something written in python to
> git.
>   

I mean, can you port your algorithm from python to the git-bisect C
source and therefore make something of benefit to existing 'git bisect'
users ?

Sam.
