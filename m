From: Panagiotis Issaris <takis@lumumba.uhasselt.be>
Subject: Re: Problem using GIT CVS-server
Date: Wed, 03 May 2006 13:36:12 +0200
Message-ID: <445895AC.6070109@lumumba.uhasselt.be>
References: <445865A5.5030700@lumumba.uhasselt.be>	 <46a038f90605030311s4e05de2dr90277f97a3a5c223@mail.gmail.com> <46a038f90605030411o29af1d1bra3276353347516f6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 03 13:36:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbFf2-0008CU-18
	for gcvg-git@gmane.org; Wed, 03 May 2006 13:36:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965152AbWECLgO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 May 2006 07:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965156AbWECLgO
	(ORCPT <rfc822;git-outgoing>); Wed, 3 May 2006 07:36:14 -0400
Received: from alpha.uhasselt.be ([193.190.2.30]:25325 "EHLO alpha.uhasselt.be")
	by vger.kernel.org with ESMTP id S965152AbWECLgN (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 May 2006 07:36:13 -0400
Received: from localhost (datastorage.uhasselt.be [193.190.2.17])
	by alpha.uhasselt.be (Postfix) with ESMTP id 152D71AB171;
	Wed,  3 May 2006 13:36:12 +0200 (CEST)
X-Virus-Scanned: by Amavisd antivirus & antispam cluster at uhasselt.be
Received: from [172.18.16.239] (edm-006.edm.uhasselt.be [193.190.10.6])
	by alpha.uhasselt.be (Postfix) with ESMTP id 67C3B1AB137;
	Wed,  3 May 2006 13:36:11 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90605030411o29af1d1bra3276353347516f6@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19471>

Hi,

Martin Langhoff wrote:

> On 5/3/06, Martin Langhoff <martin.langhoff@gmail.com> wrote:
>
>> Hmmm. 100% reproduceable -- looking at it now.
>
>
> Grumble. Some recent change has broken cvsserver -- if I rewind to the
> commit I made of cvsserver, the checkout works correctly. I suspect
> changes to git-diff-tree. However, I'll play dumb and try bisect to
> see where it leads...
>
> (Nice thing about bisecting with C code is that as you get closer the
> delta is smaller, and the recompile is smaller too ;-)
>
> Ok -- an hour's gone by and I'm still fidgeting with bisect. It seems
> to have been broken soon after v1.3.0 but I'm having trouble nailing
> the commit, and understanding WRF has changed.
>
> Can you test with git v1.3.0?

Yes, I installed 1.3.0 using "make prefix=/tmp/testje install"
but, I'm getting the same problem (other then my failing typing
skills ;-) :

takis@issaris:/tmp/a/c$ export PATH=/tmp/testje/bin/:$PATH
takis@issaris:/tmp/a/c$ git --version
git version 1.3.0
takis@issaris:/tmp/a/c$ cvs co -d project-master master
takis@localhost's password:
Permission denied, please try again.
takis@localhost's password:
Permission denied, please try again.
takis@localhost's password:
cvs checkout: Updating project-master
U project-master/Makefile
U project-master/README
U project-master/cache.h
U project-master/cat-file.c
U project-master/commit-tree.c
U project-master/init-db.c
U project-master/read-cache.c
U project-master/read-tree.c
U project-master/show-diff.c
U project-master/update-cache.c
U project-master/write-tree.c
closing dbh with active statement handles
takis@issaris:/tmp/a/c$ which git
/tmp/testje/bin//git


With friendly regards,
Takis
