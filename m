From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: Feature Request: add a --current option to git branch
Date: Wed, 23 Feb 2011 14:32:07 -0500
Message-ID: <AANLkTikecya+o+rLVHJARv06mCtEv-Ef1nRECQH0saLr@mail.gmail.com>
References: <AANLkTimDE18XK8NOg++pxqs5LCJZ4m67Ygo4JvYDbw+F@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: John Jendro <tacliat@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 23 20:32:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsKS3-0006FX-2Y
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 20:32:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932401Ab1BWTci (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Feb 2011 14:32:38 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:52520 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932317Ab1BWTch (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Feb 2011 14:32:37 -0500
Received: by iyb26 with SMTP id 26so2992954iyb.19
        for <git@vger.kernel.org>; Wed, 23 Feb 2011 11:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=UWj6kghUr+zSZvrtaHwrPOfYuD3y7BVmz0xWPR2Hm9Q=;
        b=VYo1m8VEFZpjOaT/Qxsfai7mKsdiJ7XjXbBdFtgxofNBooo+7S7B/r+J3W3nxILzVA
         1EarwuU4aA7rHl3sAxSrQTtfwPpGjchPwBb6N70m7AsD/y16EUH0fPLdRKKV2Q9LPxnB
         brP61zqYqH1GiKYArcISbSckR/iPLrU4IhEbk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=kK2aoP7cwk0906JaohYWF2Xz7iN+897Rzm0sxUkqb5APsV85xOBs7wonqCxf/vB1OD
         lDYPx2H9aIprrE+x0ukdlEQmTUEZ0D6aI4TK4UowWaWPrZeVFnI/gjFYt07H3VbNuNWN
         ajpq+9WQjkCJFUX1JN34IMIw2C6Fsk77+PVe4=
Received: by 10.231.37.138 with SMTP id x10mr3447082ibd.192.1298489557102;
 Wed, 23 Feb 2011 11:32:37 -0800 (PST)
Received: by 10.231.40.2 with HTTP; Wed, 23 Feb 2011 11:32:07 -0800 (PST)
In-Reply-To: <AANLkTimDE18XK8NOg++pxqs5LCJZ4m67Ygo4JvYDbw+F@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167717>

On Wed, Feb 23, 2011 at 2:08 PM, John Jendro <tacliat@gmail.com> wrote:
> Yes I know this can be done with sed & grep, but --current should be a
> standard thing for git branch to have.

I sense you're looking to get the name of the currently checked out
branch, possibly for use in a script. In that case, you may want "git
rev-parse --abbrev-ref HEAD" or "git rev-parse --symbolic-full-name
HEAD" depending upon what you're trying to do.

j.
