From: layer <layer@known.net>
Subject: Re: list of files that have been added/removed
Date: Wed, 15 Apr 2009 14:57:59 -0700
Message-ID: <31319.1239832679@relay.known.net>
References: <31043.1239831470@relay.known.net> <7vvdp5r3s5.fsf@gitster.siamese.dyndns.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 15 23:59:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuD8o-0005Yj-Py
	for gcvg-git-2@gmane.org; Wed, 15 Apr 2009 23:59:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755768AbZDOV6A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2009 17:58:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754498AbZDOV6A
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Apr 2009 17:58:00 -0400
Received: from relay.known.net ([67.121.255.169]:50316 "HELO relay.known.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753508AbZDOV6A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2009 17:58:00 -0400
Received: from localhost (127.0.0.1) by relay.known.net
    (Allegro Maild v1.2.17) id 000000035341; Wed, 15 Apr 2009 14:57:59 -0700
In-reply-to: <7vvdp5r3s5.fsf@gitster.siamese.dyndns.org>
Comments: In-reply-to Junio C Hamano <gitster@pobox.com>
   message dated "Wed, 15 Apr 2009 14:43:54 -0700."
X-Mailer: MH-E 8.1; nmh 1.3; GNU Emacs 22.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116654>

Junio C Hamano <gitster@pobox.com> wrote:

>> layer <layer@known.net> writes:
>> 
>> >   I see the changes in the index with "git status" as "deleted" or
>> >   "added".  
>> >
>> > I meant "new file" here.  Of course I can process the output of "git
>> > status", but I was looking for a cleaner method, if there is one.
>> 
>> "Process" as in "Read in a script and have it act on the
>> information"?

Yes.  Junio, your answer was perfect.  Thanks.

>> 
>> git diff-index --name-status HEAD
>> 
>> would be one Kosher way for the scripts, and if your scripting language
>> can handle NUL terminated string, giving -z option would make your script
>> more robust against funny pathnames.
>> 
>> git diff-index --name-only --diff-filter=A HEAD
>> 
>> if you only care about "new file" and nothing else.
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
