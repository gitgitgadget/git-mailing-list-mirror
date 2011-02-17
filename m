From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: git merge auto-commit doesn't fire pre-commit hook
Date: Wed, 16 Feb 2011 23:52:47 -0500
Message-ID: <AANLkTim+_s5S46QwhHLquMLsoqCwLASdyeW1Lu6md=TB@mail.gmail.com>
References: <1F3B7FF9-6348-4197-A6B7-23C4DA144920@adscale.co.nz>
 <AANLkTimCdQL879kBZiktB49eSvoAGT0pX5DKX0SHFOVB@mail.gmail.com> <6F190320-19AF-4F4A-9AE9-0DDA0839C5FD@adscale.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Liam Clarke <liam.clarke-hutchinson@adscale.co.nz>
X-From: git-owner@vger.kernel.org Thu Feb 17 05:53:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ppvrn-0005J9-8i
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 05:53:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754747Ab1BQExT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Feb 2011 23:53:19 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:48089 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752651Ab1BQExS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Feb 2011 23:53:18 -0500
Received: by iwn9 with SMTP id 9so2089292iwn.19
        for <git@vger.kernel.org>; Wed, 16 Feb 2011 20:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=KaTqT5XNYhuxPnuiJ5Xl7wMJWmWbOTS0Lz8XH1Hz1yQ=;
        b=MCOl++83R3q/64wdlR3GJGoxXIFKCu9EFu6RRhP0HI/vvArffBtYOcprtEn3UdC0Vu
         t3XCdqf5PMVWZoxOFWvjzHySzXSCgIN08MMM6SAg8rKOOBQXHre8wbWWXEeNObTRkeKK
         FR3H9VnwoKNZIEGQmTRe7N5spE+mazw4o3HKM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=i5YJiz9ag84GCHw8szhsHHgZHNXIFQ/w/MsxX7LkgC4GHFOw1Y1+3Jwjn8WHgQteUJ
         w98VTlNokzlhP6MyAcDnizrkgkXilylDqNIJfjYG7+HPoGizGUfN+QmR6FfGUZLEtAvy
         tWBOSyeiiC/QGnBUK58R7FC8L0YTAvCapl8Wo=
Received: by 10.231.38.2 with SMTP id z2mr1188532ibd.142.1297918397770; Wed,
 16 Feb 2011 20:53:17 -0800 (PST)
Received: by 10.231.40.2 with HTTP; Wed, 16 Feb 2011 20:52:47 -0800 (PST)
In-Reply-To: <6F190320-19AF-4F4A-9AE9-0DDA0839C5FD@adscale.co.nz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167039>

On Wed, Feb 16, 2011 at 11:44 PM, Liam Clarke
<liam.clarke-hutchinson@adscale.co.nz> wrote:
> What about when I'm merging my own feature branches into master? Also, past performance indicates that yelling about bad stuff in merges works quite well when they're in the same office as you...

BTW, why not just use the post-merge hook to amend the merge after the fact?

j.
