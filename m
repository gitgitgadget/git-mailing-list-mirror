From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/8] bash completion: more porcelain completions
Date: Tue, 05 Aug 2008 11:58:18 -0700
Message-ID: <7vbq07waph.fsf@gitster.siamese.dyndns.org>
References: <1217915438-6838-1-git-send-email-lee.marlow@gmail.com>
 <20080805142919.GA27295@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lee Marlow <lee.marlow@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Aug 05 20:59:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQRkq-0006Oi-O9
	for gcvg-git-2@gmane.org; Tue, 05 Aug 2008 20:59:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756891AbYHES63 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Aug 2008 14:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756900AbYHES63
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Aug 2008 14:58:29 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:46022 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755621AbYHES62 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Aug 2008 14:58:28 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 481154C491;
	Tue,  5 Aug 2008 14:58:26 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 305C54C484; Tue,  5 Aug 2008 14:58:21 -0400 (EDT)
In-Reply-To: <20080805142919.GA27295@spearce.org> (Shawn O. Pearce's message
 of "Tue, 5 Aug 2008 07:29:19 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7C155002-6320-11DD-8889-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91453>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Lee Marlow <lee.marlow@gmail.com> wrote:
>> This adds basic long option completion for some common commands that I
>> use, as well as stash name completion.
>
> Entire series is good.
>
> Acked-by: Shawn O. Pearce <spearce@spearce.org>

Have you looked at the last one [PATCH 8/8]?  I do not seem to have it.

>> Lee Marlow (8):
>>   bash completion: Add completion for 'git clone'
>>   bash completion: Add completion for 'git clean'
>>   bash completion: Add completion for 'git init'
>>   bash completion: Add completion for 'git revert'
>>   bash completion: More completions for 'git stash'
>>   bash completion: Add completion for 'git archive'
>>   bash completion: Add completion for 'git ls-files'
>>   bash completion: Add completion for 'git mv'
>> 
>>  contrib/completion/git-completion.bash |  143 +++++++++++++++++++++++++++++++-
>>  git-stash.sh                           |    2 +-
>>  2 files changed, 143 insertions(+), 2 deletions(-)
>> 
>
> -- 
> Shawn.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
