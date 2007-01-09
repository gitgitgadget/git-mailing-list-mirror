From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH] Add contrib/stg-gitk: helper script to run gitk
Date: Tue, 9 Jan 2007 10:02:06 +0000
Message-ID: <b0943d9e0701090202v7951076cg7c86c0f5499c7d60@mail.gmail.com>
References: <20070108220918.18329.30083.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "GIT list" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 09 11:02:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4Do6-0002o2-H2
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 11:02:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbXAIKCL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 05:02:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbXAIKCL
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 05:02:11 -0500
Received: from nz-out-0506.google.com ([64.233.162.235]:7929 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751260AbXAIKCJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 05:02:09 -0500
Received: by nz-out-0506.google.com with SMTP id s1so3952841nze
        for <git@vger.kernel.org>; Tue, 09 Jan 2007 02:02:09 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kd7KRS8f3oQnIrfQZDRljLDDgS6aE04pi3TxIBBTiW+xD+8dZlu02Wl4H6b65fEd6K0jNZjILXK50WgARvV+dD7SLpMhaLTm4Tl4lOnhcWDR1tRNUGRy1auXGF0yUbBk3NQ1bKqRaOPdL2q4KhPmnU8ddJgycA2Mz3Rl/IwCMMI=
Received: by 10.65.188.4 with SMTP id q4mr457066qbp.1168336929169;
        Tue, 09 Jan 2007 02:02:09 -0800 (PST)
Received: by 10.65.133.13 with HTTP; Tue, 9 Jan 2007 02:02:06 -0800 (PST)
To: "Yann Dirson" <ydirson@altern.org>
In-Reply-To: <20070108220918.18329.30083.stgit@gandelf.nowhere.earth>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36337>

On 08/01/07, Yann Dirson <ydirson@altern.org> wrote:
> Here is a small helper script implementing the display of current/named/all
> stgit stacks (or standard branches) in gitk.  As noted earlier, that does not
> allow to see new refs by requesting an update from gitk, but it will still be
> useful to me at least :)

There is 'stg series --graphical' that invokes gitk. Maybe the 'show'
command could have a similar option.

I'm a bit reluctant to these patches. I really don't like mixing
different languages (python and shell script) in the StGIT command
implementations. I agree with some scripts like bash completion and
even a diff-colouring pager but not commands used on a daily basis by
some people (even if only in the contrib directory).

Some of the patches you posted can be implemented in Python as either
new commands or extensions to the current ones (I'll follow up to your
other e-mails).

BTW, I'm happy to create a 'scripts' section on wiki.procode.org where
to add them.

-- 
Catalin
