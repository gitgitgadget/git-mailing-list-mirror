From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 7/8] config: add core.untrackedCache
Date: Tue, 15 Dec 2015 10:49:28 +0100
Message-ID: <566FE228.8040708@web.de>
References: <1449594916-21167-1-git-send-email-chriscool@tuxfamily.org>
 <1449594916-21167-8-git-send-email-chriscool@tuxfamily.org>
 <xmqqsi3ckadi.fsf@gitster.mtv.corp.google.com>
 <xmqqfuzck1dp.fsf@gitster.mtv.corp.google.com>
 <CAP8UFD3at0X9ThpXGTwyPnu_dXFj6x=YzfkCa82m+RsWwhFOOA@mail.gmail.com>
 <xmqq6100ke7v.fsf@gitster.mtv.corp.google.com>
 <xmqqa8pciuqq.fsf@gitster.mtv.corp.google.com>
 <CAP8UFD0ex4JuU=FMDwnSnf9io16=D2_m3x1ajXtCu25OU_DLAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?Q?Torsten_B=c3=b6gershause?= =?UTF-8?Q?n?= 
	<tboegi@web.de>, Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 15 10:50:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8mF5-0002Ey-HK
	for gcvg-git-2@plane.gmane.org; Tue, 15 Dec 2015 10:49:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933254AbbLOJtz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2015 04:49:55 -0500
Received: from mout.web.de ([212.227.15.4]:55030 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932275AbbLOJtv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2015 04:49:51 -0500
Received: from birne9.local ([213.66.56.100]) by smtp.web.de (mrweb001) with
 ESMTPSA (Nemesis) id 0M6UmJ-1aRZPL22vL-00yTjH; Tue, 15 Dec 2015 10:49:32
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:38.0)
 Gecko/20100101 Thunderbird/38.4.0
In-Reply-To: <CAP8UFD0ex4JuU=FMDwnSnf9io16=D2_m3x1ajXtCu25OU_DLAw@mail.gmail.com>
X-Provags-ID: V03:K0:skMoreb4RPR59+YI36GdBB+NfLu3flG9Im3kMqSEQV0Oy+6DMtN
 JCEB9oAHxsiN7yYPWpyFSlIQY/RcsxPlocTRcBciTaCyDyouwaA3aLCfOusT2RRFAeksRUJ
 +nnCWuqhHzJz7CAAM1/K/h8Xa5V52TaihonOx27e9RZ1Z59guzFDICZz53k0KWmjcf3mGow
 ke2OCXfg/hBAx5M8c43dQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OXyMk5MYRSY=:d5IUMpyk+GiGduDISkwqz3
 QoDdelLY3C3t98Oz7dK527kzYMgU2tmD7bKrcnjnel1rdWBkdEZiSHEKFcoMAS0s+pxpZ/Uqg
 1P+qZemuK+HvbhHw9h/yr8qj/1XwQdYLtJ1JPxNLk1L2OuN41xI7G0BNE8CWJgALQd4bsWMtQ
 eqLYF9tg+OHJSZR1YyquXfU3TuusSctYyFTDAWos32qb/RV1VigMcEmBhzra06jQywW6Keyb7
 MZAS5N7IVI1EQZT1/uRr3LfEXfmIsg3yNTdxmoL8C9IsLNOn1w4g3BCxtLA5BVGHlr91GZAmO
 ISaXcm6hCtKkzlJFBbz4m2hOdlpS1FOvZibMurMVkM84aIY9kLw7i+gBZzEmPsf1O+pdmLzf1
 V9qa6lDij4AE18TagNkZEArjgIpDi2TUulmEULkcSBdGEdW5MiBWRVT9Ul1opCUb7TiFiwIr1
 Ky89fHTKwLJk7iOGXOnLhmODGTNmCy0SFJC/1pBy/sQ5t+qsQgTikq3JbebBMxXjM5hAm40oB
 rh7PI7MhiLym6J015SC1SUXtBEQGw1ZIKUZ+gtDzVll2DSZIQ9FCNULdecVMEXzbl9Lbf9bBG
 lkfX2OX1p2ETOtAroMPugncP/q8oQ+fD2abmXeeLmEPSCWYgcu3dW6HLejJDeCiUGC7bQSOol
 13XUvDZM+QB3mRFQbk7k831nvOL3bwwqCO+BQziYdFP1p4x9oOqtgxDwA0LsGZYxGVwl9wWf9
 7jQK1szlVStZayVFKyD/aXdTGabrwutTvcK0T4yEsHIxa4MtLhp39eCm0UkOjXw3MNQLYVgp 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282469>

On 15.12.15 10:34, Christian Couder wrote:
> On Mon, Dec 14, 2015 at 10:30 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>> The primary reason why I do not like your "configuration decides" is
>> it will be a huge source of confusions and bugs.  Imagine what
>> should happen in this sequence, and when should a stale cached
>> information be discarded?
>>
>>  - the configuration is set to 'yes'.
>>  - the index is updated and written by various commands.
>>  - more work is done in the working tree without updating the index.
>>  - the configuration is set to 'no'.
>>  - more work is done in the working tree without updating the index.
>>  - the configuration is set to 'yes'.
>>  - more work is done in the working tree without updating the index.
>>  - somebody asks "what untracked paths are there?"
> 

> As far as I understand the UC just stores the mtime of the directories
> in the working tree to avoid the need of lstat'ing all the files in
> the directories.

This is what I understand:
UC stores the mtime of the directories in the working tree to avoid the need 
opendir() readdir() closedir() to find new, yet untracked, files.
(including sub-directories)
