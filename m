From: "Aaron Gray" <aaronngray.lists@googlemail.com>
Subject: Re: git svn fails to work
Date: Sat, 28 Mar 2009 21:43:04 -0000
Message-ID: <AE2ECDC6B332479293D910D9352DCF21@HPLAPTOP>
References: <EA1460555FA0423EB6C233B3B0F4F098@HPLAPTOP> <37fcd2780903281351w6f77a647kd44a9afe4d2ee953@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 28 22:44:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LngKc-0003y1-1S
	for gcvg-git-2@gmane.org; Sat, 28 Mar 2009 22:44:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757735AbZC1VnN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Mar 2009 17:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755094AbZC1VnN
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Mar 2009 17:43:13 -0400
Received: from mail-ew0-f165.google.com ([209.85.219.165]:38590 "EHLO
	mail-ew0-f165.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052AbZC1VnL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Mar 2009 17:43:11 -0400
Received: by ewy9 with SMTP id 9so1541148ewy.37
        for <git@vger.kernel.org>; Sat, 28 Mar 2009 14:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to:references
         :subject:date:mime-version:content-type:content-transfer-encoding
         :x-priority:x-msmail-priority:x-mailer:x-mimeole;
        bh=Qe5jLNLw/dHuq2jfzohVOX129BvnWo3iLqWM6WfJVis=;
        b=k0MlcW+HfpT6mw8w6EhEGoGq8OcyD1dmecIhqwNh1Jh7wATFeu3n8mL2GPkdNpZ/n7
         F9mdJKCsL7x6m95kMtAy0EzdVaOFULK3HUGv4Df8DDjR4poGI0QS9H299c/8lIpXw4Nx
         2xufXc585w0BbtJ/xAkM0z6XFBAi9TpoRcK+M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:from:to:references:subject:date:mime-version
         :content-type:content-transfer-encoding:x-priority:x-msmail-priority
         :x-mailer:x-mimeole;
        b=jo0jIAiLzkP7X48pT2ZNGl1a1osN9Pi9UcxdfUgN+EhpwRzEjG6q+E4NQ5Izw58p/U
         A5Cp1pcuJa6/LSaQxkHhlkFjLTawOO5BcJPlGLs++og9YyWZOQ8S1p4MPGFe0QSSZSF8
         0okpXzGTDCUzRcyYD7yYphmp/ANXAcEow1uzU=
Received: by 10.210.16.10 with SMTP id 10mr1326062ebp.21.1238276588862;
        Sat, 28 Mar 2009 14:43:08 -0700 (PDT)
Received: from HPLAPTOP (mwgray.force9.co.uk [212.159.110.144])
        by mx.google.com with ESMTPS id 5sm3643311eyf.2.2009.03.28.14.43.08
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 28 Mar 2009 14:43:08 -0700 (PDT)
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5512
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5579
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114977>

> On Sat, Mar 28, 2009 at 8:48 PM, Aaron Gray
> <aaronngray.lists@googlemail.com> wrote:
>> I have been tying for a week to get git svn to work. If i do a 'git
>> clone'
>> and if falls over 'git svn fetch' picks up from where it left off, but on
>> completion I can only see the older stuff if at all and a 'git clone
>> rebase'
>> eithr shoud up unreconsilable differences or refuses to execute the
>> command
>> at all, gust giving uphelpfull help afaics.
>
> I am afraid if you expect anyone to help you with you, you have to spend
> a little more time to describe your problem. You have not mentioned what
> version of Git you use, what operating system, what is layout of your SVN
> repo, what commands and with what options you used and what was their
> output. Without that information no one will be able to help you...
>
>> Otherwise I am giving up and either going back to svn or over to
>> mercurial.
>
> Yeah, right... These kind of threats will make people who want to help to
> come running....

Sorry, but I am very frustrated with the whole thing, there is not real user
guides for git-svn other that third party ones which seem to be wrong.

I am using Fedora 10, GIT 1.6.0.6, the svn repo is standard layout although
I only want trunk, it here :-

    svn co http://llvm.org/svn/llvm-project/llvm/trunk llvm

This is quite a big repository 65000 or more revisions.

The commands

    git svn clone http://llvm.org/svn/llvm-project/llvm/trunk

when connection fails I do a :-

    git svn fetch

gitweb is not updating at all to show any change in the repository.

Aaron
