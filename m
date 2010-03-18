From: Michael Witten <mfwitten@gmail.com>
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Thu, 18 Mar 2010 13:57:38 -0500
Message-ID: <b4087cc51003181157i7c8b46favb52d4ccda75be799@mail.gmail.com>
References: <alpine.LFD.2.00.1003181022040.18017@i5.linux-foundation.org> 
	<4ba2293f.c5c2f10a.5e9c.5c4a@mx.google.com> <4ba27424.9804cc0a.4b1f.11b1@mx.google.com> 
	<vpq8w9po4az.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Mar 18 19:58:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsKv1-0006fs-U2
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 19:58:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424Ab0CRS6A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Mar 2010 14:58:00 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:35402 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076Ab0CRS6A (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Mar 2010 14:58:00 -0400
Received: by fg-out-1718.google.com with SMTP id l26so166486fgb.1
        for <git@vger.kernel.org>; Thu, 18 Mar 2010 11:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=kKMs4GPc4hslvHzDd3vrjDb+rmM7GsEIJBHdr2OsDf8=;
        b=dZ7/sgXkRVhJoZKHvLTWY6ydl1xG+cfyv1pmN7jP4t1vkc8Io7Nb7hUyRhFHeSNW/D
         9YCpQZwQwAdnhmQkD01ezd8AS74601P3mzLhigacOXMu6i3heX32U6e9zyeXXsMDMXcg
         SARCmVZkQtYL5cRpnW5e6h3v3GW+ausn5OQGQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=ZClEZxyzk19L7HFEtoqOK2/ITartO2KUNLWHHzKAmAiV4PfdgMhDMsLApEPit5vfWO
         01JcYbWTI+df3oisLkZBXzA72E6GTFZOAV0Fr1zti2ePCqd1zX1W8MPpgsX6iwNnyAJk
         RpWhC24ZzBkOtjb5jHd0MxyiFPAUMwR/mwfds=
Received: by 10.239.185.132 with SMTP id c4mr1466400hbh.141.1268938678183; 
	Thu, 18 Mar 2010 11:57:58 -0700 (PDT)
In-Reply-To: <vpq8w9po4az.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142490>

On Thu, Mar 18, 2010 at 13:47, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> What's the added value of the "SHA-1" thing, here? A hash of a pair
> (a, b) is exactly as unique as the pair itself (well, actually even a
> bit less if you consider collisions).

Your observation is correct, but I'm pushing for the SHA-1 string
because it could be efficiently parsed, stored, and used; it's
essentially an optimization (or a preparation for an optimization).

If that's not a good way to approach it, then I'd be satisifed with
just a straight (name,email) pair or any other reasonably unique
string.

On a more general note, the idea of a uuid is to distribute the
process of canonicalizing identities. Does that not make perfect
sense?
