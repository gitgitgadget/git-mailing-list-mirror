From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Monotone workflow compared to Git workflow ( was RE: Git vs Monotone)
Date: Fri, 1 Aug 2008 09:43:48 +1200
Message-ID: <46a038f90807311443q2bbf7782kbbf339ab77376dc7@mail.gmail.com>
References: <bd6139dc0807311113n50dda9f0t1aab46b724510de2@mail.gmail.com>
	 <alpine.LFD.1.10.0807311211260.3277@nehalem.linux-foundation.org>
	 <63BEA5E623E09F4D92233FB12A9F79430238A5EE@emailmn.mqsoftware.com>
	 <alpine.LFD.1.10.0807311253140.3277@nehalem.linux-foundation.org>
	 <20080731205400.GA7911@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Craig L. Ching" <cching@mqsoftware.com>, sverre@rabbelier.nl,
	"Git Mailinglist" <git@vger.kernel.org>
To: "=?ISO-8859-1?Q?Bj=F6rn_Steinbrink?=" <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 31 23:44:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOfx8-0001ME-Fz
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 23:44:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754253AbYGaVnw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Jul 2008 17:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754491AbYGaVnv
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 17:43:51 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:47770 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753569AbYGaVnu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Jul 2008 17:43:50 -0400
Received: by py-out-1112.google.com with SMTP id p76so436548pyb.10
        for <git@vger.kernel.org>; Thu, 31 Jul 2008 14:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=uWqWWM50Tc5XbYVlk+7n3xx21J9Szba4GSSVxWlt2gs=;
        b=Mb6L4HelaiXrnu7u4G4yvfNkNN4A7xplmouUGzPbC0BOAGMmVCs7jcN/aYRQok1DC5
         U+7RmpISUg0/3zWshNeVrR0vO4fnTz8Y86BrcAAldbEP3QbVUwz0Jqus32DBLLn/x6CX
         facIcBaQRzG2bZydtwwIWobR89zAGbGrIaKEo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=g/sSddqyPctZnkUvnpBcajwcuJJRWe1wRQ9vfidXevkmp9dKrOsAPbj7Hueg4kdvqG
         y+YqeKHf8jr2oQcjGAkm9JlyiAVVdtGw8N+xgxVpyMckIq1e4NHk2WC+vr8/HCGMJPH6
         INbJulhiOjfeuOeW2mVYyDu5cxvRPbWsVWVjw=
Received: by 10.142.163.13 with SMTP id l13mr3459589wfe.34.1217540628575;
        Thu, 31 Jul 2008 14:43:48 -0700 (PDT)
Received: by 10.142.43.6 with HTTP; Thu, 31 Jul 2008 14:43:48 -0700 (PDT)
In-Reply-To: <20080731205400.GA7911@atjola.homenet>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90998>

On Fri, Aug 1, 2008 at 8:54 AM, Bj=F6rn Steinbrink <B.Steinbrink@gmx.de=
> wrote:
>> So literally, if you do
>>
>>       git clone <cntral-repo-over-network> <local>
>
> Hum, I guess I'm just missing something and prepare to get flamed, bu=
t
> wouldn't you want that one to be bare? Otherwise, the other clones wo=
n't
> see all of the original repo's branches, right?

Yes, that's why

   git clone --reference /path/to/fat/checkout/.git/  <central-repo>

is far better. Each "thin" checkout sees the central repo normally,
but they borrow the object store from the referenced local "fat"
checkout.

cheers,


m
--=20
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
