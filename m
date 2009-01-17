From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: git-svn fails to fetch repository
Date: Sat, 17 Jan 2009 12:33:05 -0500
Message-ID: <76718490901170933r5d325a9fud8a0f148e972f9a8@mail.gmail.com>
References: <loom.20090113T204616-845@post.gmane.org>
	 <loom.20090113T211437-12@post.gmane.org>
	 <76718490901131328x5ec30805u3cae29132defd695@mail.gmail.com>
	 <loom.20090113T213400-985@post.gmane.org>
	 <76718490901131658l108852f2y9a25eb9133d6e96d@mail.gmail.com>
	 <loom.20090114T083207-942@post.gmane.org>
	 <76718490901141006n6c70eb2cw67ad814b3739786e@mail.gmail.com>
	 <20090117095147.GA29598@dcvr.yhbt.net>
	 <E3BA9CAD-B3CD-4050-8493-7C4024AD4529@gmail.com>
	 <20090117104558.GC29598@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Vladimir Pouzanov" <farcaller@gmail.com>, git@vger.kernel.org
To: "Eric Wong" <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Jan 17 18:35:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOF4x-0005JF-7o
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 18:35:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757584AbZAQRdL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 12:33:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757053AbZAQRdJ
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 12:33:09 -0500
Received: from rv-out-0506.google.com ([209.85.198.237]:33457 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752942AbZAQRdI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 12:33:08 -0500
Received: by rv-out-0506.google.com with SMTP id k40so2026608rvb.1
        for <git@vger.kernel.org>; Sat, 17 Jan 2009 09:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=iJ9CHp2YWyQmK9zKUYWSEwbLO2EZEXQNQIiKxDBmezI=;
        b=D6MZFJYO1t8Qz+3ENFlXxaXsVdAC+qruFWTr6hv1FFqL2T+nw8mkpqfEyZCnbLZEdc
         tNup/Ux8VErdKrqZ/lU/B69gGRrxJtz0nGebYkBnNptzAXJeyJMXW9TjSAQoNjZRpox1
         6QjjxwQyRG3iTST+nBEKtVNgZjJJnU2u0aaXo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=RXyf/DnT7Ope6Jr4goOQMjvOlT/T0EmsaAGvcG5GAu6mAhLuIrZ+SKkFBuVfZeOAlS
         6ZBC6kChxi+CU0TCFOZJgFMFWRgdNvbfeWR8JHe8s87NdkJho6bNCMTbggGsRbjR2leW
         1r7Dp5iYa32RIiA8/r6VKo6S3dKmF0VvoqJ9o=
Received: by 10.140.139.4 with SMTP id m4mr944282rvd.68.1232213585850;
        Sat, 17 Jan 2009 09:33:05 -0800 (PST)
Received: by 10.140.204.11 with HTTP; Sat, 17 Jan 2009 09:33:05 -0800 (PST)
In-Reply-To: <20090117104558.GC29598@dcvr.yhbt.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106088>

On Sat, Jan 17, 2009 at 5:45 AM, Eric Wong <normalperson@yhbt.net> wrote:
> At least you got a working combination working.  Does anybody know if
> macports git have any patches/changes to it that could cause this?

I installed the macports git and it worked fine for me. Same versions
of git and subversion. The only difference was that I was on macports
perl 5.8.9 and Vladimir was on macports perl 5.8.8.

If I have time, I'll try it with macports perl 5.8.8 and see if I can
reproduce. I'm pretty curious why the apply_textdelta() callback is
apparently running twice on the same file w/o the intervening close.
:-)

j.
