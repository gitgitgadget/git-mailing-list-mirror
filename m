From: Ricky Clarkson <ricky.clarkson@gmail.com>
Subject: Re: Case sensitivity on Windows for absolute paths.
Date: Sun, 25 Apr 2010 19:47:23 +0100
Message-ID: <r2z7eeb06461004251147jce635231kca659b52a48571d0@mail.gmail.com>
References: <o2v7eeb06461004230712i2c8c1e61l4c50a73a4f6c83d@mail.gmail.com> 
	<201004232146.56424.j6t@kdbg.org> <j2y7eeb06461004250033ue4434a41j7b9a752dea1f5fe1@mail.gmail.com> 
	<201004252008.27823.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Apr 25 20:51:01 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O66ur-0000l3-VE
	for gcvg-git-2@lo.gmane.org; Sun, 25 Apr 2010 20:50:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753610Ab0DYSus convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Apr 2010 14:50:48 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:3103 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752833Ab0DYSur convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Apr 2010 14:50:47 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1547303fgg.1
        for <git@vger.kernel.org>; Sun, 25 Apr 2010 11:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=YPMZ+FKRdFmRiPlvmH3Xicwat6mzh+rjf2RhrCr8iu0=;
        b=jgwRPlORZYa6Hlrb9hXUj1vPgbFSh1ARoYyibGm1fUY+RcvjkCQAKIRO62hs0/9MSD
         KGhp1CPJra9pQEk7X8ZHXoEMdJY+PQTzhQ0JN9an78SnhwigozXVjJETEGoiHU9kNUZv
         CnNJkT9ynNfVjzuHqRUr1RyclYCTRolJoF5Jk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=FOLvb1ceOMtqt7EBN9Y5O1vEbynScBPa+Fd7VUN6f8KY+/7iajEZAc7XgF7vCsnR0E
         L+Y9L85Q4MQfthLLryFEcA/wk29U+mU6JEtyMpjFE4y47piJHveZCYcc/wonf24PKfNN
         HLIN2iLRiFVYu8nhr2p3VjZ4jVMWiw1TqXBrc=
Received: by 10.87.29.33 with SMTP id g33mr5277118fgj.27.1272221396976; Sun, 
	25 Apr 2010 11:49:56 -0700 (PDT)
Received: by 10.223.126.3 with HTTP; Sun, 25 Apr 2010 11:47:23 -0700 (PDT)
In-Reply-To: <201004252008.27823.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145758>

Hi Johannes,

$ cd /c/uk-org-netvu/

Ricky@RICKY-XP /c/uk-org-netvu (trunk)
$ cmd
Microsoft Windows XP [Version 5.1.2600]
(C) Copyright 1985-2001 Microsoft Corp.

c:\uk-org-netvu>

If I run cmd via Start -> Run, then the prompt shows C:\uk-org-netvu>

I also verified this using the Scala interpreter, printing out
System.getProperty("user.dir"), which varied similarly in case
depending on whether I started it from cmd or from Git Bash.

Thanks,
Ricky.

--
Ricky Clarkson
Java and Scala Programmer, AD Holdings
+44 1928 706373
Skype: ricky_clarkson
Google Talk: ricky.clarkson@gmail.com
Google Wave: ricky.clarkson@googlewave.com



On 25 April 2010 19:08, Johannes Sixt <j6t@kdbg.org> wrote:
> On Sonntag, 25. April 2010, Ricky Clarkson wrote:
>> It would be good if git automatically uppercased the drive letter,
>> yes. =C2=A0However, I found the real root of my problem. =C2=A0Git B=
ash
>> (msysgit) sets the working directory to c:\foo for programs launched
>> if the working directory within it is /c/foo.
>
> I don't understand what you mean. Git Bash cannot influence whether g=
it sees
> the drive letter in the working directory in uppercase or lowercase. =
Unless
> by "working directory" you mean something else than what getcwd() ret=
urns.
>
> -- Hannes
>
