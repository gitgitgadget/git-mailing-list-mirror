From: Adam Brewster <adambrewster@gmail.com>
Subject: Re: Pulling one commit at a time.
Date: Sun, 23 Aug 2009 16:17:07 -0400
Message-ID: <c376da900908231317j58e31f78l85bf9132d5bd0e1e@mail.gmail.com>
References: <F536B7C316F9474E9F7091239725AC9A02FA7F44@CHN-CL-MAIL01.mchp-main.com>
	 <4A9172D0.6030507@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sanjiv Gupta <sanjiv.gupta@microchip.com>
X-From: git-owner@vger.kernel.org Sun Aug 23 22:18:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfJVx-0005pB-Ql
	for gcvg-git-2@lo.gmane.org; Sun, 23 Aug 2009 22:18:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934087AbZHWURJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Aug 2009 16:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934061AbZHWURJ
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Aug 2009 16:17:09 -0400
Received: from mail-ew0-f207.google.com ([209.85.219.207]:46537 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934069AbZHWURI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Aug 2009 16:17:08 -0400
Received: by ewy3 with SMTP id 3so1878189ewy.18
        for <git@vger.kernel.org>; Sun, 23 Aug 2009 13:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zd5NOX/BWZfusUiDhCln//CB7APX1jA/j+5wMbzmsow=;
        b=CO+h7x35hgvjO7XvHQyaZCgvxZFI3UzcmPO4NXPQ7S4pfYY7dNsM+84u4iQUvEE1WF
         nmY8xaqU0mBMOKwSdemzKKbFUkKKX5jnwnPVpMhOGb6c2N1PwGuFQhYUEO5yGHnkKC2n
         T8Hc5MRnuyKGRfrMUf9XSBHFOzRdUqrlkziNg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=COCmi04aI3qieTPzqUJ3A+4QGUZ3oyKD/mqX00dm7IKeGExPNkJMcnGAxPmgfRG0iA
         Fb/aEjaFzmLOw1ly2wkbmmHO0O51ChY43xJAqRo72aN5xOyOh84IhpV49JxoNUBw5JXk
         k/wiHT5MKdJhJHD8rOPU/SCrVHHXxkAyImcKQ=
Received: by 10.216.8.213 with SMTP id 63mr782338wer.161.1251058627997; Sun, 
	23 Aug 2009 13:17:07 -0700 (PDT)
In-Reply-To: <4A9172D0.6030507@microchip.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126871>

On Sun, Aug 23, 2009 at 12:48 PM, Sanjiv
Gupta<sanjiv.gupta@microchip.com> wrote:
> Hi,
> This is my first post here.
> I just wanted to know how can I pull one commit at a time from public
> repository.
> e.g.
> when I first cloned from the public repo, it was at X. now it has reached Y.
> I just want to pull x+1.
>
> how to do that?
>
> In SVN, we can just do $ svn update -r next_rev_num
>

Git is a distributed system and handles branching much differently
than svn, so pull x+1 sounds like a funny request to git.

You could use `git fetch` to get the history from the remote
repository, then use `git log` or `gitk` to find the name of the
commit you're interested in, and use `git checkout` to switch to that
branch or `git merge` to merge the changes from the next commit into
your current branch.

Perhaps it would help if we knew why you only wanted to fetch one
commit at a time.

Adam
