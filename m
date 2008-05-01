From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: Files need updating following a clone?
Date: Wed, 30 Apr 2008 21:07:12 -0400
Message-ID: <32541b130804301807i2e88170dj1fcbf3cec769b69d@mail.gmail.com>
References: <65e5553a-a630-4b1a-9c81-f0ed7d9d7361@c19g2000prf.googlegroups.com>
	 <1c5969370804301732i282064f7r55858d54a6796791@mail.gmail.com>
	 <eb5498bc-9169-4f03-a725-f8ff98f9b39a@x19g2000prg.googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: edpark <edpark@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 01 03:08:10 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrNHI-0000SW-L2
	for gcvg-git-2@gmane.org; Thu, 01 May 2008 03:08:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995AbYEABHQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2008 21:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751016AbYEABHQ
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 21:07:16 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:28870 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750995AbYEABHO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 21:07:14 -0400
Received: by fg-out-1718.google.com with SMTP id 19so353215fgg.17
        for <git@vger.kernel.org>; Wed, 30 Apr 2008 18:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ouCIlfxNy2KaWduefzWqk77B5JfvK7A+QEutiCikRRA=;
        b=eXE7hkqtNyXK3AjfOr8u+a4ZKJXVZ1+8FMyMIJWWHoqRIGJrPAYV0OWattHcQGKDC5jwS3GioNoJxRhvz/jPFmCkGpEKI7DopoQZNsKKoevLrxSACWydEeH/1H7OqCYnGJtP0xbR7mjZPmRiv+mAhC8FHXZUc3S/xPo6/v1Kog0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=vXEhfJVjT0QcmsOR/MqNzu3ws6K1nMDq+CG8CLkTHnDpe6JCzRSwP8EHM4xOa7qAnbB4rLsPzjUd89A26hm6FfNhLJhJRGjxoRYkFL8osbNMfCwwQFxFMUzTI0YFdTRzt0xoj+6gyvCDXaUCF54F6aAQCFgJxueZqqX332e96Ao=
Received: by 10.82.135.7 with SMTP id i7mr197853bud.42.1209604032549;
        Wed, 30 Apr 2008 18:07:12 -0700 (PDT)
Received: by 10.82.166.12 with HTTP; Wed, 30 Apr 2008 18:07:12 -0700 (PDT)
In-Reply-To: <eb5498bc-9169-4f03-a725-f8ff98f9b39a@x19g2000prg.googlegroups.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80885>

On 4/30/08, edpark <edpark@gmail.com> wrote:
> Hi Matt, thanks for pointing that out.
>  Yes, it turns out that we are using different systems.  The original
>  commit (to Github.com) was on a Mac but then there were a few commits
>  made from a Windows based system (through Parallels).
>  It's only on a windows based system that Git will claim that files
>  need to be updated; this doesn't happen on a Mac.
>  Hope this helps someone figure out what's going on ..

You probably have files checked into your tree with windows-style CRLF
instead of unix-style LF line endings, and git for Windows nowadays
has "git config --global core.autocrlf true" set.

If you configure your windows autocrlf setting to false, this
particular symptom will go away, but you probably want to actually fix
the files in the repo so they don't have CRLF problems.  You might be
able to do that just by doing "git commit -a".

Good luck,

Avery
