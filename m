From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] Documentation/submodule: add command references and update
 options
Date: Tue, 26 Jul 2011 20:44:07 +0200
Message-ID: <4E2F0AF7.2070306@web.de>
References: <4E2B1A54.2000605@web.de> <7vmxg2qf0j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Nikolai Weibull <now@bitwi.se>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 26 20:44:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qlmc4-00089n-Gw
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jul 2011 20:44:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753078Ab1GZSoM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jul 2011 14:44:12 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:42448 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751753Ab1GZSoJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2011 14:44:09 -0400
Received: from smtp04.web.de  ( [172.20.0.225])
	by fmmailgate03.web.de (Postfix) with ESMTP id C21D41961FF84;
	Tue, 26 Jul 2011 20:44:07 +0200 (CEST)
Received: from [93.246.50.77] (helo=[192.168.178.43])
	by smtp04.web.de with asmtp (WEB.DE 4.110 #2)
	id 1Qlmbv-0007hc-00; Tue, 26 Jul 2011 20:44:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:5.0) Gecko/20110624 Thunderbird/5.0
In-Reply-To: <7vmxg2qf0j.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19NUjO5jIqOLGn6ias+PwibR/SOw2ssezlT4UgR
	/yhO0NtYj/zwIYyx7C9YK4413J4ByATCaZpqWHBqvLO5qejgxk
	BkuDIlS0NG+WNtHEAOUg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177894>

Am 25.07.2011 22:30, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
>> @@ -131,7 +137,7 @@ update::
>>  +
>>  If the submodule is not yet initialized, and you just want to use the
>>  setting as stored in .gitmodules, you can automatically initialize the
>> -submodule with the --init option.
>> +submodule with the '--init' option.
> 
> Don't we want to use
> 
> 	the `--init` option
> 
> instead for consistency? After all, that is what the users actually type.
> 
> 	$ git grep -e "\`--[a-z]" Documentation/ | wc -l
>         287
>         $ git grep -e "'--[a-z]" Documentation/ | wc -l
>         132

Fine by me, I just followed the style I found there. Will change all
option names (including those who are using '--init' right now) to
`--init` in the next iteration.

>> @@ -140,11 +146,14 @@ summary::
>>  	Show commit summary between the given commit (defaults to HEAD) and
>>  	working tree/index. For a submodule in question, a series of commits
>>  	in the submodule between the given super project commit and the
>> -	index or working tree (switched by --cached) are shown. If the option
>> -	--files is given, show the series of commits in the submodule between
>> +	index or working tree (switched by '--cached') are shown. If the option
>> +	'--files' is given, show the series of commits in the submodule between
>>  	the index of the super project and the working tree of the submodule
>> -	(this option doesn't allow to use the --cached option or to provide an
>> +	(this option doesn't allow to use the '--cached' option or to provide an
>>  	explicit commit).
>> ++
>> +Using the '--submodule=log' option with linkgit:git-diff[1] will provide the
>> +same information.
> 
> I am not a huge fan of these extra paragraphs, especially in reality it is
> not "provide the same" but "the same and a lot of other".
>
> I dunno.

I added them because in a discussion with Marc it became apparent that users
can't learn about what diff and status can do for them by checking the submodule
man-page. But you are right about "the same and a lot of other", I will update
the wording of those paragraphs.

Maybe someone else has a better idea how to inform users that git diff and
status can tell you a lot (and sometimes even more than the submodule script)
about the state submodules are in?
