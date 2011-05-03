From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v3] Add default merge options for all branches
Date: Tue, 03 May 2011 22:37:48 +0200
Message-ID: <4DC0679C.7090705@web.de>
References: <4DBF04C5.1080608@dailyvoid.com> <4DBF94E9.2010502@dailyvoid.com> <20110503090351.GA27862@elie> <7vk4e7ir9v.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Michael Grubb <devel@dailyvoid.com>, git@vger.kernel.org,
	vmiklos@frugalware.org, deskinm@umich.edu
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 03 22:38:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHMMP-0001xd-2F
	for gcvg-git-2@lo.gmane.org; Tue, 03 May 2011 22:38:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755135Ab1ECUiR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2011 16:38:17 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:43412 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754669Ab1ECUiQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2011 16:38:16 -0400
Received: from smtp05.web.de  ( [172.20.4.166])
	by fmmailgate02.web.de (Postfix) with ESMTP id B5ECF19EAA497;
	Tue,  3 May 2011 22:37:53 +0200 (CEST)
Received: from [93.240.110.187] (helo=[192.168.178.43])
	by smtp05.web.de with asmtp (WEB.DE 4.110 #2)
	id 1QHMLx-0007d0-00; Tue, 03 May 2011 22:37:53 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <7vk4e7ir9v.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1++ZQBfIFmRwc8A9TaV878TpcFtFO6MWhYBiHqY
	8rdOZFXXxuKyRI7wundwogcXxW4dV06ARZixzlywFETJO7zIeT
	uGp/ezVBmXguIJXtloDg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172691>

Am 03.05.2011 20:16, schrieb Junio C Hamano:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>>> The need for this arises from the fact that there is currently not an
>>> easy way to set merge options for all branches.
>>
>> I'm curious: what merge options/workflows does this tend to be useful
>> for?
> 
> I actually am curious myself, too.  I want to see a real-life example.

At my dayjob the reviewer of a branch does the merge of a topic into
master. And to always record who did the review even if the merge is
a fast forward we use the "branch.master.mergeoptions=--no-ff" config
in all our repos, set by our installer.

But that doesn't work out of the box for our release branches, we have
to manually set stuff like "branch.v1.23-4.mergeoptions=--no-ff" for
every release branch in every clone where merges are done. This is easy
to forget and as we use git gui for our daily work, we can't simply use
the command line option --no-ff.

So we would greatly benefit from this patch (and actually I looked into
doing it myself some time ago but postponed it to do some submodule
stuff first ;-)
