From: James Blackburn <jamesblackburn@gmail.com>
Subject: Re: git log --follow doesn't follow a rename over a merge
Date: Thu, 16 Jun 2011 14:31:02 +0100
Message-ID: <BANLkTik1-UvEXqzgdXwcK3x6_o8fDiwB7g@mail.gmail.com>
References: <BANLkTimjEp0ntq80qttT9uZN2YGuhsnZBw@mail.gmail.com>
	<m362o5vrhd.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 16 15:31:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QXCf7-0003IF-Sz
	for gcvg-git-2@lo.gmane.org; Thu, 16 Jun 2011 15:31:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752138Ab1FPNbF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Jun 2011 09:31:05 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:61686 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751550Ab1FPNbE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Jun 2011 09:31:04 -0400
Received: by qyk29 with SMTP id 29so187182qyk.19
        for <git@vger.kernel.org>; Thu, 16 Jun 2011 06:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=NAeVvRhzXqX473W6tC/zotXtm+2MCQcj+uGBb922Bxc=;
        b=Ym2zdeGMjbGssnGY01VdEw5UpF/qRCbLz1yrrl1E+ABSqkUFRsfWhcJuZrDuk9XY4t
         ndBPIAPUf1dpvyXe2hE4/t38zr6SIgPR157jlJ3GtFxx/tbr4Tgm18ceE+ZV04/+8mhB
         iLqDAOLuYUFKfxgzRxbE1YYC+i5oPxwA/CvWs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=SpCwTisyq8QhSvz1AEKV9BMySg1/VWJskfCNm6do8kHOxRWvHuv7Bfwkr1HJevHYiJ
         RIT8Hp2i/LaMSjqIKFk0X2bILRSaEQyHh8V+QK6+AhbmBMUYOgY9HoMFwOWOnHwZUw2y
         yoEbwCYYaHqh0z7seJvthfWXlTBsja1KwDYMk=
Received: by 10.229.10.82 with SMTP id o18mr765614qco.79.1308231062243; Thu,
 16 Jun 2011 06:31:02 -0700 (PDT)
Received: by 10.229.214.203 with HTTP; Thu, 16 Jun 2011 06:31:02 -0700 (PDT)
In-Reply-To: <m362o5vrhd.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175898>

On 16 June 2011 14:25, Jakub Narebski <jnareb@gmail.com> wrote:
> James Blackburn <jamesblackburn@gmail.com> writes:
>
>> I'm trying, without success, to get git log to show the history of a
>> file across a rename. =A0I'm using=A0git version 1.7.5.4, and git bl=
ame
>> has no such issues tracking the source of the lines.
>
> [...]
>
>> Have I done something wrong in grafting history like this, or is thi=
s
>> just a problem with the way git log --follow tracks renames?
>
> The `--follow` option to git-log is more of a bolted-on hack rather
> than proper solution, see 750f7b6 (Finally implement "git log
> --follow", 2007-06-19), and it might not work in all cases.

Thanks for the reply Jakub.

I'm also interested in knowing what incantation I need to give to
actually get history of the file which was previously removed.  e.g. I
know the full path:
   plugins/org.eclipse.dd.dsf.debug/src/org/eclipse/dd/dsf/debug/servic=
e/IBreakpoints.java
used to exist, but without --follow, git log returns nothing.

Similarly I can't figure out how to find (without knowing in advance)
which was the last commit which contained this version of
IBreakpoints.java. i.e. which commit removed / renamed it?

Cheers,
James
