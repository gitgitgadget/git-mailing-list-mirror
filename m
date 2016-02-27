From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH 01/16] bisect: write about `bisect next` in documentation
Date: Sat, 27 Feb 2016 20:38:59 +0100
Message-ID: <56D1FB53.2020404@gmx.net>
References: <1456452282-10325-1-git-send-email-s-beyer@gmx.net>
 <1456452282-10325-2-git-send-email-s-beyer@gmx.net>
 <xmqqoab3jokp.fsf@gitster.mtv.corp.google.com> <56D1A873.1090709@gmx.net>
 <xmqqk2lqghdw.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 27 20:39:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZki6-0001jY-FO
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 20:39:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945940AbcB0TjW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Feb 2016 14:39:22 -0500
Received: from mout.gmx.net ([212.227.17.21]:53362 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751389AbcB0TjW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2016 14:39:22 -0500
Received: from [192.168.178.43] ([92.76.250.14]) by mail.gmx.com (mrgmx103)
 with ESMTPSA (Nemesis) id 0LyVcA-1ZokYl3k9e-015sxt; Sat, 27 Feb 2016 20:39:02
 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.5.0
In-Reply-To: <xmqqk2lqghdw.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:VV+iz6Lf6FV4jMhP49y89lk2jnVC1gkOr+96WNVMa/7vs7/JBi3
 ZjGpSv2golXbozI3UimNgxEoQ98MPfH09MFABQc1kdSf07DQyZvMW/NZ8O0NNcgmRiKER3/
 61+FWu/wetNmdpNTc4qYKNXrA3yddBnzaED9faXQxlq3aP+X+10xSDeKGvbFDrqJLWfL6zo
 6ORhFwv7pE/Z50Xx2jFOA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cg/ikDJj+go=:SRPhcIMDkNA1NfsCE5dxjD
 Eolt5Tb4APHCz/11ZZnynmB3n9MlFKKFptoelVcgqwjKQRnAlvaAlVCsBdsAExzE8hQettTIn
 s2UZ+AoHqpHuezF1IEYTv0OSKPZFsAOWw36gOFS8gw6+xjG/DOdzPfIaUembcVhiUHYyyoqJX
 sI0N3RsDgGI8wbd5qqSfiGXJqMqdxd+Vj7jA+YrargxQ0UiZiCcZkOEb7Otgw2EQcOyJ6fGJQ
 A7eL2iaW9PAij5MNHvB/c7HLdB+zqJ41zdyi5ZdsLIspr0i33tP3Q6tPGgjPKdJpH3vElUWWw
 dXKMorhBauB3Kcvj32rbnB/AlEHn7YfkoQXGEaa71K2F+4BGsjinaft1aAVTSuxB8CQu6kW3/
 rIxuMIX9QviY5weQ+g/eXQBT9RMFxAeWgfEKC9YRMHSOVeFGdnvblWE4JbMbUzPlmNRRZINkz
 eDikLtldCD64a7BNYxY5WKVVeyN37uG/nn81oDBhCWs8RMZK+9qKTORhANpvDiKL3p4B8Mul4
 jRVnbXa4Ugk+CXEZXZgfPYpSPgR5j7FFp0ly3PWjHgsTybt+yBw0ieyrKLd1lkJpfX7dX5stX
 4YLyoqKPaYrS5D05wueZS7XATAuITCEuRUY/p47RyjcHJWOYaK4/CRSzmRmnIJkUuRZkQEPx1
 4Cd31uOJ1neEDaQpE9ZE373HZKTTwESeRDkI8R62oIcMMQaqFhu1WEbTTPMP9uCh5Om8vvi9U
 WF0Y5PJE9vtzzzt0h6mYNqp4sYkFW8hSOxcUu+nCKCYd0y1LNKvwQzl2HeKO3W/DYeZs0Pi/ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287727>

Hi,

On 02/27/2016 07:03 PM, Junio C Hamano wrote:
> Stephan Beyer <s-beyer@gmx.net> writes:
> 
>> This command is also handy when you accidentally checked out another
>> commit during a bisection. It computes the commit for the bisection
>> and checks it out again.
>>
>> -->8-->8-->8--
>>
>> Is that better?
> 
> Thanks, I think it is definitely better than the original patch.
> 
> I cannot say it is better than not having that extra paragraph,
> though.

Okay, I will remove that extra paragraph.

However, it probably should be documented what "git bisect next" does
after you've specified bad and good commits.

For that, I'd like to have an extra informational paragraph.
What about: "In general, the command computes the next commit for the
bisection and checks it out."
This would be neutral, in the meaning that no use case is involved.

Another more "strict" choice could be to change the behavior such that
"git bisect next" dies when invoked after a good (and a bad) commit is
specified. In that case, there is no need to document the behavior ;-)
However, in that case the name of "git bisect next" would be wrong...

Cheers,
Stephan
