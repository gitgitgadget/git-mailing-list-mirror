From: Ralf Ebert <info@ralfebert.de>
Subject: Re: --mixed option is deprecated with paths
Date: Sat, 14 Aug 2010 21:12:06 +0200
Message-ID: <i46pq6$6ge$1@dough.gmane.org>
References: <AANLkTik_NuG3YKMknwh4fAK09kTH0tK1f08MzsexUMcV@mail.gmail.com>	<i46nvf$fa$1@dough.gmane.org> <AANLkTimT7jTQeN1qUBSWTwEEt9jWirwwS3bSHT7OysUs@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 14 21:12:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OkM9V-0002tG-Up
	for gcvg-git-2@lo.gmane.org; Sat, 14 Aug 2010 21:12:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266Ab0HNTMR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Aug 2010 15:12:17 -0400
Received: from lo.gmane.org ([80.91.229.12]:54560 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750932Ab0HNTMQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Aug 2010 15:12:16 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OkM9P-0002qt-LJ
	for git@vger.kernel.org; Sat, 14 Aug 2010 21:12:15 +0200
Received: from port-92-198-61-236.static.qsc.de ([92.198.61.236])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 14 Aug 2010 21:12:15 +0200
Received: from info by port-92-198-61-236.static.qsc.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 14 Aug 2010 21:12:15 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: port-92-198-61-236.static.qsc.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.11) Gecko/20100713 Thunderbird/3.0.6
In-Reply-To: <AANLkTimT7jTQeN1qUBSWTwEEt9jWirwwS3bSHT7OysUs@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153574>

On 14.08.2010 20:55, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Sat, Aug 14, 2010 at 18:40, Ralf Ebert<info@ralfebert.de>  wrote:
>> On 14.08.2010 17:23, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>>
>>> So what should I use instead? 0e5a7faa which introduced it doesn't =
say.
>>
>> It doesn't currently exist, but I'm pretty sure it should be called =
'git
>> unstage' :)
>
> Then perhaps it should be undeprecated? If what you say is correct
> it's been whining about that since 2007 with no alternative, while
> doing what I mean when I run it.

Sorry, I misremembered '--mixed' again, '--mixed' is the default and it=
=20
doesn't complain if you just omit it, and if I read&tried right, 'git=20
reset <file>' does the same as 'git reset --mixed <file>'.
