From: Martin Pirker <git.collector@gmail.com>
Subject: Re: synchronizing 2 heterogenous branches by cherry-pick
Date: Thu, 23 Jul 2009 10:41:37 +0200
Message-ID: <8d53e6220907230141l62dd1830g15ca811d5b009f2f@mail.gmail.com>
References: <8d53e6220907210542p4c989f3av2b57202fdd2db1f5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 23 10:42:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTtsf-0006iY-HG
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 10:42:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753416AbZGWIlj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2009 04:41:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753344AbZGWIlj
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jul 2009 04:41:39 -0400
Received: from mail-pz0-f192.google.com ([209.85.222.192]:52784 "EHLO
	mail-pz0-f192.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753315AbZGWIli (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2009 04:41:38 -0400
Received: by pzk30 with SMTP id 30so348813pzk.33
        for <git@vger.kernel.org>; Thu, 23 Jul 2009 01:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=NwLQfCHNbDJ0/qWu5kE4tjK0PHB7Zre6uIUKLojH18U=;
        b=sbCKZKC5v6VW3/600HH5nIWpLi/JFY2m0RsqLOrgq4emiNr4b79fnNL6QdrCaJMUDQ
         a4V8aQITene6Ad/2//nfs8pkiEiQKg0aw0jgsRXYe122FPA2lVh1d+YfDtUJPp3P5qOF
         NjpyYtBPIjem3fbzu8P1RMD/PebCvZpMsB2MU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=ZZqSCyNWwdsE5n0tZbolrlBudByr6NlYrP00zM4YSoCaSwg3soPFZ5EgdrR+CWl8JH
         SBt3AI6MJN2xktHx9KGMgSA4gYSxSGIe01wI+Fx/9tjF6XEOiAOeJLP9RpQLnknw6NxZ
         SdlS4ObDorJV8hV0NB92tG7YVfiP8BaT/jwQw=
Received: by 10.140.187.11 with SMTP id k11mr1265988rvf.105.1248338497798; 
	Thu, 23 Jul 2009 01:41:37 -0700 (PDT)
In-Reply-To: <8d53e6220907210542p4c989f3av2b57202fdd2db1f5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123858>

I'm replying to myself.... for the archives :-)

On Tue, Jul 21, 2009 at 2:42 PM, Martin Pirker<git.collector@gmail.com> wrote:
[....]
>Any good idea on how to automagically script these cherry-picking?

tag identical content point in different branches:
 git tag tag1 commitx
 git tag tag2 commity

get list of newer commits:
 git rev-list tag1^..head1
 git rev-list tag2^..head2

compare content of commits via:
git diff --exit-code commit1 commit2

...and cherry-pick resulting list from one side to the other


Git is an amazing toolbox :-)
Martin
