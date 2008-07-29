From: "Anders Melchiorsen" <mail@cup.kalibalik.dk>
Subject: Re: [PATCH v2] Advertise the ability to abort a commit
Date: Tue, 29 Jul 2008 23:19:07 +0200 (CEST)
Message-ID: <38467.N1gUGH5fRhE=.1217366347.squirrel@webmail.hotelhot.dk>
References: <1217359925-30130-1-git-send-email-mail@cup.kalibalik.dk>
    <1217362342-30370-1-git-send-email-mail@cup.kalibalik.dk>
    <7vfxpsct3f.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 29 23:20:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNwc8-0005FL-5B
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 23:20:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753162AbYG2VTM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 17:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752721AbYG2VTK
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 17:19:10 -0400
Received: from mail.hotelhot.dk ([77.75.163.100]:47649 "EHLO mail.hotelhot.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753281AbYG2VTK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 17:19:10 -0400
Received: from mail.hotelhot.dk (localhost [127.0.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id 564EA14062;
	Tue, 29 Jul 2008 23:19:07 +0200 (CEST)
Received: from webmail.hotelhot.dk (mail.hotelhot.dk [192.168.0.190])
	by mail.hotelhot.dk (Postfix) with ESMTP id 37FCB1405A;
	Tue, 29 Jul 2008 23:19:07 +0200 (CEST)
X-Squirrel-UserHash: NQYRRTwcNktTVUlTWFZaWRRVWg==
X-Squirrel-FromHash: N1gUGH5fRhE=
In-Reply-To: <7vfxpsct3f.fsf@gitster.siamese.dyndns.org>
User-Agent: SquirrelMail/1.4.13
X-Priority: 3 (Normal)
Importance: Normal
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90686>

Junio C Hamano wrote:
> Anders Melchiorsen <mail@cup.kalibalik.dk> writes:
>
>> -		die("no commit message?  aborting commit.");
>> +		die("no commit message.  aborting commit.");

> [...]

> If the change _were_ to reword the message to more neutral sounding
> "aborting commit due to missing log message.", and change die() to a
> normal exit, that would be making this not an error.  As I already said, I
> am mildly negative, but at least such a change would be internally
> consistent.
>
> I sense that the change from question mark to full stop might be showing
> the desire to go in that direction, but in that case your change from the
> question mark to full stop does not go far enough.

I took the question mark to mean that Git was confused about an empty
message. That does not seem right when Git itself proposes it.

I would be happy to also change it to a normal exit. However, since you do
not like the change, let us just forget about that hunk.


Cheers,
Anders.
