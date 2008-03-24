From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/git-checkout: Update summary to reflect
 current abilities
Date: Mon, 24 Mar 2008 09:49:33 -0700
Message-ID: <7vbq54vzhe.fsf@gitster.siamese.dyndns.org>
References: <7vtziw3k9a.fsf@gitster.siamese.dyndns.org>
 <47E69044.3000207@zytor.com> <20080323173841.GA24943@mit.edu>
 <20080323182102.GA22551@bit.office.eurotux.com>
 <87r6e1b6c8.fsf@mid.deneb.enyo.de> <20080324001617.GB24943@mit.edu>
 <20080324014030.GA24695@atjola.homenet> <20080324021411.GE24943@mit.edu>
 <20080324030946.9328.76091.julian@quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Florian Weimer <fw@deneb.enyo.de>, git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Mon Mar 24 17:50:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdpsW-0005rL-N9
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 17:50:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753787AbYCXQtv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 12:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752873AbYCXQtv
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 12:49:51 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60960 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752687AbYCXQtu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2008 12:49:50 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 75F3C1234;
	Mon, 24 Mar 2008 12:49:48 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 9B3F91231; Mon, 24 Mar 2008 12:49:43 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78061>

Julian Phillips <julian@quantumfyre.co.uk> writes:

>> Theodore Tso <tytso@MIT.EDU> writes:
>>
>>>        git-checkout - Checkout and switch to a branch
>>>
>>> At the very least, will you admit that the summary in the man page is
>>> perhaps just a wee bit misleading?
>>
>> It's not "wee bit misleading" but it just is outright stale.
>>
>> Back then, before people realized the operation "to check out the path out
>> of index or tree-ish" belongs naturally to a command whose name is
>> "checkout", "to check out the named branch or a commit" was the only thing
>> that you could do with the command.  The one-line description you quoted
>> above reflects that history.
>>
>> Patches very much welcome; I did not notice it was kept stale.
>
> Something like this perhaps?
>
>  Documentation/git-checkout.txt |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
> index 4014e72..1b8caf1 100644
> --- a/Documentation/git-checkout.txt
> +++ b/Documentation/git-checkout.txt
> @@ -3,7 +3,7 @@ git-checkout(1)
>  
>  NAME
>  ----
> -git-checkout - Checkout and switch to a branch
> +git-checkout - Checkout/update/refresh items in the working tree

Hmm.

The glossary may be a good place to define what the verb "checkout" means.
I think using that defined word without adding "/update/refresh" to
muddy its meaning would be more appropriate, after we establish what
"checkout" means in the glossary.

So how about saying "Check out a whole branch, or paths to the work tree"
or something like that?
