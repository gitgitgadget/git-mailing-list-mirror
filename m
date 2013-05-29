From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH 1/3] cherry-pick: add support to copy notes
Date: Wed, 29 May 2013 13:34:21 +0200
Message-ID: <874ndmqate.fsf@linux-k42r.v.cablecom.net>
References: <1369745947-19416-1-git-send-email-felipe.contreras@gmail.com>
	<1369745947-19416-2-git-send-email-felipe.contreras@gmail.com>
	<7vobbv119k.fsf@alter.siamese.dyndns.org>
	<87mwrfx9ug.fsf@linux-k42r.v.cablecom.net>
	<51a56bef1b9c2_807b33e1899991@nysa.mail>
	<877giixl4c.fsf@linux-k42r.v.cablecom.net>
	<CAMP44s3vkJCr2f2zsZU++j4Wqxuefmpt8BQ9dJoP=JtTB=rgkQ@mail.gmail.com>
	<87y5ayqivi.fsf@linux-k42r.v.cablecom.net>
	<CAMP44s2aAvzeTtHb=rVP1TrCMcQjyqN6O7n1DYZLx0uJrm1j+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	"Christian Couder" <chriscool@tuxfamily.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 13:34:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UheeD-0001UK-20
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 13:34:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965629Ab3E2LeZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 07:34:25 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:31350 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965495Ab3E2LeY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 07:34:24 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 29 May
 2013 13:34:21 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS12.d.ethz.ch (172.31.38.212) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Wed, 29 May 2013 13:34:21 +0200
In-Reply-To: <CAMP44s2aAvzeTtHb=rVP1TrCMcQjyqN6O7n1DYZLx0uJrm1j+w@mail.gmail.com>
	(Felipe Contreras's message of "Wed, 29 May 2013 06:18:33 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225792>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Wed, May 29, 2013 at 3:40 AM, Thomas Rast <trast@inf.ethz.ch> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> On Wed, May 29, 2013 at 3:09 AM, Thomas Rast <trast@inf.ethz.ch> wrote:
>>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>
>>>>> Feel free to implement that. I'm just interested in 'git cherry-pick' being
>>>>> usable for 'git rebase' purposes.
>>>>
>>>> Which would have been obvious to all but the most casual readers, eh?
>>>
>>> My motivations are irrelevant, the patch is good as it is.
>>
>> You fooled both Junio (AFAICT anyway) and me, who both reviewed the
>> patch under the assumption that it implements note copying *along the
>> lines of existing note copying*.  This proved to be a wrong, and
>> time-wasting, assumption.
>
> Whatever arbitrary rules you are talking about, they are not codified in tests.

Tests or code don't have a thing to do with it.  This is about how you
are presenting your changes to the rest of the git community.  As
evidenced above, said presentation is not clear enough to communicate
your goals to at least two experienced git developers (if I may say so
myself).  How are we supposed to review a change if it is not even clear
what goal it satisfies?

Again: I'll be happy to review your proposed changes if and when you
resend the series with commit messages.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
