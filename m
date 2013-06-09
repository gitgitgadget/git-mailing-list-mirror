From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH v4 42/45] add tests for rebasing merged history
Date: Sun, 9 Jun 2013 19:32:44 +0200
Message-ID: <87obbfchqb.fsf@hexa.v.cablecom.net>
References: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
	<1370796057-25312-43-git-send-email-felipe.contreras@gmail.com>
	<87wqq3ci1n.fsf@hexa.v.cablecom.net>
	<CAMP44s30YkE5i7B==pyB8zkNxu=YoGvP1=V_2LqOe_frXV+cfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	"Ramkumar Ramachandra" <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	"Martin von Zweigbergk" <martinvonz@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 09 19:32:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UljU2-00065Z-OH
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 19:32:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393Ab3FIRcr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 13:32:47 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:37036 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750949Ab3FIRcq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 13:32:46 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sun, 9 Jun
 2013 19:32:31 +0200
Received: from hexa.v.cablecom.net.ethz.ch (46.126.8.85) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sun, 9 Jun
 2013 19:32:44 +0200
In-Reply-To: <CAMP44s30YkE5i7B==pyB8zkNxu=YoGvP1=V_2LqOe_frXV+cfQ@mail.gmail.com>
	(Felipe Contreras's message of "Sun, 9 Jun 2013 12:31:45 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227040>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Sun, Jun 9, 2013 at 12:25 PM, Thomas Rast <trast@inf.ethz.ch> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> +#TODO: make order consistent across all flavors of rebase
>>> +test_run_rebase success 'd e n o' ''
>>> +test_run_rebase success 'd e n o' -m
>>> +test_run_rebase success 'd n o e' -i
>>
>> [45/45] would seem to imply that these tests fail as of this patch.  Is
>> that correct?
>>
>> If so, please either squash that change or move the test further up
>> marked as 'failure'.
>
> I won't. The whole purpose of the last patch is to show these tests are fixed.
>
> Martin von Zweigbergk's patch series is independent of this one, I
> merely added it to show the above.

So you would deliberately break a bisection on this test file?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
