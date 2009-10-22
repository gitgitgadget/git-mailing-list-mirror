From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Deciding between Git/Mercurial
Date: Thu, 22 Oct 2009 10:01:25 +0200
Message-ID: <46a038f90910220101h4f3ecf22x6923ac41e8b6d4f9@mail.gmail.com>
References: <h9nlhj$heq$1@ger.gmane.org>
	 <200909272001.48180.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: newsgroups@catchall.shelter13.net, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Thu Oct 22 10:03:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0seK-0004WX-7r
	for gcvg-git-2@lo.gmane.org; Thu, 22 Oct 2009 10:03:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752730AbZJVIBW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Oct 2009 04:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752318AbZJVIBW
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Oct 2009 04:01:22 -0400
Received: from mail-ew0-f207.google.com ([209.85.219.207]:58183 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751031AbZJVIBW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Oct 2009 04:01:22 -0400
Received: by ewy3 with SMTP id 3so282141ewy.17
        for <git@vger.kernel.org>; Thu, 22 Oct 2009 01:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=+wdYYtTm8IyjGs9YUcgw4qkLN9lnuLGQwNH3UVWmo+A=;
        b=UW+Qt2Bkh6h1rIW1Jz4Y9SSj/LrPMluVH/BLvMh0h/Yf74dK7b/j98nt3cOyKcXORT
         qsu4cO++Ax09V2aPKy9fDfBxCmr89MvwHOXtmY3NIA4VAG3I7o3BTm+dOF1Kf29dIa0q
         WspdGYvSBsEL74Q4exkt6LKXTu/e/nJhA7xWQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=pVCJOj2GxhUNfFi26NBGcl1+Wn/RS69KEUm4DrYcbwhpDbmCrA2OiPsTIzoLJC+6Ts
         pMa3bKruYh2umMMWrxeYH4w7cm6oU5cW8+10diIoJywh+7MY+cYsU4/YmRcd94QYrlPj
         bt5m1yQh77DRYL61E08qf9tNhbFxJFo4qEepc=
Received: by 10.211.132.3 with SMTP id j3mr4087912ebn.54.1256198485830; Thu, 
	22 Oct 2009 01:01:25 -0700 (PDT)
In-Reply-To: <200909272001.48180.robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131003>

On Sun, Sep 27, 2009 at 8:01 PM, Robin Rosenberg
<robin.rosenberg.lists@dewire.com> wrote:
> s=F6ndag 27 september 2009 14:24:32 skrev Anteru <newsgroups@catchall=
=2Eshelter13.net>:
>> Mercurial's revision number system: With git, I get an SHA1 hash for
>> every commit, but it's not possible to see whether Hash1 is newer th=
an
>> Hash2, while Mecurial also adds a running number to each commit. Wha=
t's
>
> But those numbers cannot be communicated since they are local to your
> clone.

You can use git-describe, which will look for the latest tag, and make
a combo of latest tag, commits since the tag, short form of sha1. So
you get "v1.6.3-33-g1234" - 33 commits after 1.6.3. Works very well to
integrate in versioning. The git project itself uses it in the
Makefile to set the versions, same as the kernel folk do -- I use it
to version even RPM/DEBs.

hth,



m
--=20
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
