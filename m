From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH resend] bash completion: add 'rename' subcommand to
 git-remote
Date: Sat, 17 Jan 2009 00:03:22 -0800
Message-ID: <7vd4em8ilx.fsf@gitster.siamese.dyndns.org>
References: <200901162254.58300.markus.heidelberg@web.de>
 <20090116221203.GP10179@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Markus Heidelberg <markus.heidelberg@web.de>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Jan 17 09:05:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LO6As-0006d2-Pb
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 09:04:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754249AbZAQIDf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 03:03:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752652AbZAQIDf
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 03:03:35 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57975 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752579AbZAQIDe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 03:03:34 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id A86411CB25;
	Sat, 17 Jan 2009 03:03:30 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 8168A1CB23; Sat,
 17 Jan 2009 03:03:24 -0500 (EST)
In-Reply-To: <20090116221203.GP10179@spearce.org> (Shawn O. Pearce's message
 of "Fri, 16 Jan 2009 14:12:03 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 543BF562-E46D-11DD-A440-2E3B113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106033>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Markus Heidelberg <markus.heidelberg@web.de> wrote:
>> 
>> Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
>
> Acked-by: Shawn O. Pearce <spearce@spearce.org>
>
>> 	I've just accidently read in the completion file itself, that
>> 	Shawn is the maintainer, so I give it a third try. The first two
>> 	haven't been sent to him.
>
> Sorry, I must have missed the other two attempts.  :-)

And I seem to have missed all three.

>
>  
>>  contrib/completion/git-completion.bash |    4 ++--
>>  1 files changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
>> index 049ded0..6623344 100755
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -1384,7 +1384,7 @@ _git_config ()
>>  
>>  _git_remote ()
>>  {
>> -	local subcommands="add rm show prune update"
>> +	local subcommands="add rename rm show prune update"
>>  	local subcommand="$(__git_find_subcommand "$subcommands")"
>>  	if [ -z "$subcommand" ]; then
>>  		__gitcomp "$subcommands"
>> @@ -1392,7 +1392,7 @@ _git_remote ()
>>  	fi
>>  
>>  	case "$subcommand" in
>> -	rm|show|prune)
>> +	rename|rm|show|prune)
>>  		__gitcomp "$(__git_remotes)"
>>  		;;
>>  	update)
>> -- 
>> 1.6.1.35.g0c23
>> 
>
> -- 
> Shawn.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
