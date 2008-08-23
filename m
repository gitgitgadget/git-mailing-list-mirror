From: "Felipe Contreras" <felipe.contreras@gmail.com>
Subject: Re: Git vs Monotone
Date: Sat, 23 Aug 2008 22:23:06 +0300
Message-ID: <94a0d4530808231223g5940b691r41072b1432e9c6ab@mail.gmail.com>
References: <bd6139dc0807311113n50dda9f0t1aab46b724510de2@mail.gmail.com>
	 <alpine.LFD.1.10.0807311211260.3277@nehalem.linux-foundation.org>
	 <63BEA5E623E09F4D92233FB12A9F79430238A5EC@emailmn.mqsoftware.com>
	 <alpine.LFD.1.10.0807311244240.3277@nehalem.linux-foundation.org>
	 <7vmyjxyf7a.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Craig L. Ching" <cching@mqsoftware.com>, sverre@rabbelier.nl,
	"Git Mailinglist" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 23 21:24:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWyib-0006Yx-1N
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 21:24:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753189AbYHWTXJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2008 15:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753150AbYHWTXI
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Aug 2008 15:23:08 -0400
Received: from rv-out-0506.google.com ([209.85.198.237]:54463 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753124AbYHWTXH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2008 15:23:07 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1004722rvb.1
        for <git@vger.kernel.org>; Sat, 23 Aug 2008 12:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=/1+I7p9N8yk6bbKGKK7XBPhLawzNQkcmRnAvwitmOBk=;
        b=IlDODU02ROVkRWHvS4P7gFn5r5k4XjR0tqMPiEA9aJWjNV/awTa3Ea5TVSTe3uTTNF
         J/4lZYjDE3BjKkE5pvX0ee4CPubgRpOtShzIOmy3szsps+8J4IMHVn61WBQX7/LV1Fup
         l5AyD4Hc6HupP+3mjc47BSlmouuGKiPQ5GK78=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=qOLPm/zEh+9b7cJpnuPMbDnEX/yR3a9YYxrYfnIvF4hzNvg39bdPe/Mjhu81Ux7asO
         hthMMnO191kFazCfazkuW4SK0W5Yl6mRGtS3BwBlfyAFgLjyrvUCtb0mDTtNYYHWfW+M
         Wysb2CG0NRwHEm68/gZemaJBw4Q7Dt/dpD8Vg=
Received: by 10.141.123.4 with SMTP id a4mr1254817rvn.172.1219519386368;
        Sat, 23 Aug 2008 12:23:06 -0700 (PDT)
Received: by 10.140.166.19 with HTTP; Sat, 23 Aug 2008 12:23:06 -0700 (PDT)
In-Reply-To: <7vmyjxyf7a.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93476>

On Thu, Jul 31, 2008 at 11:24 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
>> ... And since the original pack-file is marked as a 'keep' file,
>> that original pack-file won't even be broken apart.
>
> Oops, isn't that something we fixed recently as a "bug"?
>
>> So completely ignoring the fact that you could do a single database with
>> git, and completely ignoring the fact that with git you'd probably use
>> branches for at least some of those 11 repos anyway, he'd _still_ have had
>> less disk space used by git unless he would do something intentionally odd
>> (like clone all the repositories over the network separately).
>
> Well, people are not perfect and they are free to express their opinions
> based on faulty understanding of reality on their blogs.  The right things
> to do are (1) ignore them on the list and not waste many people's time,
> and/or (2) educate them, but in private or in a circle where many other
> similar ignorants benefit from such education.  That is not here but
> perhaps on #monotone channel?

Hm, joined late to the discussion.

I had a lengthy discussion on pidgin's mailing list regarding my
analysis of monotone [1]. I didn't go very well. I don't think they
want to be educated about git.

It turns out they evaluated git as an option in the 1.0 days and they
disregarded it mainly because of the size of the repo; they didn't run
'git gc'. I fail to understand why they didn't drop in #git or asked
in the mailing list. That should tell you enough about their informed
decisions.

Anyway, that blog post was probably a way to justify their choice
after the discussion. With the added note now there's nothing that
makes git a bad choice for them, but surely they will find another
equally flawed reason.

Best regards.

[1] http://pidgin.im/pipermail/devel/2008-July/006308.html

-- 
Felipe Contreras
