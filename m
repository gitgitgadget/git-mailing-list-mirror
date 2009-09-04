From: Howard Miller <howardsmiller@googlemail.com>
Subject: Re: Commit to wrong branch. How to fix?
Date: Fri, 4 Sep 2009 19:01:06 +0100
Message-ID: <26ae428a0909041101h509ffa31odf3502228517043a@mail.gmail.com>
References: <88A0A7C2-7DCB-45A3-B196-BED2A8AC9405@googlemail.com>
	 <4AA13DF4.4050604@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Sep 04 20:01:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mjd63-0005GW-PR
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 20:01:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932828AbZIDSBH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2009 14:01:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757185AbZIDSBG
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Sep 2009 14:01:06 -0400
Received: from ey-out-2122.google.com ([74.125.78.26]:21400 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757177AbZIDSBF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2009 14:01:05 -0400
Received: by ey-out-2122.google.com with SMTP id 25so626340eya.19
        for <git@vger.kernel.org>; Fri, 04 Sep 2009 11:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=VF38p9FZeIi9x1/03qo5k7D0hYYsc7eZAU5BCDfJ880=;
        b=K/SPWFdjQan+S7B+NJDuwxJpbanR6/bYtG9Yfy7dU2J4jqpzMBqdJlGpqlOcdRUvwN
         GWejF3Ij8XPJ5cZ6N2EuQOsBMn8EbYTjVfxf9O4wygcmoQqsXsL5d49jTkx/x8jyhUiX
         Ht16MALGGnrrVL6EjOy/V0Sqbn27o+9ogNNEM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=AkzIk9UkR4jsf9gMSixMG0X7iMdOmdj37sl3a/yXWgX2qh5vnCHJIo4D44KleqZ8Uq
         43+yqKGhbClnX4xrg8pxCZs5p9Jt5oYINwSxuLu5/oJ3ETKP93TvimKvJa0wHoSWdvpf
         MEf0h8NdBXBArtH8O1qRo5/DAyyL1fcTmxwwY=
Received: by 10.216.70.204 with SMTP id p54mr2293319wed.87.1252087266321; Fri, 
	04 Sep 2009 11:01:06 -0700 (PDT)
In-Reply-To: <4AA13DF4.4050604@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127754>

Hi Michael,

Thanks for your help.

I had modified a few files and then done a 'git commit -a'. It was
only after this that I did a status and realised that I had switched
to a different branch (and forgotten). Unfortunately the branch I
switched to tracks a remote that is my stable release so I'm a bit
precious about it. If I forget again and push it, I'm in trouble :-)
Yes, I have done that before!!

Howard

2009/9/4 Michael J Gruber <git@drmicha.warpmail.net>:
> Howard Miller venit, vidit, dixit 04.09.2009 17:54:
>> I commited to the wrong branch and I can't figure out what to do. To
>> make matters worse I then did 'git reset HEAD^' which has made things
>> much worse. It didn't remove the commit and now I can't change
>> branches. I'm utterly confused. Any help much appreciated!
>>
>> Moral - use git status liberally and read it carefully before doing
>> anything. A 'git undo" command would be great is someone is feeling
>> generous :-)
>
> Whatever happens, don't panic ;)
>
> Let's say "geesh" is the branch on which you committed by mistake, and
> which you have reset.
>
> git reflog geesh
>
> which show you what has happened to that branch lately. In particular,
> it will list the "lost" commit. (Most probably it is the same as geesh@{1}.)
>
> git tag sigh sha1ofthatcommit
>
> will assign the tag "sigh", so that it won't get lost by doing "git gc"
> or such. Now you can lean back!
>
> Next step is committing "sigh" to the right branch. Depends on how you
> arrived at that commit. Did you commit the complete tree you wanted, or
> did you apply a change to geesh which you rather had wanted applied to
> some other branch?
>
> Michael
>
