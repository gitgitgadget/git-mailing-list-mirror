From: Michael Witten <mfwitten@gmail.com>
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Thu, 18 Mar 2010 14:32:38 -0500
Message-ID: <b4087cc51003181232q6b8ec056lad79c62926b65a10@mail.gmail.com>
References: <4ba2293f.c5c2f10a.5e9c.5c4a@mx.google.com> <alpine.LFD.2.00.1003181022040.18017@i5.linux-foundation.org> 
	<9e4733911003181202h23b3d702xce8fc0670a994d52@mail.gmail.com> 
	<alpine.LFD.2.00.1003181203370.18017@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jon Smirl <jonsmirl@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Mar 18 20:33:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsLSu-0002N9-IB
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 20:33:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751995Ab0CRTdD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Mar 2010 15:33:03 -0400
Received: from mail-fx0-f219.google.com ([209.85.220.219]:65325 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751351Ab0CRTdB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Mar 2010 15:33:01 -0400
Received: by fxm19 with SMTP id 19so2466463fxm.21
        for <git@vger.kernel.org>; Thu, 18 Mar 2010 12:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=fRobwhZWDHKFPwEEl42fhM3/KvgUUb0bkz4Wa7H9+HQ=;
        b=x5RHXgXeBOtsTCwT1LPaBMNFVh3Wk6zI56DvbxuWIBUUYFWcNC0djKgZx9fnUtx+Yk
         JUVZDq6WqC3300ThkF97zx5oIqjfrNmtXpCJORvEe0jxqFVr6D3XwNEzerytgYXB1rw2
         7ElBUnIPfOQ1Zjp2YtY/ypn7pvaOdrEhKEaUY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=ny1T3xWSKNFuJPyW3CJcRWz23RxHSogUhbrWr52mB0EoF5F7QZE9bk70o5PILINFrm
         jAJ4N/s0A27yRMf3vazfb1iokf3pqsOGwKDY6NX6fVrkwYA2FWj2GOf6GYBYTPMyG6AV
         EuqIo8wxveluF0nd1zWtsUuaIlvfRsLjg3dyQ=
Received: by 10.239.188.146 with SMTP id p18mr1497094hbh.208.1268940778312; 
	Thu, 18 Mar 2010 12:32:58 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1003181203370.18017@i5.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142501>

On Thu, Mar 18, 2010 at 14:07, Linus Torvalds
<torvalds@linux-foundation.org> wrote:

> And if it doesn't have meaning, then it's just
> annoying and will never ever be attached to
> anything relevant long-term.

You've actually just described the current name/email system.

What a uuid provides is that very property of long-term attachment; a
git user can change the name/email pair but keep the same uuid.

You see, the problem is that the name/email pair isn't really an
identifier; it's actually just info about the user's current email
account, which is very useful for everyday workflow, but pretty naive
for historical identification over long periods of time.

As previously discussed in my original email, the 'email' portion of
the name/email pair is the most volatile portion, and that's because
it's only tangentially related to identity (and it certainly has
nothing to do with long-term identity).

>There is absolutely _no_ way that teh uuid would
> ever actually encode any real meaningful
> information that isn't better represented by the
> name/email.

It IS a name/email pair (if you want or if that is enforced); it's
just one that isn't as volatile.

This notion of a uuid is an attempt to adopt a BETTER MODEL for
identity: The user get's to choose a piece of information that he
himself deems a longterm identifier; it's not about what address you
currently use for email, it's solely about who you are over a long
period of time.
