From: Marc Strapetz <marc.strapetz@syntevo.com>
Subject: Re: git submodule should honor "-c credential.helper" command line
 argument
Date: Wed, 3 Feb 2016 09:08:09 +0100
Message-ID: <56B1B569.5040502@syntevo.com>
References: <56B0E3AA.30804@syntevo.com>
 <20160203042554.GA21179@sigill.intra.peff.net>
 <CA+P7+xq8sv6f8K8K0EEjXg=wdKpFg6z0K5F6P4SGEp+wKdU=rA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Git mailing list <git@vger.kernel.org>
To: Jacob Keller <jacob.keller@gmail.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 03 09:07:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQsTI-0003Kg-RH
	for gcvg-git-2@plane.gmane.org; Wed, 03 Feb 2016 09:07:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933711AbcBCIHY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2016 03:07:24 -0500
Received: from smtprelay02.ispgateway.de ([80.67.31.25]:38368 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933450AbcBCIHY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2016 03:07:24 -0500
Received: from [91.113.179.170] (helo=[192.168.92.24])
	by smtprelay02.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES128-SHA:128)
	(Exim 4.84)
	(envelope-from <marc.strapetz@syntevo.com>)
	id 1aQsTA-00072q-ER; Wed, 03 Feb 2016 09:07:20 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
In-Reply-To: <CA+P7+xq8sv6f8K8K0EEjXg=wdKpFg6z0K5F6P4SGEp+wKdU=rA@mail.gmail.com>
X-Df-Sender: bWFyYy5zdHJhcGV0ekBzeW50ZXZvLmNvbQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285339>

On 03.02.2016 08:35, Jacob Keller wrote:
> On Tue, Feb 2, 2016 at 8:25 PM, Jeff King <peff@peff.net> wrote:
>> I think the problem is that when git "switches" to working in the
>> submodule repository, it clears the environment, which includes any "-c"
>> command switches. This makes sense for some situations, but not for
>> others. This thread shows a similar problem:
>>
>>    http://thread.gmane.org/gmane.comp.version-control.git/264840
>>
>> Jens suggested there adding an option to tell clone to pass specific
>> variables to the submodule, which I think makes sense. AFAIK, nobody has
>> done any work yet on that approach.
>>
>
> This is something that I am also interested in, haven't had a chance
> to look at it just yet though. I may have some time soon to take a
> stab at this.

To have this issue addressed would be great. It's currently preventing 
me to switch our authentication-related code to credential helpers.

Jake, I'm happy to help, if I can (I don't have any experience with Git 
code though, except of browsing it a couple of times ... so patches from 
my side would need a lot of review I guess :). Just let me know.

-Marc
