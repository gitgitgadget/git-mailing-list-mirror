From: Nazri Ramliy <ayiehere@gmail.com>
Subject: Re: Migrate from svn to git
Date: Thu, 27 May 2010 01:04:11 +0800
Message-ID: <AANLkTilNlttIQxyhMJz8_wiOQX5OaL0UahsE54mv6rQ3@mail.gmail.com>
References: <4BFD3AAF.4080403@fechner.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Matthias Fechner <idefix@fechner.net>
X-From: git-owner@vger.kernel.org Wed May 26 19:04:22 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHK1k-0004vO-2u
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 19:04:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753981Ab0EZREO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 May 2010 13:04:14 -0400
Received: from mail-gx0-f215.google.com ([209.85.217.215]:54766 "EHLO
	mail-gx0-f215.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751823Ab0EZREN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 May 2010 13:04:13 -0400
X-Greylist: delayed 30646 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 May 2010 13:04:13 EDT
Received: by gxk7 with SMTP id 7so2579007gxk.17
        for <git@vger.kernel.org>; Wed, 26 May 2010 10:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=v9SAG6uAxdbolctny35hCUjym9rcmuDcGX7IebPMuqU=;
        b=cYy8oTymht3rMS87lpbT4NcYeCPH3oWNLwiO68XjN9R6v7wFh7pE8jmky2lwuIYUTe
         xkA6wza14zSOg5Rh/vnFX7bOFozkULpfv9UetVD7KMyi2ORPYmso1n1olcMbb0ui9/Mj
         MTGQsJaQ/qpdkU4bmbJhIRN+7pt2HEF4t7WfE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=aapiGvTuKzvjBB9Nr8RPoA4VR/a0IPj6+/KK4A7SS/SCaamDINdGzAhSVXVXOCiIKf
         6XxbRTLm1lFR7L7h6B6eD08uaHdd197BqwneQ0b8k7LU23hKpx7yzYrcmEPtYVdZ+ZKo
         +yn7SEH15IYwozXFAyO7lHlTHaM0R+vc7svB8=
Received: by 10.90.181.8 with SMTP id d8mr4666784agf.62.1274893451813; Wed, 26 
	May 2010 10:04:11 -0700 (PDT)
Received: by 10.90.90.2 with HTTP; Wed, 26 May 2010 10:04:11 -0700 (PDT)
In-Reply-To: <4BFD3AAF.4080403@fechner.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147813>

On Wed, May 26, 2010 at 11:13 PM, Matthias Fechner <idefix@fechner.net> wrote:
> For each of this subdirectories I have usergroups defined which has no
> access, read access or rw access.
>
> If I understood the manual correctly I can stick on that structure and
> easily work here with the unix-permission to grant access to the folders?
> I think I have to test then acl with freebsd to have more then one group for
> each directory.

Dealing with acl sounds like a lot of work and complications to me.
Have a look at gitolite. It is covered quite nice in the progit book [1]

> The second question is, I someone commits some files with svn an email is
> sent to a svn-commit mailinglist so changes can easily be discussed.
> The current mail is sent in html format with a colored diff, so it is easier
> to read.
>
> Is something similar possible with git or do you suggest a complete
> approach?

For this you might want to look at Gerrit [2]. It's a web-based code
review. Although it is not email based (AFAIK).

nazri.


[1] http://progit.org/book/ch4-8.html
[2] http://code.google.com/p/gerrit/
