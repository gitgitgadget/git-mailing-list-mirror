From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: The big git command renaming..
Date: Fri, 29 Apr 2005 14:58:29 -0700
Message-ID: <4272AE05.2070202@zytor.com>
References: <Pine.LNX.4.58.0504291416190.18901@ppc970.osdl.org> <20050429213540.GA1691@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 29 23:54:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRdQ6-00007X-Mp
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 23:53:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263011AbVD2V6y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 17:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263016AbVD2V6y
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 17:58:54 -0400
Received: from terminus.zytor.com ([209.128.68.124]:63420 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S263011AbVD2V6v
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2005 17:58:51 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j3TLwYTZ015806
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 29 Apr 2005 14:58:35 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Dave Jones <davej@redhat.com>
In-Reply-To: <20050429213540.GA1691@redhat.com>
X-Spam-Status: No, score=-5.9 required=5.0 tests=ALL_TRUSTED,BAYES_00 
	autolearn=ham version=3.0.2
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dave Jones wrote:
> On Fri, Apr 29, 2005 at 02:24:43PM -0700, Linus Torvalds wrote:
>  > 
>  > Ok, I hate to do this, since my fingers have already gotten used to the 
>  > old names, but we clearly can't continue to use command names like 
>  > "update-cache" or "read-tree" that are totally non-git-specific.
>  > 
>  > So I just pushed out a change that renames the commands to always have a 
>  > "git-" prefix. In addition, I renamed "show-diff" to "diff-files", with 
>  > together with the prefix means that it becomes "git-diff-files" when used.
>  > 
>  > Since I end up using tab-completion for almost all my work, and since
>  > -within- the source directory there's no confusion, I didn't actually name
>  > the source files with any git- prefix. Quite the reverse: I removed the
>  > prefix from the two .c files that already had it (so git-mktag.c is now
>  > just "mktag.c"), and the general rule for building the executable from a C 
>  > file is now
>  > 
>  > 	git-%: %.c $(LIB_FILE)
>  > 		$(CC) $(CFLAGS) -o $@ $(filter %.c,$^) $(LIBS)
>  > 
>  > 
>  > this seemed to be a nice regular interface that means that binaries get 
>  > installed with clear "git-" prefixes, but that I don't have to look at 
>  > them when I edit the sources.
> 
> Can you push out a new tarball to kernel.org too please, to kill
> some potential confusion in documentation/scripts ?

Oh yes, and can that tarball please be put in /pub/software/scm/git, and 
the associated git tree be moved to /pub/scm/git?

	-hpa
