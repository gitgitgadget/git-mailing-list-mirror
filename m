From: =?UTF-8?B?0J7Qu9C10LMg0JrQvtGF0YLQtdC90LrQvg==?= 
	<kohtenko@gmail.com>
Subject: Re: git svn die signal 6
Date: Fri, 19 Jun 2015 11:42:08 +0300
Message-ID: <CACbO7BMdEY66RxzEnq8+TduG3nC1HiyX7y6_PLzb12K=oJx+zw@mail.gmail.com>
References: <CACbO7BMtsgu2eJHa4NBmeZ2-mTDk23NZhhf5f7MM7+_1X5+zsw@mail.gmail.com>
	<CACbO7BMfDSqTAzNWKhLqgP+eTmsnFTmyDjt7WoZ7nMdJfp-sCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 19 10:42:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5rsM-0007Bb-Ss
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 10:42:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753863AbbFSImK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Jun 2015 04:42:10 -0400
Received: from mail-oi0-f48.google.com ([209.85.218.48]:36578 "EHLO
	mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754025AbbFSImI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Jun 2015 04:42:08 -0400
Received: by oigb199 with SMTP id b199so33753839oig.3
        for <git@vger.kernel.org>; Fri, 19 Jun 2015 01:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=ZEQtajXWPK2Ot1MXyIAHnnKnvLn4CesrHh1LdXGQpmE=;
        b=GNTSZyqLotrh8qocZwOKxaToZJhaO1G8MOv2dkTYZ2cC0FMouCIfwHHGWseR463jtS
         HBrfN12gkkSGKDavTxrGYyV+ab4RL7EjeNWGBWWd5rW1J/rZfsofIe5QFQ8mHpqAYRAA
         Uj2CT8aF6t2UmXir6qh7822omb/+E7d5bGRbzd02qW5eml+9NxdBhBP48ywnMRyJdLJV
         +FctrYCND6k7I9n+I9mD9eljQJ6dDVdlc/3w5ccykUo5gLSDoO/8QaHPlbtsyGC95kb4
         G6sIpUnaQUnd9tn+jWWBmLActg940s81Lq/1PQUkM6yQBopiwGLWuQbpM+jvAHlfxKSC
         A3ZA==
X-Received: by 10.60.52.174 with SMTP id u14mr12951048oeo.9.1434703328190;
 Fri, 19 Jun 2015 01:42:08 -0700 (PDT)
Received: by 10.76.41.202 with HTTP; Fri, 19 Jun 2015 01:42:08 -0700 (PDT)
In-Reply-To: <CACbO7BMfDSqTAzNWKhLqgP+eTmsnFTmyDjt7WoZ7nMdJfp-sCg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272109>

I even found Pull Request on GitHub with useful changes, but looks
like there is too hard way to commit changes and author gave up.
https://github.com/git/git/pull/62 Probably you can take a short look
into it and include this changes in next release.

2015-06-15 16:54 GMT+03:00 =D0=9E=D0=BB=D0=B5=D0=B3 =D0=9A=D0=BE=D1=85=D1=
=82=D0=B5=D0=BD=D0=BA=D0=BE <kohtenko@gmail.com>:
> Hi great "git crew" member :)
> I found small, but annoying bug in 'git svn'. If you would try to mak=
e
> any commit with new files (or delete/modify files) which contain in
> name "@" sign - you'll see crash with minimum information about what'=
s
> just happened. Such file names are very useful for iOS projects when
> you can add same pictures with different dimensions with suffix @2x o=
r
> @3x. In guts, svn uses "@" sign for pin version of file and it's
> probably confused if this sign presented in file name. For committing
> such changes thru svn you would use "svn add 'image@3x.png'@". This
> will prevent such problem.
>
> I hope you can easily find out how to reproduce and fix this issue.
> Please, feel free to contact me for any details about this.
>
> Best regards
