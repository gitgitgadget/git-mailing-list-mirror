From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [BUG] "git pull" will regress between 'master' and 'pu'
Date: Tue, 21 Apr 2015 09:23:07 +0200
Organization: gmx
Message-ID: <84c2d3dcb754d14a9f43deb7bbb6fd79@www.dscho.org>
References: <xmqqbnikoq0n.fsf@gitster.dls.corp.google.com>
 <xmqq8udmlhu0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Paul Tan <pyokagan@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 09:23:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkSWg-0002fp-4t
	for gcvg-git-2@plane.gmane.org; Tue, 21 Apr 2015 09:23:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751621AbbDUHXR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2015 03:23:17 -0400
Received: from mout.gmx.net ([212.227.15.19]:63245 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750751AbbDUHXO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2015 03:23:14 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0Lx83d-1ZPiPU27OT-016eMB; Tue, 21 Apr 2015 09:23:09
 +0200
In-Reply-To: <xmqq8udmlhu0.fsf@gitster.dls.corp.google.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:Fgw0Ucx2/Jv6RCrNs3VkVFZgiZlJoSHqDZ4N4uKGvuHUyJ65v5E
 T1XB1DHUyxrsjiY/rNvi4/g09TfFqV5WtYNPKy08v1/oNwKvgeN4R9NkqcWtPvJ5MPSyn8t
 lRGMzLSu9vcfBFNkl4fflBxTCWLergVZtep4tTWrC71i4EVPzOdL+PvXbjLmct8/9mDiqNI
 wDvVug0cw74m3ziHz9ETQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267520>

Hi Junio,

On 2015-04-20 21:28, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> This is primarily note-to-self; even though I haven't got around
>> bisecting yet, I think I know I did some bad change myself.
>>
>> "git pull $URL $tag" seems to:
>>
>>  * fail to invoke the editor without "--edit".
>>  * show the summary merge log message twice.
> 
> We seem to be making a good progress on the discussion on this
> specific issue, but a larger tangent of this is that we do not seem
> to have test coverage to catch this regression.  As we are planning
> to rewrite "git pull", we need to make sure we have enough test
> coverage to ensure that nothing will regress before doing so.

Yes, the plan is to use code coverage tools to ensure that a decent amount of code paths/parameters is covered.

Ciao,
Dscho
