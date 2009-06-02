From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 (resend) 0/4] git-am foreign patch support
Date: Tue, 02 Jun 2009 08:21:39 -0700
Message-ID: <7v4ouyhda4.fsf@alter.siamese.dyndns.org>
References: <1243897841-8923-1-git-send-email-giuseppe.bilotta@gmail.com>
	<20090602195608.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Tue Jun 02 17:21:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBVoC-0003S4-Ja
	for gcvg-git-2@gmane.org; Tue, 02 Jun 2009 17:21:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754857AbZFBPVj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2009 11:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754157AbZFBPVi
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jun 2009 11:21:38 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:39158 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753864AbZFBPVi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2009 11:21:38 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090602152140.LPUE20430.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Tue, 2 Jun 2009 11:21:40 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id z3Mf1b00E4aMwMQ033Mfak; Tue, 02 Jun 2009 11:21:39 -0400
X-Authority-Analysis: v=1.0 c=1 a=ucx4rhAh2I8A:10 a=497Oa7M7Ar8A:10
 a=UQnXkbzPAAAA:8 a=pGLkceISAAAA:8 a=27TZGWMQZ0j2Sw980nQA:9
 a=0MukbAEwymZcNkvF1eL6MNd2HIMA:4 a=Q21-j9j7q-gA:10 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <20090602195608.6117@nanako3.lavabit.com> (Nanako Shiraishi's message of "Tue\, 02 Jun 2009 19\:56\:08 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120518>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Quoting Giuseppe Bilotta <giuseppe.bilotta@gmail.com>:
>
>> Junio mentioned that he's ready to apply the series cleanly, so here's
>> a resend rebased on latest 'next' and without any 'bis' patches ;-)
>>
>> Giuseppe Bilotta (4):
>>   git-am foreign patch support: introduce patch_format
>>   git-am foreign patch support: autodetect some patch formats
>>   git-am foreign patch support: StGIT support
>>   git-am: refactor 'cleaning up and aborting'
>>
>>  git-am.sh |  133 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>>  1 files changed, 129 insertions(+), 4 deletions(-)
>
> May we have a summary of what's updated, compared to the version that has been in the "pu" branch?

A good thing to ask, for two reasons, as (1) Giuseppe might not have known
about what were in 'pu', and (2) I _did_ fix up his earlier series when I
queued, and his "resend" loses them.

I just compared what is in 'pu' with this resend, and the only changes I
saw was my fix-up, so I'll keep the previous ones.

Thanks.
