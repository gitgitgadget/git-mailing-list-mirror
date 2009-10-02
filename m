From: Eugene Sajine <euguess@gmail.com>
Subject: Re: Re: Git push over git protocol for corporate environment
Date: Fri, 2 Oct 2009 10:41:59 -0400
Message-ID: <76c5b8580910020741p2024f6c0w70be53338924e7e8@mail.gmail.com>
References: <m3pr989eyt.fsf@localhost.localdomain>
	 <00163623ac5d75929b0474e66b96@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Eugene Sajine <euguess@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 02 16:42:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MtjKg-0007VD-9e
	for gcvg-git-2@lo.gmane.org; Fri, 02 Oct 2009 16:42:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757955AbZJBOl5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Oct 2009 10:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757954AbZJBOl4
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Oct 2009 10:41:56 -0400
Received: from mail-gx0-f212.google.com ([209.85.217.212]:57690 "EHLO
	mail-gx0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757619AbZJBOlz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Oct 2009 10:41:55 -0400
Received: by gxk4 with SMTP id 4so1556444gxk.8
        for <git@vger.kernel.org>; Fri, 02 Oct 2009 07:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=B1eY3bJ+9MtThOzwyhy1C+O+80wAk3sJI53nznvIDHk=;
        b=MZv3nlrSX+glgJ4kDLelgbForpTyZFn8kE14a9FDicWgIw7LJQYCz6nV3oL/UdioM3
         5oZXaS0EavI3bwHA+pruUDEqEG5qW24QBrUPT+26BP1o1quKsS3G6ycM4WbqtBmrijtW
         OEL4fcDl1fAtRzT8v4zdd3vnmWj2EMqCBdo1A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=dCz5uqagpqh4G38DgFOoIV24fTNK/GgmdMzUCbZ9e6S1tiqvnVfcOt3xgl4wUIiXml
         bM/VfG4x4KaV8ePWGWJnw+LFPz5VdeoV7Ba0g/upK1v8WQ6CL7fiYSr9vBhOKEj2IjUm
         eggL8WmSM7qUtswlAHVI/uqckfIT1LkFJVQfY=
Received: by 10.91.102.6 with SMTP id e6mr1481510agm.99.1254494519416; Fri, 02 
	Oct 2009 07:41:59 -0700 (PDT)
In-Reply-To: <00163623ac5d75929b0474e66b96@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129444>

I'm sorry if it will be a dup again... My first email got stuck or
deleted by server, although i didn't use any html...

Thanks to everybody for prompt answers!

There is one thing I=E2=80=99m still missing though. Do I understand co=
rrectly
that if a person has an ssh access (account) to the host in internal
network, then this won=E2=80=99t be enough for him to be able to push t=
o the
repo? Should we still go through the hassle of managing the ssh keys
for each particular user who is supposed to have push access?

I believe the answer is yes and that's why I'm leaning towards pulls
and pushes over git protocol. There is no solution yet which would be
as effective and simple to maintain. Using git protocol will not add
security, but it won't be worse than existing CVS or any other
centralized version control security model. As soon as security comes
into play, then we will need some other solution, but currently i
didn't see anything that would be easy to sell to the company.

Github is cool, but FI is way too expensive and very hard to sell.

Gitorious is even better!! for corporate use, i think, because of its
team oriented approach, but... man... I would kill for java
implementation or anything as simple as that!! As i see It is
impossible to install in network without internet access, and the
amount of dependencies which you have install/pre-install is enormous.
I read somewhere ruby on rails is fun to develop with, but is a
nightmare to deploy and maintain, and it seems to be true. Come on,
guys!! Look at the Hudson CI - one war file containing everything you
need, application starts from command line "java -jar hudson.war" and
runs on any port you specify. Time to start from download to having
first build is less the 10 min!!! If there are gitorious guys -
please, think about it and don't forget to share the profit;)!

I think Cgit can be something competitive - although i failed to run
it yet, having some issues with build...and as all other web based
stuff, you should implement something in order to create and set up
bare repos on the server automatically (even probably edit the config
file via script) to avoid a mess and to avoid one guy spending his
time adding and configuring repos... Probably we will and up using
gitweb as it at least knows to scan a folder for git repos...although
it also gives me troubles installing... both with cgit and gitweb are
conducted under cygwin, so probably this is the real problem with
them;)

I think that this is what is missing right now in order for git to get
rocket start and spread inside companies: secure and easy to maintain
mainline hosting.

Probably my lack of experience with git causes these thoughts - so,
while i will continue to work on it, i would really appreciate any
advice, especially about experience using git not for open source and
not in 3 person's team.

Thanks a lot,
Eugene
