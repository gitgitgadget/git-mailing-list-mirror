From: Chris Packham <judge.packham@gmail.com>
Subject: Re: gitk: Removing Stacked Git branches from the --all view
Date: Wed, 18 Aug 2010 09:23:29 -0700
Message-ID: <4C6C0901.4090702@gmail.com>
References: <4C6A25E5.5050707@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Wed Aug 18 18:23:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OllQO-00032P-GQ
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 18:23:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793Ab0HRQXb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Aug 2010 12:23:31 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:51988 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750805Ab0HRQX3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Aug 2010 12:23:29 -0400
Received: by pvg2 with SMTP id 2so290600pvg.19
        for <git@vger.kernel.org>; Wed, 18 Aug 2010 09:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=Q8m2x9pgSaOXhuqwjZoqeY4WCDbpacWOTZEfQlAYQAY=;
        b=sFXJzhfMT6uEl1hKLzHQo0yNR8aXHVGxC2VSAlOMH1SenUgv4pvXUbuy+dx7pMNrBc
         573tGeJfVDGNXAOkyEgCLydZfDRLnx8Bl+JrMG0g1D7GvBuk1zLwmRK2Tiub7YMmuAy6
         l/BJp6CcEXzLYIR9Qs1O7tbVPngROwsWIGQ0g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=hlzWorAx6ZQpckSt9vM+otuvxPieswfB+yonuge9ZyZ4KoBjTd0SMP3gQdhStFwXmw
         ObIGk7KLPfTTWSyZOoQQmA5HdVzzVdrc7LOGDfcJkx0lytuudylhTt0zfz8hzMiOvuPL
         elEwwIyl+etc+rS8kc4qT+WhTrdVmLopSBUWI=
Received: by 10.114.120.7 with SMTP id s7mr9832500wac.131.1282148608873;
        Wed, 18 Aug 2010 09:23:28 -0700 (PDT)
Received: from laptop.site (209-234-175-66.static.twtelecom.net [209.234.175.66])
        by mx.google.com with ESMTPS id g4sm777592wae.2.2010.08.18.09.23.26
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 18 Aug 2010 09:23:27 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.9.1.11) Gecko/20100714 SUSE/3.0.6 Thunderbird/3.0.6
In-Reply-To: <4C6A25E5.5050707@workspacewhiz.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153867>

On 16/08/10 23:02, Joshua Jensen wrote:
>  I often run 'gitk --all'.  It works great until I introduce Stacked Git
> into the equation.  StGit uses branches called branchname.stgit for
> various metadata.  The metadata turns into an ugly mess with gitk --all.
> 
> I've been playing around with various 'git log' options, but I'm not
> finding one that gives me the gitk --all view as if StGit were never
> attached to the repository.  (Speaking of StGit and apps that store
> metadata in branches... it would be awesome to have a filter that knocks
> those branches out of ALL views of the data.)
> 
> Would someone mind helping me out?
> 
> Thanks.
> 
> Josh

One thing I found was 'stg log --clear' (I'm running a newish version
direct from the stgit repo but I think it should be there in stgit
0.15). It gets rid of a lot (but not all) of the extra objects that
pollute the 'gitk --all' output.

One word of caution is that the Stack Git log has saved me from losing
work when I've done something bone headed so I tend to clear the log
only when I'm sure I've got everything I need committed upstream.
