From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: What's cooking in git.git (Sep 2013, #01; Tue, 3)
Date: Wed, 04 Sep 2013 22:52:33 +0200
Message-ID: <52279D91.2030802@web.de>
References: <xmqqppspo6i7.fsf@gitster.dls.corp.google.com> <vpq7gew6c0v.fsf@anie.imag.fr> <xmqqfvtkmm2d.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 04 22:52:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHK48-0001gv-GR
	for gcvg-git-2@plane.gmane.org; Wed, 04 Sep 2013 22:52:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761394Ab3IDUwg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Sep 2013 16:52:36 -0400
Received: from mout.web.de ([212.227.17.12]:54172 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761378Ab3IDUwf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Sep 2013 16:52:35 -0400
Received: from [192.168.178.41] ([91.3.170.120]) by smtp.web.de (mrweb004)
 with ESMTPA (Nemesis) id 0Mbdf3-1VXbtf0oMf-00J2kW for <git@vger.kernel.org>;
 Wed, 04 Sep 2013 22:52:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <xmqqfvtkmm2d.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.5.2
X-Provags-ID: V03:K0:RX/AJvxu6+rADD8gZ1P15VCH1n1dyNC2MNqVFXVtEjRY1bFeKHl
 N86cXMLEXT/6ESFkUyBip6JpAZdeHBGegPa+Ube3MDc0JBN27Ohes0SPElKgVl4L/vcIO0V
 XiI+a6cOjis+Nb2Odx/uPaQ6N62TWX0D3lp0/7wKg/vbsrxoYwlfXgMtWSkVxFSQnNIdSuZ
 xXJofoM2Lv4ZJekvGxknw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233876>

Am 04.09.2013 21:19, schrieb Junio C Hamano:
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
> 
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> * mm/status-without-comment-char (2013-08-29) 5 commits
>>>  - status: introduce status.displayCommentChar to disable display of #
>>>  - SQUASH: do not fprintf() random strings
>>>  - get rid of "git submodule summary --for-status"
>>>  - wt-status: use argv_array API
>>>  - builtin/stripspace.c: fix broken indentation
>>>
>>>  Allow "git status" to omit the prefix to make its output a comment
>>>  in a commit log editor, which is not necessary for human
>>>  consumption.
>>
>> I'm waiting for the situation of "git submodule --for-status" to be
>> settled to send a reroll. Don't merge this for now, and let
>> bc/submodule-status-ignored converge.
> 
> Thanks.  I had an impression that bc/submodule-status-ignored was
> still being discussed.  Has what I have in 'pu' settled?

Almost (see my other mail concerning bc/submodule-status-ignored).
If the removal of the --for-status option is reverted from patch #3
here (which I outlined in $gmane/233764) this series can be merged
without really depending on bc/submodule-status-ignored (even though
the temporarily unused --for-status option may look a bit strange
until the latter is merged).
