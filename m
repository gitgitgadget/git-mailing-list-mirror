From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v4] Teach rm to remove submodules unless they contain
 a git directory
Date: Sat, 29 Sep 2012 16:23:39 +0200
Message-ID: <5067046B.9040109@web.de>
References: <50634799.7090807@web.de> <7v8vbvs8z6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	=?UTF-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>,
	Phil Hord <phil.hord@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 29 16:24:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THxxb-0001dc-3R
	for gcvg-git-2@plane.gmane.org; Sat, 29 Sep 2012 16:24:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752347Ab2I2OXx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2012 10:23:53 -0400
Received: from mout.web.de ([212.227.15.4]:56175 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751341Ab2I2OXw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2012 10:23:52 -0400
Received: from [192.168.178.41] ([91.3.175.36]) by smtp.web.de (mrweb103) with
 ESMTPA (Nemesis) id 0M1o86-1TbQqp2B6w-00t3x8; Sat, 29 Sep 2012 16:23:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
In-Reply-To: <7v8vbvs8z6.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:NCa3/CWKqSf28YSmDAuojnLZT5uRVyhiW8yieLkOcfS
 29mOXKohnMJIeZ9hFK6kX3bVnOd3gaGMUK66XStj6mHuFkxze9
 oRt0cmkBe+jsx/0GioC2HIXf3KqCkF426db0ToPrqfB3OTDPHJ
 c47qX3kNCWJDME+yKRSm30lPRly4Zv+e9zMnT8Iby1uNWfxjGe
 MWIYynd1bR+Ibt1+2He2A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206648>

Am 27.09.2012 18:53, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
>> +			/*
>> +			 * Skip unmerged entries except for populated submodules
>> +			 * that could loose history when removed.
>> +			 */
> 
> s/loose/lose/, I think.

Thanks for squashing that one in!

I also used "loose" in the commit message where "lose" would have been
correct. I can resend a new version correcting both if you want.
