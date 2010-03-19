From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH] Clarification for the command "git checkout <branch>"
Date: Fri, 19 Mar 2010 09:15:26 +0100
Message-ID: <4BA3329E.6050304@web.de>
References: <4B67227A.7030908@web.de> <4B898F97.90706@web.de> 	<7vr5o6s5xf.fsf@alter.siamese.dyndns.org> <4B8B9BF1.10408@web.de> 	<4b8bf32f.0706c00a.26cb.691d@mx.google.com> <4BA104C7.5020207@web.de> 	<32541b131003170944w7a0215frcace205f32d313bf@mail.gmail.com> 	<7vaau6q18q.fsf@alter.siamese.dyndns.org> <4BA1FC39.10300@web.de> 	<32541b131003180936x746dad06k386788d3cb6fcdeb@mail.gmail.com> <b4087cc51003181019r4408953bxcd5049c9521b8173@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 19 09:15:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsXMu-0001u5-Nr
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 09:15:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752117Ab0CSIPg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Mar 2010 04:15:36 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:42080 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751280Ab0CSIPe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Mar 2010 04:15:34 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate02.web.de (Postfix) with ESMTP id F2ADF1560B698;
	Fri, 19 Mar 2010 09:15:31 +0100 (CET)
Received: from [78.49.72.233] (helo=[192.168.1.2])
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #4)
	id 1NsXMh-0003qs-00; Fri, 19 Mar 2010 09:15:31 +0100
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.5) Gecko/20091204 Thunderbird/3.0
In-Reply-To: <b4087cc51003181019r4408953bxcd5049c9521b8173@mail.gmail.com>
X-Enigmail-Version: 1.0
X-Sender: Markus.Elfring@web.de
X-Provags-ID: V01U2FsdGVkX1+olnrwNs6jJ2B4vFWKo2iIDRfBazWL02m6oJ2K
	Q4EMYmDJ3Ta9DFF5vmvzO14L8rkvfJyhXj+0U+BN3TVmfiWhPW
	4cE5VQthQCImTDaejyvA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142566>

> Are you not reading? Are you not comprehending? Are you trolling?

I answer these three questions with "NO".

I find that the discussion is not finished yet. It was not achieved a common
conclusion and consensus on all mentioned details so far.


>> stashing isn't really something you'd want to do on a per-branch
>> basis.  Most of the point is that you stash away your changes, then
>> switch to another branch, then restore your stash to your *current*
>> working state sometime later.

I have got different expectations. I would expect that there are enough
intermediate work results available to justify a stash per branch so that
unwanted "temporary" or "throw-away" commits can be avoided.


> As you may know, "git checkout" carries local modifications to the new
> working tree if there are no conflicts, so no explicit stash usage is
> necessary in many cases.

Various software projects have got different amounts of uncommitted changes
between branches.


> Anyway, I think it would be useful to be able to manage multiple
> stashes rather than having to rely on just one global stash. However,
> I imagine than explicit Work In Progress (WIP) commits as sketched
> above would go a long way in keeping histories and workflows clean
> and organized.

I am also interested in improvements for this feature request. Does a "WIP"
really need a commit to get the unfinished changes stored?

Regards,
Markus
