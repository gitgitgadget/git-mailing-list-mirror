From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Fwd: [Survey] Signed push
Date: Wed, 14 Sep 2011 11:36:39 -0700
Message-ID: <CA+55aFyUxmPWdG1j-0t9h9g9=1MmLt7w8fdmz+dZjS=1aDgWiA@mail.gmail.com>
References: <7vaaa8xufi.fsf@alter.siamese.dyndns.org> <CA+55aFxAQTR3sT7gekAD4qih8J+z-qwri7ZmNCPUd811xgci6w@mail.gmail.com>
 <CA+55aFy0b+eozmzbKD4RXcJ7e3WCpf7BV1n1qXHOeEwSHZKOXw@mail.gmail.com>
 <4E7085E6.3060509@alum.mit.edu> <CA+55aFw08zEeWovDPRGCM2f-xCuamJogFzigka4=mfcpJbZpsA@mail.gmail.com>
 <7vk49bui4f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 14 20:37:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3uKa-0000r8-GD
	for gcvg-git-2@lo.gmane.org; Wed, 14 Sep 2011 20:37:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757305Ab1INShB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Sep 2011 14:37:01 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:62445 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755834Ab1INShA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2011 14:37:00 -0400
Received: by wwf22 with SMTP id 22so2594522wwf.1
        for <git@vger.kernel.org>; Wed, 14 Sep 2011 11:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=6sPnY/Q7cBk44lytX2RGHW4pAfbmf+6cF7h/c04m5vU=;
        b=Ek+7EC5Mjh1Qnf358pzVOqvjWLq+yBpRmb9P3wn11khQMhiA9zACH8s2+4d0+OWuZn
         FzkjgLbNO/j35bfZxu2fhKm/mqx9S6MDt6NI7LrmW7QcgqTTJU3Uazu2e/2tWbpqSp9N
         eexloYLsRrIRvebiWsnhTCBZRqxs/tOVIJSEM=
Received: by 10.216.171.72 with SMTP id q50mr152268wel.76.1316025419109; Wed,
 14 Sep 2011 11:36:59 -0700 (PDT)
Received: by 10.216.174.8 with HTTP; Wed, 14 Sep 2011 11:36:39 -0700 (PDT)
In-Reply-To: <7vk49bui4f.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: VLsVBKgTEv842XAFWAcQfMsRm-c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181377>

On Wed, Sep 14, 2011 at 10:52 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
>> Now people do "git merge" in scripts etc, so we can't fix it ;-(
>
> Yes you can, by teaching "git merge -e" to open an editor ;-).
>
> In the meantime, "commit --amend" is your friend.

The problem with both of those are human: because it's extra work,
it's not going to get done.

In contrast, if it's extra work to *avoid* editing the merge message,
people probably would see the editor pop up, and start adding a few
small notes.

That's why "default behavior" matters so much. It's not that it's not
*possible* to edit a merge message, it's that nobody ever does!

                        Linus
