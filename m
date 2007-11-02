From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] New script: git-changelog.perl
Date: Fri, 2 Nov 2007 20:18:02 +0100
Message-ID: <200711022018.02926.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 02 20:15:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Io1zh-0007fM-Mm
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 20:15:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756830AbXKBTPf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 15:15:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756814AbXKBTPf
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 15:15:35 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:46947 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754101AbXKBTPe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 15:15:34 -0400
Received: by ug-out-1314.google.com with SMTP id z38so669133ugc
        for <git@vger.kernel.org>; Fri, 02 Nov 2007 12:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:content-disposition:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:message-id;
        bh=pKpWBt5S1NTyea8+C5lf1b+mCBeM3QJwlOfb0BA/PR0=;
        b=nRVdggXlEXEWuqTMyzeqgIamUMJyXKPglfmMkOZ+4qk2+dF9I4LMS82kU3k5j09SikxI3nd9RssbbgS+31ujpn+clas0QhJJI+78sfXVDdNZVbxIMTBKNueZg8GNZyeacYUR4kOJS4YnQJBBreQn01KbI5MGClspmiw79h10tbM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:content-disposition:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:message-id;
        b=CNG0dJzDeSMcGNJTeDwcVhTPaQfRqb4wJTF5gfbGfoyL3rEJ6f1ajdy6ZdQiNSDbFRkY8G7wKrtjI55EkGi1fgkbiy0+g1/s6NWGKdZbOPPxjDv+DIJlRhoOdh7RNw9TfzjrV4+hwN4ePnnA2tMZ0KiBzH+cRAxZBKJ9IrQWBxs=
Received: by 10.67.27.16 with SMTP id e16mr1862993ugj.1194030932808;
        Fri, 02 Nov 2007 12:15:32 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.198.10])
        by mx.google.com with ESMTPS id b23sm8779326ugd.2007.11.02.12.15.28
        (version=SSLv3 cipher=OTHER);
        Fri, 02 Nov 2007 12:15:30 -0700 (PDT)
Content-Disposition: inline
User-Agent: KMail/1.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63158>

Subject: Re: [PATCH] New script: git-changelog.perl
From: "Ronald Landheer-Cieslak" <ronald@landheer-cieslak.com>
To: "Jakub Narebski" <jnareb@gmail.com>

On Nov 2, 2007 1:07 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> [Cc: Ronald Landheer-Cieslak <ronald@landheer-cieslak.com>,
>  git@vger.kernel.org]
>
> Ronald Landheer-Cieslak wrote:
>
>> I've written a little script that will format the changes as reported
>> by git-log in a ChangeLog-like format. Entries look like this:
>> <date>\t<author>\n\t<sha1>: <subject>
>
> How it compares to existing git2cl tool?:
>   http://josefsson.org/git2cl/
>   http://git.or.cz/gitwiki/InterfacesFrontendsAndTools

I must admit I didn't know about git2cl. The first difference I see is
that it's simpler and has less dependencies: my script doesn't use any
external modules (e.g. it doesn't parse the date) but just parses a
formatted output from git-log.

Other than that, there's not much difference: my output is a bit
sparser and my script invokes the proper git-log command by itself, so
you don't have to pipe through it (i.e. all you do is git-changelog >
ChangeLog to get your change log) but that's pretty much it.

If you want, you can have a look at it at
git://vlinder.landheer-cieslak.com/git/git.git#topic/git-log-changelog

rlc

-- 
Ronald Landheer-Cieslak
Software Architect
http://www.landheer-cieslak.com/
New White Paper: "Three Good Reasons to Plan Ahead"
