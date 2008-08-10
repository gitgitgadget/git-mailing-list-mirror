From: "David Neu" <david@davidneu.com>
Subject: Re: Converting from svn to git
Date: Sun, 10 Aug 2008 11:48:03 -0400
Message-ID: <e0b44a890808100848p367f5c66qfa21cba1b3ba12a0@mail.gmail.com>
References: <e0b44a890808100611t27ddfcb6v21eecea89484c90b@mail.gmail.com>
	 <20080810132409.GE18960@genesis.frugalware.org>
	 <e0b44a890808100754l536bc4f3kfd953b52044f6e59@mail.gmail.com>
	 <g7n1mk$67t$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Michael J Gruber" <michaeljgruber+gmane@fastmail.fm>
X-From: git-owner@vger.kernel.org Sun Aug 10 17:49:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSDAN-0005x3-5g
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 17:49:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754085AbYHJPsH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 11:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753584AbYHJPsG
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 11:48:06 -0400
Received: from wx-out-0506.google.com ([66.249.82.226]:52016 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753109AbYHJPsE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 11:48:04 -0400
Received: by wx-out-0506.google.com with SMTP id h29so999574wxd.4
        for <git@vger.kernel.org>; Sun, 10 Aug 2008 08:48:03 -0700 (PDT)
Received: by 10.70.75.20 with SMTP id x20mr7477908wxa.29.1218383283150;
        Sun, 10 Aug 2008 08:48:03 -0700 (PDT)
Received: by 10.70.53.6 with HTTP; Sun, 10 Aug 2008 08:48:03 -0700 (PDT)
In-Reply-To: <g7n1mk$67t$1@ger.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91849>

That's great - thanks to everyone!

On Sun, Aug 10, 2008 at 11:32 AM, Michael J Gruber
<michaeljgruber+gmane@fastmail.fm> wrote:
> David Neu venit, vidit, dixit 10.08.2008 16:54:
>>
>> Thanks for the reply - this looks like what I'd need, but
>> I can't see how to keep the contents of the base dir and
>> lose the subdirs, e.g.
>>
>> $ git-filter-branch --subdirectory-filter . HEAD
>>
>> removes all subdirs and the contents of the base dir.
>>
>> So, I figure I'd remove each subdir, using
>>
>> $ git-filter-branch --tree-filter 'rm -rf subdir1/' HEAD
>>
>> but this complains if subdir1 contains subdirectories, it
>> says: Namespace refs/original/ not empty
>
> It complains because filter-branch stores the original refs in that
> namespace, and on the second filter-branch run it wants to do this again.
> You can avoid this by using the "-f" option to filter-branch, or by removing
> all subsirs in one go ("rm -rf subdir1 subdir2..."). Also, you might want to
> rewrite all refs ("--all"), not just HEAD.
>
> Michael
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
