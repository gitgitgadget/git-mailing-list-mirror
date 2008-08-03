From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [ANNOUNCE] TopGit - A different patch queue manager
Date: Sun, 3 Aug 2008 10:45:06 -0400
Message-ID: <9e4733910808030745j275eaffdib8a412fa95911bb3@mail.gmail.com>
References: <20080803031424.GV32184@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sun Aug 03 16:46:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPeqb-00035M-Tu
	for gcvg-git-2@gmane.org; Sun, 03 Aug 2008 16:46:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756114AbYHCOpK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 10:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755852AbYHCOpJ
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 10:45:09 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:4899 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755711AbYHCOpH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 10:45:07 -0400
Received: by py-out-1112.google.com with SMTP id p76so904254pyb.10
        for <git@vger.kernel.org>; Sun, 03 Aug 2008 07:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=hheS4O/c+oOSdFN5LdCdOAhJX8g9lO+YNUD+2S6zqoc=;
        b=LFvTCeBuz0CjPghcTDDQ+BkHE0+P7JviM0jDkSA24f4Ja3Jtlw5GpgdETi4W4Te3sV
         koJJSM1Q8kNqjc4HJsJmooe/4znrOTKhSfAwt0RY7mmYsjXi/k2lZR2g1semQWtk2l7e
         083p/sGMsEWNsd43hZwIMriynV5Xq0I1YBUyI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=UYto1LAJ1+jf3rkN8Fc8eTGtI+WCDHi2eDBDZaRjhuaK3FH0l583Uv/Bli4pBg90aA
         OpJeqlcOxf/ZQJaw7AJxER8I+IfnB4YCvo6BDro2O0ZXvKd7xqZnPWW61EYpUgYMQ0by
         AKF3xp+TMsBldKwlxwxvSQgqTJ5t6YQgGYQ3c=
Received: by 10.64.253.11 with SMTP id a11mr514135qbi.37.1217774706358;
        Sun, 03 Aug 2008 07:45:06 -0700 (PDT)
Received: by 10.65.214.7 with HTTP; Sun, 3 Aug 2008 07:45:06 -0700 (PDT)
In-Reply-To: <20080803031424.GV32184@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91248>

On 8/2/08, Petr Baudis <pasky@suse.cz> wrote:
>   TopGit is meant as a fresh start in the steps of StGIT, quilt-in-git
>  and others, of course in an attempt to Get It Right this time around.
>  TopGit is absolutely minimal porcelain layer that will manage your
>  patch queue for you using topic branches, one patch per branch.
>  And do _ONLY_ that. Unlike with StGIT, you can actually use the index.

It is very helpful to block git commands that will mess up the state
of topgit. For example 'git rebase' is a good way to mess up stgit.
Instead you need to do 'stg rebase'. It is quite easy to type the
wrong command when switching between trees and some are under stgit
and others aren't.

I believe there is a stgit rewrite due any day now that completely
changes how it deals with the index.

-- 
Jon Smirl
jonsmirl@gmail.com
