From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [bug] pull faulty 'not uptodate'
Date: Wed, 20 Aug 2008 14:50:40 -0700
Message-ID: <7vwsibnyof.fsf@gitster.siamese.dyndns.org>
References: <1508D1DF-EDE7-4A64-B354-E2F26578E24D@ai.rug.nl>
 <7v7iabpejv.fsf@gitster.siamese.dyndns.org>
 <EAFC48F0-5512-4A83-B9B2-44FF53319285@ai.rug.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailinglist <git@vger.kernel.org>
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Wed Aug 20 23:51:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVvar-0005E2-H7
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 23:51:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752189AbYHTVur (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 17:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751906AbYHTVur
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 17:50:47 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45927 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751870AbYHTVur (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 17:50:47 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 102DE61BD9;
	Wed, 20 Aug 2008 17:50:45 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 4278161BD8; Wed, 20 Aug 2008 17:50:42 -0400 (EDT)
In-Reply-To: <EAFC48F0-5512-4A83-B9B2-44FF53319285@ai.rug.nl> (Pieter de
 Bie's message of "Wed, 20 Aug 2008 23:29:35 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0AAAB478-6F02-11DD-8E6C-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93059>

Pieter de Bie <pdebie@ai.rug.nl> writes:

> On Aug 20, 2008, at 11:22 PM, Junio C Hamano wrote:
>> But I also have to wonder why a git-list regular like you are
>> reporting
>> this _long after_ v1.6.0-rc1 was released.  Perhaps this is not
>> really a
>> big-deal bug spelled in capital letters like you have on your Subject
>> line?
>
> I just noticed it and wanted to report it. I thought the usual way to
> do this is to put [BUG] in the subject line. If that is not the common
> way to report bugs, I'm sorry. I can also downcase it ;)

Nah, don't bother --- that wouldn't help.  A bug is a bug is a bug.

Checking if it is a regression ("it used to work but recently broken") or
a bug ("it does not work as I expect it") and marking the report as such
would have helped, though.
