From: Philip Herron <herron.philip@googlemail.com>
Subject: Re: Code reuse
Date: Wed, 7 Oct 2009 21:12:42 +0100
Message-ID: <ac07bcaf0910071312u13be3b32p8afd956c80e4014a@mail.gmail.com>
References: <ac07bcaf0910061218x148374d0u66b36fae1466ea98@mail.gmail.com>
	 <2e24e5b90910070530p757b3651ne0f7e4a6e8bc8825@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 07 22:20:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mvd00-0003hb-2c
	for gcvg-git-2@lo.gmane.org; Wed, 07 Oct 2009 22:20:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753745AbZJGUNU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Oct 2009 16:13:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753294AbZJGUNT
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Oct 2009 16:13:19 -0400
Received: from mail-vw0-f203.google.com ([209.85.212.203]:36346 "EHLO
	mail-vw0-f203.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752662AbZJGUNT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Oct 2009 16:13:19 -0400
Received: by vws41 with SMTP id 41so2820735vws.4
        for <git@vger.kernel.org>; Wed, 07 Oct 2009 13:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=aAF1JKuBorjbr3QAONYD9VA6jo3Xk8HjpLb3dyBkjeM=;
        b=pbh6jFVtfq4qAvk+Ozq+jw5DyhbzHnNnYj6+G72U9JcCuELI+L6vybMlenJrempGOt
         wpUey2ZhVjioIwpomGwKOj2tjh7M6YdIIB+dHHgTP9CV4mH6vB+zTZOQFy+DtGQp5StK
         dbJGx5kBqg6WGZwFoTjNralCfcvf+u8MF3XLg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=JGtbVw0BjGri4E+439Ta5ew2+uyZZHDaoWhTm+xMxYkdtm/Ps6w+o8BEH+ChCBebEg
         akZYdzMi3owDRh5OhFrgRnal4mBSdSH+kRAdNDSr6zZNySATubYpExh57XIfdKvV2tOX
         EX4jX5JfgxFynsDp0mhmG/ZvJalXjfGQPC4eM=
Received: by 10.220.69.90 with SMTP id y26mr572428vci.51.1254946362277; Wed, 
	07 Oct 2009 13:12:42 -0700 (PDT)
In-Reply-To: <2e24e5b90910070530p757b3651ne0f7e4a6e8bc8825@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129658>

Thanks for that i am no legalese speaker so yeah ;). Its only really
the alloc_nr but its renamed is nearly the same the other really isnt
the same only just 2 statements with different identifiers remain.

Thanks anyways git-core is nice :)

--Phil

2009/10/7 Sitaram Chamarty <sitaramc@gmail.com>:
> On Wed, Oct 7, 2009 at 12:48 AM, Philip Herron
> <herron.philip@googlemail.com> wrote:
>
>> I am not sure if this is the right place to ask this question, but
>> I've been working on a personal project a programming language
>> interpreter for some time now, but i took 2 code snippets from
>> git-core namely:
>
> [snip]
>
>> I've changed it a good bit (probably doesn't resemble much of what i=
t
>> was) to fit in with the way my stuff works but is there anything i
>> need to like put in my source code to say hey this is based of
>> git-core, so far is just a comment to say 'based of git-core hash.c'=
=2E
>> Its an open source (GPL) program but i haven't released or made much
>> noise about it yet because i want to work on it more myself.
>
> In general, the GPL's main requirement is that whoever gets the binar=
y
> should also get the code (I'm over simplifying but that's basically
> it). =A0It actually doesn't say much about giving credit, except (fro=
m
> <HEAD:COPYING>):
>
> "If the software is modified by someone else and passed on, we want
> its recipients to know that what they have is not the original, so
> that any problems introduced by others will not reflect on the
> original authors' reputations"
>
> and
>
> "a) You must cause the modified files to carry prominent notices
> stating that you changed the files and the date of any change."
>
> That's basically it...
>
> It would seem to me that, if you changed them significantly, and goin=
g
> by the above logic, you don't need to do *anything* regarding
> attribution.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
