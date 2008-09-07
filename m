From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's in git.git (Sep 2008, #01; Sat, 06)
Date: Sun, 07 Sep 2008 12:03:06 -0700
Message-ID: <7vd4jfn5hx.fsf@gitster.siamese.dyndns.org>
References: <7vtzcso58c.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.10.0809070812350.6003@suse104.zenez.com>
 <7v3akbopzb.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.10.0809071139060.6003@suse104.zenez.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Boyd Lynn Gerber <gerberb@zenez.com>
X-From: git-owner@vger.kernel.org Sun Sep 07 21:04:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcPYr-0000vc-15
	for gcvg-git-2@gmane.org; Sun, 07 Sep 2008 21:04:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755084AbYIGTDN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 15:03:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755049AbYIGTDN
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 15:03:13 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41847 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754995AbYIGTDM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 15:03:12 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id D1A5B78E6E;
	Sun,  7 Sep 2008 15:03:11 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 1DDA378E6D; Sun,  7 Sep 2008 15:03:08 -0400 (EDT)
In-Reply-To: <alpine.LNX.1.10.0809071139060.6003@suse104.zenez.com> (Boyd
 Lynn Gerber's message of "Sun, 7 Sep 2008 11:45:20 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9DECA1F4-7D0F-11DD-8CAD-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95162>

Boyd Lynn Gerber <gerberb@zenez.com> writes:

> On Sun, 7 Sep 2008, Junio C Hamano wrote:
>> Boyd Lynn Gerber <gerberb@zenez.com> writes:
>>> On Sat, 6 Sep 2008, Junio C Hamano wrote:
>>>> Quite a many minor fixes appeared on 'maint'.  1.6.0.2 needs to happen
>>>> soon.  Any favorite fixes (not feature enhancements) not on the list here?
>>>
>>> I would really like to see this graduate to master before 1.6.0.2
>>>
>>> * jc/setlinebuf-setvbuf (Wed Sep 3 20:33:29 2008 -0700) 1 commit
>>>  + daemon.c: avoid setlinebuf()
>>
>> I do not think the setlinebuf() change affected 'maint' to begin with; it
>> was part of the series to clean-up daemon and to make maximum simultanous
>> number of connections configurable.  Are you having trouble building and/
>> or running 1.6.0.1 on your box?
>
> No, it does not work.  I have the git-shell problems,...

Then it does not have anything to do with the setlinebuf-setvbuf topic at
all, does it?

I think we already have 6ffaecc (shell: do not play duplicated definition
games to shrink the executable, 2008-08-19), which was cherry-picked from
4cfc24a (shell: do not play duplicated definition games to shrink the
executable, 2008-08-19) on 'master'.  Do you still have problem building
'maint' on your boxes?
