From: Christopher Tiwald <christiwald@gmail.com>
Subject: Re: non-fast-forward advice breaks tests on OS X
Date: Thu, 12 Apr 2012 09:37:01 -0400
Message-ID: <20120412133701.GA367@gmail.com>
References: <9F768A58-DEB0-43E1-8AE4-B2A5C4E6CDE9@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Brian Gernhardt <brian@silverinsanity.com>
X-From: git-owner@vger.kernel.org Thu Apr 12 15:37:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIKD5-0000Nj-7N
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 15:37:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934277Ab2DLNhH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Apr 2012 09:37:07 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:47106 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934206Ab2DLNhG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2012 09:37:06 -0400
Received: by qcro28 with SMTP id o28so1213598qcr.19
        for <git@vger.kernel.org>; Thu, 12 Apr 2012 06:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=b3HB7mURToeFpIN5HuwJYMJrTwcvxdzoYOb6hDlMVMU=;
        b=Io1ynn6MpvJvXMrcvrMvImdJM2emtEANchuaq2amov5121TpdFNKvrqT0qB5nYSU/Z
         u41S3eBRqgX1iTIO4bPbnvyIAb04e9+PhQ6e6FHt1mjxQ1KeObVWcSe/K0M80mXC2TR6
         z4yN20ldjtkue8IzO/CBhLE3efaCiYnFSTslQF1+FVc68/Nub+wKa7EPPCd2A0UBNQQI
         uhU3h8cFGjDqX0Oz64LwcA6Yf+baLSDr5JC1kdBMe3/ACLQCnG9VKl/N7FuWWqs4TkbW
         tXRGWKYe0YBokBFZO9nf9+NBwhT05j07v8J9iHesMz/m7o8t/eACCE7QYAOnKKATup7V
         9cPg==
Received: by 10.229.135.16 with SMTP id l16mr1011702qct.28.1334237825293;
        Thu, 12 Apr 2012 06:37:05 -0700 (PDT)
Received: from gmail.com ([216.55.38.246])
        by mx.google.com with ESMTPS id ew2sm11752012qab.11.2012.04.12.06.37.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 12 Apr 2012 06:37:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <9F768A58-DEB0-43E1-8AE4-B2A5C4E6CDE9@silverinsanity.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195327>

On Thu, Apr 12, 2012 at 01:49:14AM -0400, Brian Gernhardt wrote:
> After a break in regularly compiling git on my Mac 10.7.3 laptop, I had a few tests fail:  t5540.15, t5541.{12,15}.  All of these tests use test_i18ngrep to test the output of git-push for the string "To prevent you from losing history, non-fast-forward updates were rejected".
> 
> Bisecting traced it back to f25950f: "push: Provide situational hints for non-fast-forward errors".

I also run 10.7.3 on a MacBook Pro. I will investigate this now and see
if I can get tests to break. I know the original patch passed the test
suite on this machine.

--
Christopher Tiwald
