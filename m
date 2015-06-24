From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: What's cooking in git.git (Jun 2015, #05; Mon, 22)
Date: Wed, 24 Jun 2015 09:16:02 +0200
Organization: gmx
Message-ID: <ad998ee2d8387401a3ceb6a7df7457ab@www.dscho.org>
References: <xmqqzj3re4u5.fsf@gitster.dls.corp.google.com>
 <3fe144b0808827da3efbfcc44ad43524@www.dscho.org>
 <xmqq616ecfuq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 24 09:16:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7eur-0007Im-EY
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jun 2015 09:16:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750925AbbFXHQI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2015 03:16:08 -0400
Received: from mout.gmx.net ([212.227.15.15]:62989 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750847AbbFXHQH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2015 03:16:07 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0M2tXS-1Yqgar0ebm-00sciC; Wed, 24 Jun 2015 09:16:03
 +0200
In-Reply-To: <xmqq616ecfuq.fsf@gitster.dls.corp.google.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:hJP6BMTRzjDFx9/DQwUWZlQi+L+rwXz/Yv7F1m21FPgD+N3s//m
 dRSXG+hCCudBdBp+hyt2J1Y6vaFuavOyf6C66I25Jo3C59yvXB/FDHb8u+pmqPXacbcDA7R
 y9ZjsyA/9Nhc0QSWMuMkueZpj3DVPAgFXmtnouxn0Kx+63yXpj7maCgi+cWmKla645xktSo
 lUCcEEGOHbBTk4+rHpr9g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DkB+CpH1zlw=:KpcDYvR9xJ08w7z4FgUr+u
 vD4Zx0aaBxMxW1VUBREwfWC/67c+eZs553ZilTbsOaeKgmxnv91Xu0IU+b73LpIBx74y3mYhW
 UFuvpf1WcRPd/xZZrW/OCq31Vko5x0GH/57rDLXQQw6HK/bU5K/qtx2ZQQ+txUNZq4HIIkdFR
 54dT3uDe7XI5p49vLWgkySeq+PtVnkVCLJgARN8cMDYlfwm/W8HcSri/EU4wtPr5wpWHCstQM
 QWHm/otfjrCP+errTunT/ciB5oR0NNi4HO4TAgi2vassIoUIh1AbWs0Kj11h7MW/naQUFLKJT
 nVoccXUmTR++HGPhMHwoFNgpSN9sZHbw0c9fF6tbW03udFKZdAjeg7ec1TytcKoOWl6cSNCLi
 J/v9S1EjHQ8iM/1io1eP3bdw5GV3b4nY6EoEE74rsQWbnilNF6AcfDHzBsRLwGzV+GcV4gQG1
 PafSJRkHIWCePd4o8h4VDi3oIDxD1Q0hTYkizM0g6/GWbpRzOQgbboTGuP3zpWVvg5YjdrGvv
 pX8H4i4or4mWocOQGDAbxSiz2UWMSLxBjy9psq/vg6XjphOXvPPVRK1DZqTJh5XAduCfj9RE6
 nTBHH/tELLPyl7rP1Y+kR8fG8JqmoMAJXYg3r7TrEDQ/7fgk5T5N2+6OnxqBWgUslG3dyyoc2
 359XwdCXEodTwspOvzjjLTFrpR7F9D6z+fClBPjtC5fOW5q3xi444WRr+oj0E86i0IFw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272534>

Hi Junio,

On 2015-06-23 22:46, Junio C Hamano wrote:
> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
>> On 2015-06-23 00:49, Junio C Hamano wrote:
>>
>>> * js/rebase-i-clean-up-upon-continue-to-skip (2015-06-18) 3 commits
>>>  - rebase -i: do not leave a CHERRY_PICK_HEAD file behind
>>>  - SQUASH: test_must_fail is a shell function
>>>  - t3404: demonstrate CHERRY_PICK_HEAD bug
>>>
>>>  Abandoning an already applied change in "git rebase -i" with
>>>  "--continue" left CHERRY_PICK_HEAD and confused later steps.
>>>
>>>  Expecting a reroll.
>>>  ($gmane/271856)
>>
>> Actually, there had been two re-rolls, and v3 seemed to be okay:
>> $gmane/272037. It also looks as if 726a35ebd^..726a35ebd^2 is
>> identical with v3... Anything you want me to change in addition?
> 
> Thanks for a pointer; I think I updated the topic and then forgot to
> update the reference in "whats cooking".  I'll take a look at 272037
> and if I have anything further will comment there.

Thanks.

>> Also:
>>
>>> * js/fsck-opt (2015-06-22) 19 commits
>>> [...]
>>>
>
> [...]
> 
> If the for-layout is the only thing that is questionable thing to
> fix in what I queued, I think I can locally fix-up without an extra
> roundtrip.  

It is the only thing (and not even questionable ;-)).

Thanks!
Dscho
