From: Chris Packham <judge.packham@gmail.com>
Subject: Re: Pseudonymous commits
Date: Thu, 25 Mar 2010 14:30:27 -0700
Message-ID: <a038bef51003251430v35ab602v661f24888d637afa@mail.gmail.com>
References: <4BAADF34.3080806@gmail.com>
	 <4BA51E6B-7325-465A-B23E-7F3C5BF87700@mit.edu>
	 <4BAAE981.4040205@gmail.com>
	 <alpine.LFD.2.00.1003251459540.694@xanadu.home>
	 <4BABB8DC.7060906@gmail.com>
	 <alpine.LFD.2.00.1003251605560.694@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Mike.lifeguard" <mike.lifeguard@gmail.com>,
	Theodore Tso <tytso@mit.edu>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Thu Mar 25 22:30:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuudO-000529-5y
	for gcvg-git-2@lo.gmane.org; Thu, 25 Mar 2010 22:30:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753803Ab0CYVa3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Mar 2010 17:30:29 -0400
Received: from mail-qy0-f188.google.com ([209.85.221.188]:59041 "EHLO
	mail-qy0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752155Ab0CYVa2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Mar 2010 17:30:28 -0400
Received: by qyk26 with SMTP id 26so5935246qyk.19
        for <git@vger.kernel.org>; Thu, 25 Mar 2010 14:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=9NpqE6NhQCL7JHlKS/YqNia3Yb6SxQFwHwP9Lv0+50s=;
        b=xwQzsxvmSuA8NywWYWsMUSl27CgPEC1TvqTtv8mpjvNdCBxO4bqIY6I3kri/DbkMto
         OwoVKR8mKoDbsalD4kE5hX/sm1GVZSLwj5VTpvjgFhbh1LiAqnSV0HmBfGiaQ4xUQCKS
         v2BYe7GicpoFAk8QPUM+noOda0e1goykHjeBc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Bx7gPlINTdM+s1z8VeebY+yYzqAKWSrjHHPrHUkzYyyNKpLyMqWBHEa5LJLLDvIAg5
         t0RRNxzULoBgPXhkK+Y6IVewKu0gL/UNhIOhUFLamZKZyihQTsP1meDe1Gr+iKoUC+5H
         YpKHHpn56MLUyqjADw51AtkKdwDLXVHBNFQVg=
Received: by 10.229.38.69 with SMTP id a5mr2397845qce.15.1269552627503; Thu, 
	25 Mar 2010 14:30:27 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1003251605560.694@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143199>

On Thu, Mar 25, 2010 at 1:14 PM, Nicolas Pitre <nico@fluxnic.net> wrote=
:
> On Thu, 25 Mar 2010, Mike.lifeguard wrote:
>
>> In the end, I managed to convince them they wouldn't be spammed (hop=
e
>> I'm right), and I used their real emails. Nonetheless, I appreciate =
the
>> help.
>
> Oh, if your project is public and accessible through gitweb then
> spammers will certainly scan it and pick up their email addresses.
> Maybe some of them might even go as far as cloning Git repositories j=
ust
> for that purpose. =C2=A0Only local spam filtering may help in that ca=
se.
>

Sounds like it'd be a really good option to have in gitweb to
obfuscate email addresses a-la gmane and practically every other web
based mailing list/news reader. Could be fairly low hanging fruit with
a decent payoff (not that I'm volunteering). Can't do much about clone
and spam.
