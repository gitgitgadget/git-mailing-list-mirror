From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: [PATCH] Replace perl code with pure shell code
Date: Mon, 29 Jan 2007 05:21:04 -0800
Message-ID: <864pqadl4v.fsf@blue.stonehenge.com>
References: <45BDABB5.4070301@fs.ei.tum.de>
	<86zm82dpql.fsf@blue.stonehenge.com>
	<dbfc82860701290438y4e00cc05s5f8c8acdc8022768@mail.gmail.com>
	<86fy9udmf6.fsf@blue.stonehenge.com>
	<dbfc82860701290517p739c78a1td05fd0900e280515@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Simon 'corecode' Schubert" <corecode@fs.ei.tum.de>,
	git@vger.kernel.org
To: "Nikolai Weibull" <now@bitwi.se>
X-From: git-owner@vger.kernel.org Mon Jan 29 14:21:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBWRb-00040S-2Z
	for gcvg-git@gmane.org; Mon, 29 Jan 2007 14:21:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356AbXA2NVH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Jan 2007 08:21:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbXA2NVH
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jan 2007 08:21:07 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:24817 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751356AbXA2NVG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jan 2007 08:21:06 -0500
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 35C751DEA9C; Mon, 29 Jan 2007 05:21:04 -0800 (PST)
x-mayan-date: Long count = 12.19.14.0.7; tzolkin = 9 Manik; haab = 0 Pax
In-Reply-To: <dbfc82860701290517p739c78a1td05fd0900e280515@mail.gmail.com> (Nikolai Weibull's message of "Mon, 29 Jan 2007 14:17:43 +0100")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38080>

>>>>> "Nikolai" == Nikolai Weibull <now@bitwi.se> writes:

Nikolai> On 1/29/07, Randal L. Schwartz <merlyn@stonehenge.com> wrote:
>> >>>>> "Nikolai" == Nikolai Weibull <now@bitwi.se> writes:
>> 
Nikolai> We do require a POSIX-compliant version of sh already, right?
>> 
>> OK, sorry for raising the flag.  I just know that writing portable shell
>> is far trickier than writing portable Perl, so I get overly cautious
>> on anything that wasn't in Unix V7.

Nikolai> No problem; I wasn't sure on the current requirements myself :-).
Nikolai> It's too bad that not all the great stuff one can find in Bash and Zsh
Nikolai> were in the original...

I'll probably seem like a traitor to my tribe for saying this, but if zsh or
gnu awk had been around at the time Perl was created, we wouldn't have seen
Perl.  Of course, Perl has gone far beyond the "awk replacement" as originally
planned, but who knows what might have happened next?

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
