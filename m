From: "C. E. Ball" <ceball@users.sourceforge.net>
Subject: Re: Interrupted git-svn dcommit, now I get segmentation faults
Date: Fri, 22 Feb 2008 17:20:00 +0800
Message-ID: <4e2a3a120802220120s36fcdd31i9d0a18800d0a0349@mail.gmail.com>
References: <loom.20080221T062522-821@post.gmane.org>
	 <47BDD096.7040606@vilain.net>
	 <4e2a3a120802220113q4df473c0xcaad4760aea7f49b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Sam Vilain" <sam@vilain.net>
X-From: git-owner@vger.kernel.org Fri Feb 22 10:20:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSU5J-00019r-7M
	for gcvg-git-2@gmane.org; Fri, 22 Feb 2008 10:20:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757956AbYBVJUJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2008 04:20:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758707AbYBVJUH
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 04:20:07 -0500
Received: from fg-out-1718.google.com ([72.14.220.153]:24408 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751236AbYBVJUC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2008 04:20:02 -0500
Received: by fg-out-1718.google.com with SMTP id e21so255120fga.17
        for <git@vger.kernel.org>; Fri, 22 Feb 2008 01:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=fvCCg+pQLIOVXpBJTTn7ddF5ih2IUeHpwIaQevlrE+Y=;
        b=k+2n2rBx52SDPBA46N4GwTUrwFlb27XjvK9G7ok1khpB2W7qfhxiQne+Rxe9trdIyVqSzRjcLDhcZLk58Y5SOruLHjIqUcAhMf3fsmchb5HtqFPCLrdqhGc6Thd8YKQZHU0KfP0EAG91FUO8+AcCgLk6fyZYGznHNoPmtLrJ02Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=kfuQDXwqwS0x1G2ZBooL4e0DKFZPPcEa5sdtcmA9MBRltfI+dZh/vP/xLhE2h+auuXlFRPFz1HAjAP0Bmr3idnG3glEAHCVP/F8KqJ0RC/j7vq8bOhB3NV8qUKGaoYqAoq2xQ/VPy98Z9b4snd34DI8PbrEoSbUXhQiRwaQA9kY=
Received: by 10.86.72.15 with SMTP id u15mr10584722fga.11.1203672000426;
        Fri, 22 Feb 2008 01:20:00 -0800 (PST)
Received: by 10.86.79.1 with HTTP; Fri, 22 Feb 2008 01:20:00 -0800 (PST)
In-Reply-To: <4e2a3a120802220113q4df473c0xcaad4760aea7f49b@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: 7da3b5ad7926358b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74709>

On Fri, Feb 22, 2008 at 5:13 PM, C. E. Ball
<ceball@users.sourceforge.net> wrote:
> >  If you get stuff like that you can move the git-svn state out of the
>  >  way, and re-run git-svn fetch; it will rebuild the metadata.
>  >
>  >   $ mv .git/svn .git/svn.bad
>  >   $ git-svn fetch
>  >
>  >  Not a fix I know, but might work for you ;)
>
>  Thank you very much, that did work for me!

Please ignore my previous email - I was in the wrong place on my
filesystem! Sorry about that.

After following your suggestion on my broken repository, I still get
the same error (a segmentation fault just after the commit is
successfully sent to svn) when I 'git-svn dommit'.

Any other suggestions?

Thanks,
Chris
