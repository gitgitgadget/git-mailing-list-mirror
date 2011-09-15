From: Joshua Stoutenburg <jehoshua02@gmail.com>
Subject: Re: Anybody home?
Date: Thu, 15 Sep 2011 14:00:20 -0700
Message-ID: <CAOZxsTq0qMB_Y97WcodVbO6DmXRXBpP_at3SF-VkPbbcnDfjgw@mail.gmail.com>
References: <CAOZxsTq1crC0zeMpFGMafG8HXu168gkK2-KDnpwLoamRLJshjg@mail.gmail.com>
	<4E71A5FF.5040807@viscovery.net>
	<CAOZxsTqGt=gYr3t7e5Ma4z6W9wt_JxrgsNSGFGVbtk2rc3LZ9w@mail.gmail.com>
	<CAP2yMaJcKnghtxxDNVYk=00KQ-ZOGEwACHRTU15tGnOuk3R4Hw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 15 23:00:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4J2p-0001PH-5L
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 23:00:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934917Ab1IOVAW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Sep 2011 17:00:22 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:41100 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934775Ab1IOVAV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Sep 2011 17:00:21 -0400
Received: by eya28 with SMTP id 28so597268eya.19
        for <git@vger.kernel.org>; Thu, 15 Sep 2011 14:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=PwmVsGwwendwK3L9OGqBsQnfaUD6qkjlRhQ5I+Xe87U=;
        b=lyjXqkqJEpCqzVn/PQlqL/obAgxvkQlTXoKA60TL2T6/frmxpoLJKAsvQ9rlNZ6vm2
         3IrRw+7+QggLLiMUJkwCqDqjDiyDIhxqg9yrJK2y7Pi5lHNJrYNSlR08BVLqasDk5WyL
         cB0X8EDEv5MAfWuFs5/PRCo+QfVIXHc0B8UL0=
Received: by 10.213.3.153 with SMTP id 25mr662883ebn.15.1316120420493; Thu, 15
 Sep 2011 14:00:20 -0700 (PDT)
Received: by 10.213.16.195 with HTTP; Thu, 15 Sep 2011 14:00:20 -0700 (PDT)
In-Reply-To: <CAP2yMaJcKnghtxxDNVYk=00KQ-ZOGEwACHRTU15tGnOuk3R4Hw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181494>

On Thu, Sep 15, 2011 at 8:04 AM, Scott Chacon <schacon@gmail.com> wrote=
:
> Hey,
>
> On Thu, Sep 15, 2011 at 2:01 AM, Joshua Stoutenburg
> <jehoshua02@gmail.com> wrote:
>>> Reading your exchanges elsewhere in this thread, I think you missed=
 that
>>> you don't need a git server at all just to *use* git.
>>>
>>> Even when you want to exchange your commits between two or three ma=
chines,
>>> all you need is ssh access. There is no *git server* necessary. git=
 is not
>>> svn. ;-)
>>>
>>> I thought I'd just mention this to help you streamline your search.
>>>
>>> -- Hannes
>>>
>>
>> I read the first four and a half chapters from the Pro Git book pdf.
>> So I think I understood that much.
>>
>> But in my situation, I do need a server so that other developers can
>> access anytime over the internet.
>>
>> I should have mentioned that.
>
> I guess I'm confused. =A0The fourth chapter of the Pro Git book is
> entirely about setting up your own Git server, including basically
> step by step instructions on Gitolite and Gitosis, in addition to
> simply running your own ssh-based server plus gitweb. =A0It is like 2=
0
> pages long - how is this not exactly what you're asking for?
>
> Scott
>

Scott -- the man himself!

I've been reading the pdf version of the excellent Pro Git book:
http://progit.org/ebook/progit.pdf

In the pdf version, Chapter 5 covers "Git on the Server". I was a
little confused at section 5.2, "Getting Git on a Server".

I was expecting a process very similar to installing on a work station
(sections 2.4, "Installing Git", and 2.5, "First-Time Git Setup"),
with differences pertaining to the server. But this section (5.2)
didn't talk about that and seemed to assume I already installed Git on
the server. Instead, this section explains how to create a bare
repository and Section 5.2.1 explains how to put the bare repository
on the server.

So I jumped ahead to section 5.4, "Setting Up the Server", hoping to
find the process I was expecting. For the most part it was there. But
I was left pondering how tedious it would be to manage a couple dozen
git users.

So I read sections 5.7 "Gitosis" and 5.8 "Gitolite". It sounds like
these two tools do the same thing. Since I'm not sure what makes them
different, I wasn't sure which one would fit my needs.

Then, I heard about Gitorious and would like to give that a spin. The
idea of installing a single piece of software that does everything
seems more appealing than installing and configuring multiple pieces
of software.

I'll return to the books for now and do the best I can.

I'm running the Git server in a VirtualBox VM server and keep
snapshots after significant changes. So if I break anything, it will
be a couple clicks to recover.

Thanks for everyone's help.
