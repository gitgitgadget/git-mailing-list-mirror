From: "Denis Bueno" <dbueno@gmail.com>
Subject: Re: Recovering from repository corruption
Date: Tue, 10 Jun 2008 16:28:43 -0400
Message-ID: <6dbd4d000806101328k1fc913f2ia55c3e44273ec5ad@mail.gmail.com>
References: <6dbd4d000806101026m458513ecqa8141f509bad7602@mail.gmail.com>
	 <m3abhtp42o.fsf@localhost.localdomain>
	 <6dbd4d000806101238v2bb975abqd39916e45d4bf866@mail.gmail.com>
	 <200806102159.02875.jnareb@gmail.com>
	 <6dbd4d000806101303j4b2032ajc6e004e0a82e4db5@mail.gmail.com>
	 <alpine.LFD.1.10.0806101317100.3101@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jun 10 22:30:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6ATY-0001qZ-UN
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 22:29:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751995AbYFJU26 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 16:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751869AbYFJU26
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 16:28:58 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:21925 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751839AbYFJU26 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2008 16:28:58 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1904773fgg.17
        for <git@vger.kernel.org>; Tue, 10 Jun 2008 13:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=7mKAt3LUMxpU+yW01BI9h8FQscFD8p+DXAc5tNbjLSs=;
        b=b+vMPCiwOHiQj6IUmJmn8eQvXjJwU4TDHzMKpxGAmTr0BN3TIOQ8JJBI8s0O2N2avt
         gXaONGVniPm6mFJNtyu9o2+TQ7ZD/wSAhUA/dx/hHYurL4I5BTO1lnzKs0AuniQfUiLj
         XIVzgq+rB8RczSFKb1Xr5cNx3+VZpmytS6Yjk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=IMgLvCCmsnBHw0tFMrVLJOBFyZVyl8nNdSCy6K7Qdh+6n6OMSD4bvvTff9q4lhQsdx
         ExcHA2fmRDI5GBkstZLkLKiNc2L9XveY/vORd3GgckSS4oT402qH8u2MD+CE2+YtIk7H
         57aNRLIfEhLg+Co9kdxBTnOQFTZAOWiiRMiUw=
Received: by 10.86.63.19 with SMTP id l19mr6205149fga.60.1213129723683;
        Tue, 10 Jun 2008 13:28:43 -0700 (PDT)
Received: by 10.86.59.7 with HTTP; Tue, 10 Jun 2008 13:28:43 -0700 (PDT)
In-Reply-To: <alpine.LFD.1.10.0806101317100.3101@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84545>

On Tue, Jun 10, 2008 at 16:23, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>
> On Tue, 10 Jun 2008, Denis Bueno wrote:
>>
>> You're onto something:
>>
>> [dorothy.local /tmp <Tue Jun 10> <16:02:08>]
>> tmp[176] > git clone file:///Volumes/work/identity.fb/
>
> [ successful ]
>
> Hmm. Scary. That should *not* have been successful with a corrupt repo.
>
> Unless you have done a .grafts file to hide the corruption, or something
> like that?

I intended to do that, yes, and I think I was successful.  (I only say
I "intended to" --- instead of "I did" --- because I read the
documentation for the grafts file elsewhere on this list, and not in
some more "blessed" location.)

> Have you saved away the original corrupt repo (the whole .git directory as
> a tar-ball, for example)? And is the data public and non-embarrassing
> enough so that you could make it available for some post-corruption
> analysis? Even if we cannot help recover it, real-life corruption is
> always interesting to see if only as a test-case to make sure that git
> notices it as quickly as possible.

I do have bunches of personal information in the repo, unfortunately.
The particular *file* involved in the corruption, however, is fine for
all to view.  Is that useful?


-- 
                              Denis
