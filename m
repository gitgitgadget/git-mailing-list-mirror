From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: What's cooking in git.git (Oct 2013, #02; Mon, 14)
Date: Wed, 16 Oct 2013 19:53:30 +0200
Message-ID: <525ED29A.1020507@web.de>
References: <20131014184524.GW9464@google.com> <20131015001231.GA9464@google.com> <xmqqiowye66r.fsf@gitster.dls.corp.google.com> <20131015191656.GD9464@google.com> <525D9A96.6050209@web.de> <20131015200528.GE9464@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Anders Kaseorg <andersk@MIT.EDU>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 16 19:53:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWVHv-000636-Ab
	for gcvg-git-2@plane.gmane.org; Wed, 16 Oct 2013 19:53:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761699Ab3JPRxe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Oct 2013 13:53:34 -0400
Received: from mout.web.de ([212.227.17.12]:56608 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761692Ab3JPRxc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Oct 2013 13:53:32 -0400
Received: from [192.168.178.41] ([91.3.180.150]) by smtp.web.de (mrweb001)
 with ESMTPA (Nemesis) id 0Lud4y-1VwjJj03Bg-00zjqo for <git@vger.kernel.org>;
 Wed, 16 Oct 2013 19:53:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0.1
In-Reply-To: <20131015200528.GE9464@google.com>
X-Enigmail-Version: 1.5.2
X-Provags-ID: V03:K0:JdUu1HPFBRv2kOy1pkuAJYnqY75slPaQBoJ00QsZhPpwI0+TGfW
 pxPj7iF0VDxOHC0ykLYM9bz4fQvOMbk2NhPEE5wONeMlEfy8w+ptkd4zre7KVQ0af6kbHFr
 dZw/KMGRJ0eRvr1VHkIqPJU+bkO6uYulgugzhgEvxvWNmAcWK1a+KVT24Vs4HWwv7ZWTvYv
 GBfC7uKpY+ZD5DMZSpudQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236249>

Am 15.10.2013 22:05, schrieb Jonathan Nieder:
> Jens Lehmann wrote:
>> Am 15.10.2013 21:16, schrieb Jonathan Nieder:
> 
>>> So I suspect this will fix more scripts than it breaks, though it may
>>> still break some. :/
>>
>> Hmm, I'm really not sure if we should do this or not.
> 
> What convinced me was Anders's observation that the current behavior
> can have very bad consequences if a script is passing untrusted input
> in multiple arguments to git submodule foreach.

Ok, that makes sense.

>> And maybe only change that on a major version bump where people should
>> not be terribly surprised about such a change in behavior and are more
>> likely to read release notes?
> 
> Ok with me, but please don't make it 2.0. :)

But we don't want to wait for 3.0, no? ;-)
