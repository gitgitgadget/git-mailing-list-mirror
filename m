From: layer <layer@known.net>
Subject: Re: git merge ignoring whitespace
Date: Thu, 05 Feb 2009 15:48:36 -0800
Message-ID: <3047.1233877716@relay.known.net>
References: <2754.1233876289@relay.known.net> <7vtz78a1pn.fsf@gitster.siamese.dyndns.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 06 00:50:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVDyv-0004Rt-Cn
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 00:50:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753568AbZBEXsi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 18:48:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752917AbZBEXsi
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 18:48:38 -0500
Received: from relay.known.net ([67.121.255.169]:52705 "HELO relay.known.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752353AbZBEXsh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 18:48:37 -0500
Received: from localhost (127.0.0.1) by relay.known.net
    (Allegro Maild v1.2.17) id 000000022730; Thu, 5 Feb 2009 15:48:36 -0800
In-reply-to: <7vtz78a1pn.fsf@gitster.siamese.dyndns.org>
Comments: In-reply-to Junio C Hamano <gitster@pobox.com>
   message dated "Thu, 05 Feb 2009 15:44:20 -0800."
X-Mailer: MH-E 8.1; nmh 1.3; GNU Emacs 22.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108635>

Junio C Hamano <gitster@pobox.com> wrote:

>> layer <layer@known.net> writes:
>> 
>> > Junio, on 3/25/07 you said:
>> >
>> >   I know Linus does not like applying patches with whitespace
>> >   fuzziness, but I personally think a merge that ignores
>> >   whitespace changes would be a useful thing to have, without
>> >   having to call an external specialized merge backend. In other
>> >   words, I do not think it is so special a thing to want to, but
>> >   it is rather an unfortunate norm.  I am not opposed to give
>> >   git-merge-recursive a command line option to tell it to merge
>> >   ignoring the whitespace-only changes, when it does the 3-way
>> >   file-level merge internally.
>> >
>> > Whatever came of this?
>> 
>> I do not know.  When I say "I am not opposed to", I mean just that. 
>> 
>> I may consider it a bad mode of operation, and I may hesitate to encourage
>> people to use it as their default.  But I do not feel strongly enough to
>> veto it---as long as it is a rope you need to explicitly ask for to hang
>> yourself with, I think it is Ok if we allowed such an option.
>> 
>> It is not my itch to scratch, and I do not keep track.

Thanks for the summary.

>> Did you submit a patch that implements the new feature cleanly?

Nope.  I'm just barely emerging from newbie status, so I'm probably a
ways away from implementing it.

Kevin
