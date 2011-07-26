From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH] Documentation/submodule: add command references and update
 options
Date: Tue, 26 Jul 2011 14:54:03 -0400
Message-ID: <4E2F0D4B.2000209@xiplink.com>
References: <4E2B1A54.2000605@web.de> <7vmxg2qf0j.fsf@alter.siamese.dyndns.org> <4E2F0AF7.2070306@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Nikolai Weibull <now@bitwi.se>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Jul 26 20:54:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qlmlm-0003zH-OO
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jul 2011 20:54:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753064Ab1GZSyO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jul 2011 14:54:14 -0400
Received: from smtp152.iad.emailsrvr.com ([207.97.245.152]:58185 "EHLO
	smtp152.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753248Ab1GZSyN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2011 14:54:13 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp35.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTP id 77DAB10856;
	Tue, 26 Jul 2011 14:54:12 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp35.relay.iad1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 2C87D10850;
	Tue, 26 Jul 2011 14:54:12 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.18) Gecko/20110617 Thunderbird/3.1.11
In-Reply-To: <4E2F0AF7.2070306@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177896>

On 11-07-26 02:44 PM, Jens Lehmann wrote:
> Am 25.07.2011 22:30, schrieb Junio C Hamano:
>> Jens Lehmann <Jens.Lehmann@web.de> writes:
>>
>>> @@ -140,11 +146,14 @@ summary::
>>>  	Show commit summary between the given commit (defaults to HEAD) and
>>>  	working tree/index. For a submodule in question, a series of commits
>>>  	in the submodule between the given super project commit and the
>>> -	index or working tree (switched by --cached) are shown. If the option
>>> -	--files is given, show the series of commits in the submodule between
>>> +	index or working tree (switched by '--cached') are shown. If the option
>>> +	'--files' is given, show the series of commits in the submodule between
>>>  	the index of the super project and the working tree of the submodule
>>> -	(this option doesn't allow to use the --cached option or to provide an
>>> +	(this option doesn't allow to use the '--cached' option or to provide an
>>>  	explicit commit).
>>> ++
>>> +Using the '--submodule=log' option with linkgit:git-diff[1] will provide the
>>> +same information.
>>
>> I am not a huge fan of these extra paragraphs, especially in reality it is
>> not "provide the same" but "the same and a lot of other".
>>
>> I dunno.
> 
> I added them because in a discussion with Marc it became apparent that users
> can't learn about what diff and status can do for them by checking the submodule
> man-page. But you are right about "the same and a lot of other", I will update
> the wording of those paragraphs.
> 
> Maybe someone else has a better idea how to inform users that git diff and
> status can tell you a lot (and sometimes even more than the submodule script)
> about the state submodules are in?

I thought the brief sentence in the patch was fine, myself.

		M.
