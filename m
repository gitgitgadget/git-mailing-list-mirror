From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Moving (renaming) submodules, recipe/script
Date: Mon, 07 Jan 2013 09:18:49 +0100
Message-ID: <50EA84E9.9030702@web.de>
References: <20130107003603.GA25698@odin.tremily.us> <20130107013952.GE3823@elie.Belkin> <50EA7269.1080006@web.de> <7vwqvpjv2n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"W. Trevor King" <wking@tremily.us>, Git <git@vger.kernel.org>,
	Peter Collingbourne <peter@pcc.me.uk>, mbranchaud@xiplink.com,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 07 09:19:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ts7vY-0007fH-Lo
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jan 2013 09:19:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753401Ab3AGITE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2013 03:19:04 -0500
Received: from mout.web.de ([212.227.15.3]:50956 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753066Ab3AGITC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2013 03:19:02 -0500
Received: from [192.168.178.41] ([91.3.169.250]) by smtp.web.de (mrweb001)
 with ESMTPA (Nemesis) id 0LgpYk-1TEzTW0ymc-00o5K2; Mon, 07 Jan 2013 09:18:53
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <7vwqvpjv2n.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4.6
X-Provags-ID: V02:K0:f8qN862YtbsAy8e4maFI5jQcF8WkwDcJdg5OL4cPWQ9
 9pzCcSoZVTc5m94f1fuHiGcAXNzAZrYpczWDByfs4gI35Tijbp
 ty2LpFSEuR6C6phJRbV/EZTal/nIuYe0/o6JSCCD5b0IA5NKzz
 Gtwek823tCYorPtfxvFmXphZcMpL//W/pm1jaiml4cLfvFbQDE
 KCXQ6JTgCF4mqDwZu7xbg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212884>

Am 07.01.2013 08:44, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
>> Am 07.01.2013 02:39, schrieb Jonathan Nieder:
>>> (just cc-ing Jens and Peter, who might be interested)
>>
>> I´m currently working on teaching mv to move submodules and intend
>> to send those patches to the list after finishing submodule deinit.
> 
> Thanks for a heads-up.
> 
> As a couple of recent "What's cooking" message has stated, I'll
> shortly kick jl/submodule-deinit topic out of 'next' back to 'pu',
> so please make an update a replacement, not an incremental.  If I
> recall the discussion correctly, I think we agreed that deinit
> should clear the slate, which means the submodule working tree
> should be removed and made into an empty directory without ".git" in
> it, and the last round we saw on the list didn't do that.

Right, and me thinks that would warrant a --force option for deinit
to do that even if the submodule contains local changes (which would
make deinit fail otherwise). Additionally Michael and Marc spoke up
that they would rather have a --all option to deinit all initialized
submodules and "git submodule deinit" without any arguments should
just produce a usage message. As I saw no voices against it that'll
be part of the next iteration too.
