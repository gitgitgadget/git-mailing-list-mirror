From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v2 ] commit -v: strip diffs and submodule shortlogs from
 the commit message
Date: Tue, 19 Nov 2013 22:01:24 +0100
Message-ID: <528BD1A4.4060903@web.de>
References: <loom.20131110T222043-57@post.gmane.org> <528140F5.6090700@web.de>	<loom.20131111T214646-550@post.gmane.org> <52814C35.6040205@web.de>	<5281DCC5.2000209@kdbg.org> <5282A90A.4030900@web.de>	<xmqqy54tfeje.fsf@gitster.dls.corp.google.com>	<5283C701.8090400@web.de>	<xmqq7gccdq67.fsf@gitster.dls.corp.google.com>	<5287F735.3030306@web.de>	<20131117090935.GC17016@sigill.intra.peff.net>	<xmqqk3g5d7gy.fsf@gitster.dls.corp.google.com>	<528BB23D.4020001@web.de> <xmqqd2lw871i.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Ari Pollak <ari@debian.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 19 22:01:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VisQN-0000UP-Ky
	for gcvg-git-2@plane.gmane.org; Tue, 19 Nov 2013 22:01:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752234Ab3KSVB2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Nov 2013 16:01:28 -0500
Received: from mout.web.de ([212.227.17.12]:58646 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750812Ab3KSVB1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Nov 2013 16:01:27 -0500
Received: from [192.168.178.41] ([91.3.154.76]) by smtp.web.de (mrweb001) with
 ESMTPA (Nemesis) id 0MBTTa-1VsGbj36fu-00AXZO for <git@vger.kernel.org>; Tue,
 19 Nov 2013 22:01:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <xmqqd2lw871i.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:hCPDc9y6JjGVhfGicpWKXvxTz/awSx+ZOUbaY3VAkhJbYVlIA6A
 vNJSzGBH4ETapuuaW81Xj0gKU3MPRDEiL+veltg5KLj+lRqkPWRBMpSXIgwzwvDD/+6WCik
 Bj5iI7Z5m4pI81PnqohoQh6EH3GoAnbLAdMNWUOZFzeWjfRKo0QDcuzYPRouYC4m6X2mOvn
 z24q5NClcNRsVHfniHUpg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238041>

Am 19.11.2013 21:34, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
>> Am 18.11.2013 17:01, schrieb Junio C Hamano:
>>> Jeff King <peff@peff.net> writes:
>>>
>>>> I found this hard to parse, I think because of the "keeping" (why would
>>>> I not keep it?), and because you are talking about lines above and
>>>> below. It is not as accurate to say:
>>>>
>>>>   # ------------------ >8 --------------------
>>>>   # Everything below this line will be removed.
>>>>
>>>> because it is technically the line above that is the cutoff. But I think
>>>> the meaning is clear, and it is simpler to parse.
>>
>> Ok, changed in this version.
>>
>>> I agree with your rewording suggestion....
>>
>> Which is what my last version already did :-)  But it didn't mention
>> that in the commit message, which it does now).
> 
> Oh, another thing. Does this interact with the core.commentChar in
> any way, and if so how?

If I understand that setting correctly the hardcoded '#' characters
must be replaced with the core.commentChar when set. Will tackle that
in the next iteration.
