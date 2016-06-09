From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 00/94] libify apply and use lib in am
Date: Thu, 9 Jun 2016 23:10:09 +0200
Message-ID: <5759DB31.2000106@kdbg.org>
References: <20160511131745.2914-1-chriscool@tuxfamily.org>
 <5734B805.8020504@kdbg.org>
 <CAP8UFD1ukOMi_VDKzZErwSu1OBU5h1hVOxd7mPu1ytzFr11VGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 09 23:10:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bB7DZ-0005sU-1z
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jun 2016 23:10:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752146AbcFIVKQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2016 17:10:16 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:10189 "EHLO bsmtp3.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752467AbcFIVKO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2016 17:10:14 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 3rQdHQ4XsPz5tl9;
	Thu,  9 Jun 2016 23:10:10 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id B6B4652B4;
	Thu,  9 Jun 2016 23:10:09 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
In-Reply-To: <CAP8UFD1ukOMi_VDKzZErwSu1OBU5h1hVOxd7mPu1ytzFr11VGA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296925>

Am 12.05.2016 um 20:02 schrieb Christian Couder:
> On Thu, May 12, 2016 at 7:06 PM, Johannes Sixt <j6t@kdbg.org> wrote:
>> Am 11.05.2016 um 15:16 schrieb Christian Couder:
>>>
>>> This is a patch series about libifying `git apply` functionality, and
>>> using this libified functionality in `git am`, so that no 'git apply'
>>> process is spawn anymore. This makes `git am` significantly faster, so
>>> `git rebase`, when it uses the am backend, is also significantly
>>> faster.
>>
>>
>> I'm including this in my build on Windows. It passes the test suite.
>
> Great! Thanks for the report!
>
>> I'll also use it in production for a while, although I am not a git-am
>> consumer nor do I use git-rebase without -i, hence, my tests will probably
>> only show that there is no bad fall-out.

Meanwhile, I have retrained my muscle memory to stop before typing "-i" 
after "rebase" for an opportunity to consider whether bare rebase can be 
used.

What should I say? I am impressed. It's like 100 times faster than 
rebase -i (on Windows). I'm now using it whenever I can, and more often 
than not I plan my rebase workflow so that I can go ahead without -i.

Can't wait to test a re-roll on top of cc/apply-introduce-state!

-- Hannes
