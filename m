From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Problem with merge when renaming
Date: Tue, 18 Sep 2007 16:27:01 -0700
Message-ID: <7vejgvtv0a.fsf@gitster.siamese.dyndns.org>
References: <95b3d0af0709181334y1e21507ey485860e4d45aa26f@mail.gmail.com>
	<7v7imnvca0.fsf@gitster.siamese.dyndns.org>
	<20070918224447.GC14488@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Euresti <evelio@gmail.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 19 01:27:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXmTK-0001lA-BX
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 01:27:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753978AbXIRX1J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 19:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753486AbXIRX1I
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 19:27:08 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:37850 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751439AbXIRX1H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 19:27:07 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 2D613137A87;
	Tue, 18 Sep 2007 19:27:25 -0400 (EDT)
In-Reply-To: <20070918224447.GC14488@steel.home> (Alex Riesen's message of
	"Wed, 19 Sep 2007 00:44:47 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58659>

Alex Riesen <raa.lkml@gmail.com> writes:

> Junio C Hamano, Wed, Sep 19, 2007 00:28:39 +0200:
>> "David Euresti" <evelio@gmail.com> writes:
>> 
>> > I think I found a problem when you move a file into a directory of the
>> > same name.  Here's what I did.
>> 
>> Two questions.
>> 
>>  (1) git --version?
>
> it happens with very recent git (as of today)
>
>>  (2) if you do "git merge -s resolve" instead of just "git
>>      merge", do you see a difference?
>
> yes: it has more error output.
>
> Trying really trivial in-index merge...
> warning: Merge requires file-level merging
> Nope, a really trivial in-index merge not possible
> Trying simple merge.
> Simple merge failed, trying Automatic merge.
> error: init: is a directory - add individual files instead
> fatal: Unable to process path init
> fatal: merge program failed
> Automatic merge failed; fix conflicts and then commit the result.

Isn't this the same as the known issue here?

	<http://permalink.gmane.org/gmane.comp.version-control.git/53402>
