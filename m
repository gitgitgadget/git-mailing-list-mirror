From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH/RFC 1/2] sha1_file: close all pack files after running
Date: Mon, 05 Oct 2015 11:03:19 +0200
Organization: gmx
Message-ID: <2588666fce6a367fa46cf2501a78fe76@dscho.org>
References: <1443670163-31193-1-git-send-email-max@max630.net>
 <1443670163-31193-2-git-send-email-max@max630.net>
 <33b74e875c7298f67640f5850e88c152@dscho.org>
 <763ac2b63d56d250e5e1a27f490f79db@dscho.org>
 <20151002192148.GD26154@wheezy.local>
 <21bd1c9c394a421bc06c6fa1837f16b6@dscho.org>
 <20151005045748.GF26154@wheezy.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Mon Oct 05 11:03:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zj1gD-0002Qs-Bi
	for gcvg-git-2@plane.gmane.org; Mon, 05 Oct 2015 11:03:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751769AbbJEJD3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2015 05:03:29 -0400
Received: from mout.gmx.net ([212.227.17.20]:54619 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751462AbbJEJD2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2015 05:03:28 -0400
Received: from dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MQMBU-1aCkHW0ez6-00Tpko; Mon, 05 Oct 2015 11:03:22
 +0200
In-Reply-To: <20151005045748.GF26154@wheezy.local>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:Dq+92c9oGm516gOD+T7tftRfXKZwwlKUyZ4CcU1/rwfDZ4hXQ64
 Kp16fUiWbIg2uIrIuuZ9K4hXwtv5ubW8aMhM7VTZAln0H5cVGH40bP4L+KKbEhYyZMwBLOI
 DYBSCxoKmhUgCF/Iow6YU4aitTAlVWmCQwlTjfTj3E45O3W73AYds6RryDP/GAsk7c+GS5r
 SUVmDJc07EJ5l6QYnwNig==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZyRxfoNMXgU=:lRIc4yzQo33Sz9kGD8/x8n
 68xx1u2QPOnA7F9gsKjnDmVb0zagvqc3QqYyWoOduMxyE158aCWNqn0x4s5tar1Rq8fZRmWHB
 Y7CIQ81lMCss6MKlBC5aN9dzsQ4zJFzOidA64eqLml8AoVPHHYfCh2ZhzwQGyj+mrdW2lc4N3
 78tAffeIJKk9Mj2iL58hx/2fNCz9nrEVLQrSETnNsxCKbh/LtZ3lns09F8N2hKuhc0fnAzsCy
 /+8Lqwi5OOg9lJvs1m9tR/GvyXNzeJWqR186V+Y/c/dlL+UI+j5UyqM+9/RBMYPHMAhWk+EgP
 udMSNcS1tNSPdjX/eF3XnwFsnHA5twWq09DpzhG0ghObIDozog5nQ5Mgbo+NjQ+KyMMnC2Qs6
 XY5f2zRY9KxUgE2+HEwlD6x4zOXWe1E/7N6i+ROLOcoz/CtRRXMweKnggRcdhQ9K9sMyqLX5q
 x+4R0pFfsKdy0SLA1JmbQt3sZPuI6KwCl1NZSzjK7P8afc51194CjVLEiyabS04R9j5GgCmue
 jMhBj6TdXfRitM14Nqf+5DCqdVJJ7MAzQjFAPQ1qHyWMCjCXa1bhoSYs313U+K8Q5Xdpkg96P
 PKShjvufU4o6K1S4Kp7fpqRGrNjRAowTPvV7Q8hRf96jZU91E8gu7vZSctkWD6SA0NXtLElLA
 wKMPV6bHifS07qv3bYLpNXG2ExFd+ebMU0/1URVxCZsdoWIgpKrcqUha9gs2V75soW11GvQ60
 LgNNisIhHdXJCKppL7ChMBcgp8lFnen0yjDH8VdQwpRYPR6PyVdKLPdxGAxGM3hmunSmng9A 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279050>

Hi Max,

On 2015-10-05 06:57, Max Kirillov wrote:
> On Sun, Oct 04, 2015 at 04:53:30PM +0200, Johannes Schindelin wrote:
>> I guess then we would need two different patches for the
>> two different fixes, at least.
>>
>> So now I am unsure how to proceed: I do not want to step
>> on your toes, but I also want to see my use case fixed and
>> I want to move forward on this. At the moment, it looks as
>> if we are at an impasse.
> 
> Just continue with your patches then. I do not hurry.

Okay!
Johannes
