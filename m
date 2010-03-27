From: Steven Michalske <smichalske@gmail.com>
Subject: Re: native-git-svn: A Summer of Code 2010 proposal
Date: Sat, 27 Mar 2010 01:03:13 -0700
Message-ID: <9C72512D-F49A-4E94-A5D2-5F8D5BCCDFFA@gmail.com>
References: <3d4937ff1003262240t6159d9c5sc9253f555c3aed1@mail.gmail.com> <f3271551003262346g286e7e72u751e15cbc99a9c1@mail.gmail.com>
Mime-Version: 1.0 (iPhone Mail 7E18)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Stephan Beyer <s-beyer@gmx.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Peter Baumann <waste.manager@gmx.de>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 27 09:07:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvR3f-0001gF-5n
	for gcvg-git-2@lo.gmane.org; Sat, 27 Mar 2010 09:07:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179Ab0C0IHq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Mar 2010 04:07:46 -0400
Received: from mail-yw0-f172.google.com ([209.85.211.172]:52272 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751055Ab0C0IHd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Mar 2010 04:07:33 -0400
Received: by ywh2 with SMTP id 2so3985047ywh.33
        for <git@vger.kernel.org>; Sat, 27 Mar 2010 01:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:references:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:mime-version
         :subject:date:cc:x-mailer;
        bh=nmMdhNCkqoeu4XvATnutPxA6J4N1apKesdc3J8apZ2c=;
        b=G6ci7H5Ig/b4E+IEU/USZykedAAwaPIXhxbLU0ILAclozyHTHtBnU0zsNY8gjsexY1
         ZGDZ32RcieAMdy0t5+GchkL/YTt0L7XHS3TfI3Wm8TrymfpTsiH91uAZbFyxaB0G404n
         TIVGhDPH6MnKtjqUiyn+TkMkRHXN8tTtOC5L8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=references:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:cc:x-mailer;
        b=Tbeylk3eJceMkSSrOicI0QIzY24iO2stKzknYdSsFqq5cTGNhL2N8EqFTdwG27EPqV
         tI072pV6OsKZPap7Xj2iSpVPw/bSdhQ/jcdO42va9syVxevvZ2fLX5CAn3L4kcoZZitk
         poBB7mE8hZ0n5YwfOS4y+aCd6YFcg6isirUQo=
Received: by 10.150.251.10 with SMTP id y10mr2592314ybh.123.1269677252589;
        Sat, 27 Mar 2010 01:07:32 -0700 (PDT)
Received: from [192.168.1.104] (c-98-234-104-87.hsd1.ca.comcast.net [98.234.104.87])
        by mx.google.com with ESMTPS id 4sm473003ywd.58.2010.03.27.01.07.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 27 Mar 2010 01:07:31 -0700 (PDT)
In-Reply-To: <f3271551003262346g286e7e72u751e15cbc99a9c1@mail.gmail.com>
X-Mailer: iPhone Mail (7E18)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143320>

On Mar 26, 2010, at 11:46 PM, Ramkumar Ramachandra  
<artagnon@gmail.com> wrote:

> [Please don't cull people from cc]

I didn't intend to,  I wasn't on the mailing list before and the  
message was not a reply to but a new message with the same subject.
>
>> Would cython meet the needs of increasing the speed of the python  
>> code
>> without requiring a rewrite?
>
> Actually, I've subsequently decided that this is unnecessary. Besides,
> I'm writing in C mainly for portability to msysgit (Windows). Could
> you please look at the updated version of my project proposal?
>> I work at a company with a LDAP server that I can look up the svn  
>> username to
>> get real name and email address.  This way I don't have to manually  
>> maintain a
>> svn authors file.
>
>> I'm torn on how the current system handles this,  I like all tags to
>> be tags, and
>> that if a tag had a branch like behavior (bad SVN users!), that a  
>> branch exists
>> for it, with the tag pointing to its branches head.
>
> This shouldn't be a problem to implement/ improve at the end of my
> GSoC term. However, it's important that I don't lose focus and
> concentrate on the core task at hand for GSoC, which is more about
> getting native support for SVN than anything else. I have neither the
> expertise or time (one GSoC term) to build a fantastic importer and
> get native support: I will be re-using several parts of existing
> importers for the purpose of the GSoC.
>
Clean documented locations for adding the calling of these kinds of  
addons is all that's needed,  then us other folks can chip in too with  
the bits like the LDAP support.

>> Support for SVN's blank folders.  Some of the old build systems I  
>> have used
>> need the blank folders, so I have to create to make the build  
>> work :-(
>
> Okay, this should be simple enough to implement. Thank you for  
> pointing it out.
>
>> One of my SVN repositories using the current system fails to import  
>> that
>> repository is missing a revision in its SVN history.  In other words
>> the SVN repo
>> has corrupted history the current git-svn will fail to import the  
>> repository.
>
> I'll keep this in mind when designing svn-fast-import: a certain
> revision's checkout can fail, and a mechanism to bail the user out of
> such a situation can be helpful. Again, I can't promise that this'll
> be completed by the end of the GSoC term, but I will make it easy
> enough to write the functionality in later on.
>
>> If you want me to test your work on a hairy repository with corrupt  
>> history and
>> thousands of branches, I'll do that for you.
>
> Thanks! That'll be wonderful. If my proposal gets accepted, I
> certainly will contact you (and several others) for testing, once the
> core task of the GSoC is complete.
>
>> But working at a company with lots of history in SVN makes me  
>> passionate
>> about the SVN integration in git :-)
>
> Good to know. Thank you for your support :)
>
> -- Ram

Happy hacking!
