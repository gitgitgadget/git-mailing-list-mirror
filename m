From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH 3/3] git-branch -v: show the remote tracking statistics
Date: Wed, 2 Jul 2008 10:44:21 -0400
Message-ID: <CC9ACD5E-2E7E-42D4-AF75-C35C2AB8651E@silverinsanity.com>
References: <20080701091347.GA11817@elte.hu> <80iqvq2bw0.fsf@tiny.isode.net> <20080701101414.GG31309@elte.hu> <7vlk0lmn32.fsf@gitster.siamese.dyndns.org> <7vhcb8en92.fsf@gitster.siamese.dyndns.org> <486B3B05.4080006@viscovery.net> <20080702083306.GA28337@diana.vm.bytemark.co.uk>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>,
	Ingo Molnar <mingo@elte.hu>,
	Bruce Stephens <bruce.stephens@isode.com>, git@vger.kernel.org
To: =?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Wed Jul 02 16:46:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KE3bF-00051G-Rv
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 16:46:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752840AbYGBOpF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Jul 2008 10:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756524AbYGBOpD
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 10:45:03 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:45441 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755892AbYGBOoZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Jul 2008 10:44:25 -0400
Received: from [172.24.32.221] (dfpub107.digitalfocus.com [65.120.79.7])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id EA1591FFC02D;
	Wed,  2 Jul 2008 14:44:19 +0000 (UTC)
In-Reply-To: <20080702083306.GA28337@diana.vm.bytemark.co.uk>
X-Mailer: Apple Mail (2.926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87145>


On Jul 2, 2008, at 4:33 AM, Karl Hasselstr=F6m wrote:

> On 2008-07-02 10:23:33 +0200, Johannes Sixt wrote:
>
>> * jc/report-tracking   41666f7 diverged 3 vs. 117
>
> Or even "ahead 3, behind 117" here. Otherwise the user has to remembe=
r
> which number is which, which kind of defeats your point. And it's jus=
t
> one more character.
>
>>  foo                  1234567 behind 22
>>  bar                  fedcba9 ahead 6

This is probably the most useful for a new user.  The short version of =
=20
that (config option to give it for power users and hide it from those =20
it would confuse) should use plus and minus for ahead and behind:

  * jc/report-tracking        41666f7 [+3 -117] git-branch -v: show =20
the remo...

I can't follow the code with the ten seconds I have to look at it.  Is =
=20
this ahead/behind current branch, tracking branch, or other?

~~ Brian
