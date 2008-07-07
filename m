From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [FIXED PATCH] Make rebase save ORIG_HEAD if changing current
 branch
Date: Sun, 06 Jul 2008 22:46:30 -0700
Message-ID: <7vskum8cw9.fsf@gitster.siamese.dyndns.org>
References: <1215379370-34265-1-git-send-email-benji@silverinsanity.com>
 <7v7iby9ucx.fsf@gitster.siamese.dyndns.org>
 <20080707054105.GB9737@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Gernhardt <benji@silverinsanity.com>,
	Git List <git@vger.kernel.org>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Mon Jul 07 07:49:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFjbC-0000sX-SP
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 07:49:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230AbYGGFqm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 01:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbYGGFqm
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 01:46:42 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41249 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751198AbYGGFql (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 01:46:41 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 66918103BA;
	Mon,  7 Jul 2008 01:46:39 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id AE1E9103B9; Mon,  7 Jul 2008 01:46:34 -0400 (EDT)
In-Reply-To: <20080707054105.GB9737@glandium.org> (Mike Hommey's message of
 "Mon, 7 Jul 2008 07:41:05 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 11CC3CB4-4BE8-11DD-97FC-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87580>

Mike Hommey <mh@glandium.org> writes:

> On Sun, Jul 06, 2008 at 09:43:58PM -0700, Junio C Hamano wrote:
> ...
>> We would make it _appear_ rebase and merge are interchangeable even more.
>> But the thing is, I am not convinced if promoting that appearance is
>> necessarily a good thing.
>> 
>> You now do not have to say something like:
>> 
>> 	After a 'git pull' you can view 'git diff ORIG_HEAD..' to check
>> 	what are new, but 'git pull --rebase' is different and you would
>> 	say 'git diff branch@{1}.." instead.
>> 
>> and you can tell the users that ORIG_HEAD can be used in both cases.
>
> And in both cases, you could use HEAD@{1} instead of ORIG_HEAD.

No you cannot.  Read what I wrote again.  I never said HEAD@{1} ;-)
