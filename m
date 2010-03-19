From: Michael Witten <mfwitten@gmail.com>
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Fri, 19 Mar 2010 05:39:04 -0600
Message-ID: <b4087cc51003190439x3c9ff269g35d11432bd2a3d60@mail.gmail.com>
References: <4ba2293f.c5c2f10a.5e9c.5c4a@mx.google.com> <4BA338C1.7030803@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Mar 19 12:39:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsaYA-0002oI-9m
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 12:39:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380Ab0CSLj2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Mar 2010 07:39:28 -0400
Received: from mail-fx0-f219.google.com ([209.85.220.219]:65350 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750992Ab0CSLj0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Mar 2010 07:39:26 -0400
Received: by fxm19 with SMTP id 19so498617fxm.21
        for <git@vger.kernel.org>; Fri, 19 Mar 2010 04:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=CXsU/xRt+tsX/6QaEMNiqPzQy1Cp3pDN4KZ5/csZLfA=;
        b=VUVmXxYDerHWHWUjB5kWZuBDP8pd3A0Y9cCk5g3sZJv07UVW+UWhNn/Hg92XwulqKK
         SvL0r6ZFCtNO+GKpuqNCNKqE30Z19tZNAHxz1+YUtMRwA7NdCD//05PdMRBdBKfGBZKV
         Dr9j3uPyzCt8xQwRvSvukZcLmuzHZgKBuhKYU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=vZ4PdNALCAQGVTDTql9D+0uefBchTThIb4rZCoGzMNOoeBtRhxXd/pMgpOIgx7UbGI
         ngTbLME9DiqaAKoa5ELFvZA+CtlaKvKOcU8c1dIOrzrAM/EFbfEw5XGEhLJRKQ7vX1D1
         ucezMvger9Wb8NmLiiRcBMfu4l7klSv5YzsXs=
Received: by 10.239.191.194 with SMTP id c2mr1567626hbi.169.1268998764157; 
	Fri, 19 Mar 2010 04:39:24 -0700 (PDT)
In-Reply-To: <4BA338C1.7030803@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142575>

On Fri, Mar 19, 2010 at 02:41, Michael Haggerty <mhagger@alum.mit.edu> =
wrote:
> Michael Witten wrote:
>> Rather than use a (name,email) pair to identify people, let's use
>> a (uuid,name,email) triplet.
>> [...]
>
> A UUID doesn't need to be a big hex number. =C2=A0All it has to be is=
 a
> "Universally Unique Identifier". =C2=A0Like, oh, for example, your
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *** EM=
AIL ADDRESS ***
>
> [1]. =C2=A0There is even already a way to fix up mistakes or unavoida=
ble
> email address changes, namely the .mailmap file.

*facepalm*

You've just repeated everything that I've said; go look at the rest of
the thread, where I spend plenty of time correcting the same hangups
about my choice of the word UUID and my use of hex digits.

I'm only observing that the current name/email system pair conflates
an individual with his current email system and that it would be
worthwhile to ALLOW an individual to FURTHER describe himself by
including another piece of information that is solely meant as
identification within git. That piece of information could be whatever
a user deems to be uniquely identifying for himself. You could use
"Michael Haggerty <mhagger@alum.mit.edu>" as your uuid, and you could
still use it after you change the `email' config variable to something
else.

There is MUCH LESS CHANCE of such a uuid getting trashed by typos,
changing names, and changing email addresses; of course it can still
get messed up, but the rate at which something like .mailmap would
need to be updated would likely be greatly decreased and it would make
gathering statistics easier (especially for the individuals who take
advantage of such a uuid for describing themselves---and it only
requires setting one config variable to something easily remembered by
that person).

I cover all of this numerous times in numerous rebuttals; don't
contribute to a thread with more than 60 emails without having read at
least some of them. If you don't care to read so much, then perhaps
jump here:

    http://marc.info/?l=3Dgit&m=3D126894679711600&w=3D2

In the end, there is probably only one legitimate problem with my
proposal: It might break compatibility with older repo formats/tools.
I'm not sure about that.

Sincerely,
Michael Witten
