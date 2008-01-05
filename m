From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git stash: one bug and one feature request
Date: Fri, 04 Jan 2008 22:52:06 -0800
Message-ID: <7vzlvkepd5.fsf@gitster.siamese.dyndns.org>
References: <e5bfff550801040814n82f34b2g17c485a207093440@mail.gmail.com>
	<20080105064156.GA6954@blorf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marco Costalba <mcostalba@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Wayne Davison <wayne@opencoder.net>
X-From: git-owner@vger.kernel.org Sat Jan 05 07:52:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JB2tf-0008Qi-9Q
	for gcvg-git-2@gmane.org; Sat, 05 Jan 2008 07:52:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752530AbYAEGwQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2008 01:52:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752523AbYAEGwQ
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jan 2008 01:52:16 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45979 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752457AbYAEGwP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2008 01:52:15 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A5A96C82;
	Sat,  5 Jan 2008 01:52:14 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D70976C81;
	Sat,  5 Jan 2008 01:52:09 -0500 (EST)
In-Reply-To: <20080105064156.GA6954@blorf.net> (Wayne Davison's message of
	"Fri, 4 Jan 2008 22:41:56 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69645>

Wayne Davison <wayne@opencoder.net> writes:

> On Fri, Jan 04, 2008 at 05:14:42PM +0100, Marco Costalba wrote:
>> -		echo >&2 'No local changes to save'
>> +		echo > 'No local changes to save'
>
> That change and the other two following it each put a newline in a
> strangely named file.  You should just drop the >&2 altogether if you
> want the output to go to stdout.

Lol...  Good eyes.  I did not even notice it ;-).

Thanks.
