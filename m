From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: What's cooking in git.git (Jun 2015, #06; Wed, 24)
Date: Thu, 25 Jun 2015 13:04:30 +0200
Organization: gmx
Message-ID: <d825b05938778f4ee911cbb8c3c8573b@www.dscho.org>
References: <xmqqwpys95bm.fsf@gitster.dls.corp.google.com>
 <CAGZ79kby0RaKiS2e4o7O7OyLGCftMYVJppvATyPxpzJUOe59jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Jun 25 13:04:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z84xV-0000D8-07
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 13:04:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751804AbbFYLEh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 07:04:37 -0400
Received: from mout.gmx.net ([212.227.17.21]:50594 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751451AbbFYLEf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 07:04:35 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MfjJY-1ZV8951sV2-00NB0Y; Thu, 25 Jun 2015 13:04:31
 +0200
In-Reply-To: <CAGZ79kby0RaKiS2e4o7O7OyLGCftMYVJppvATyPxpzJUOe59jw@mail.gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:0fSCfNjM8lMyEDibNCUuFEK4DVAl9x1xRrrOTrVd+dcf6Tg1Z4Z
 S2LzrvOrbzv1lpKiGmZWsUbG+cgZPVIvsjLUSTmzrdfKv1Nw3Hau+Yyydw5yJm4z+Y3P2OQ
 //MPHmq+267YSrJx8w99rlJFf1/T8Lcy6V6D0bbJC9T40Hxmhko1LZ7ec4xDsshK+BDlQ/7
 gRw5mVkE7itr8XAC7j4/Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:j6HKpprtbB0=:MSEK4W1a4q1u/7LT5gFzYk
 juL9b96AeDb1kUb+SYRsgp/joHlFs329nXDuzrnyLxBZbqvI4ABV4S8mTtirJmfs/w2OGNPDN
 Lzaj7IexV6Sxozb2Rwo6dNiTihMvnPURMMekY2I73iwIUYM7xKLooOqqIM8LH+naZVVJPXamM
 1E0aPxJRmHe6yt0V+bVLwQ0zHvl4G1Qpc7bVV8P4jo/N4zhVkJvET9GplQn/4fr0ABcJNvU2y
 Jz6fk+H7WucK7SZu7bgKIpGzxMDOIWLq9eXVTyulKNIOnysMTbVYAe0EhwWncigu9dX8qgDRf
 zVC5N7L0Idk4+dEql516mlYUcBwXvkTG4eWVVcq5iA01Qev67zaK7Lc2LQi8lk942zR2G5J5Z
 87vgGNL/SyD5aCPRZ9C0g5Mpl5LoTbfoL6qELG5zTlwFOUZd27Gm6k1W1K/49eoJH4KkgqbAr
 +kQwyzk9PxyGcuvNyulUdn0S14LvO5xkNS4No0tPlFwSEPBYtfgi/tLgie4mm3VTpOzr+7IGr
 IPRxIsikHCRDhFMGE7WD9I/3Mo7pZ3NsQ/90w2pzy769r1LDYfJsYN2/C5MB4D6Moqwm0f9NB
 +FEhVTvFcE1m7gYIfL53H+X552x8LVeUlDukLCrz0dE4sjnMWKnY+Vlu8h6NIKPv8k3tLcpfU
 xAjfk6WpfLGFhAydEo92aMWK2ZkbD5DuIfArYLG0W9He8DAvtw5hI1hsIDWbA/ptwQ1g=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272656>

Hi,

On 2015-06-25 03:01, Stefan Beller wrote:
>> * pt/pull-builtin (2015-06-18) 19 commits
>>  - pull: remove redirection to git-pull.sh
>>  - pull --rebase: error on no merge candidate cases
>>  - pull --rebase: exit early when the working directory is dirty
>>  - pull: configure --rebase via branch.<name>.rebase or pull.rebase
>>  - pull: teach git pull about --rebase
>>  - pull: set reflog message
>>  - pull: implement pulling into an unborn branch
>>  - pull: fast-forward working tree if head is updated
>>  - pull: check if in unresolved merge state
>>  - pull: support pull.ff config
>>  - pull: error on no merge candidates
>>  - pull: pass git-fetch's options to git-fetch
>>  - pull: pass git-merge's options to git-merge
>>  - pull: pass verbosity, --progress flags to fetch and merge
>>  - pull: implement fetch + merge
>>  - pull: implement skeletal builtin pull
>>  - argv-array: implement argv_array_pushv()
>>  - parse-options-cb: implement parse_opt_passthru_argv()
>>  - parse-options-cb: implement parse_opt_passthru()
>>
>>  Reimplement 'git pull' in C.
>>
>>  This is v4 ($gmane/271943).
>>  Comments from mentors and others?
> 
> I think the series is good as is.

I just had a fresh look. Some comments:

- I *think* that the current `recreate_opt()` is fine, but if it is used more, we will have to quote the arguments to guard against spaces and quotes and whatnot

- There is a loop

        for (; *argv; argv++)
               argv_array_push(array, *argv);

  which might want to be written as

        while (*argv)
               argv_array_push(array, *(argv)++);

  to conform better with Git's coding style, but this one is not crucial at all.

Having said that, I really think this is impressive work, and not only the outcome. It is a real pleasure to have you, Paul!

I vote for merging, too,
Dscho
