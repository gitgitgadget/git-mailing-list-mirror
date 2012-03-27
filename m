From: James Pickens <jepicken@gmail.com>
Subject: Re: Bug? Bad permissions in $PATH breaks Git aliases
Date: Tue, 27 Mar 2012 00:37:50 -0700
Message-ID: <CAJMEqRAQZwaeMNai9wckmPE2mRVVpttzEobZrsn29fMAo+LRRQ@mail.gmail.com>
References: <CAJMEqRBmuBJuUmeoAU-_xf=s10ybD9pXhUJT+fn8aHNE2WJz6A@mail.gmail.com>
 <4F715ABD.4080102@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git ML <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Mar 27 09:38:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCQyx-0002dk-J6
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 09:38:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757751Ab2C0HiO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Mar 2012 03:38:14 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:36428 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752999Ab2C0HiL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2012 03:38:11 -0400
Received: by wejx9 with SMTP id x9so4719086wej.19
        for <git@vger.kernel.org>; Tue, 27 Mar 2012 00:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=oEkc6T+nxI6q7WCPWicUswLOhCC8uIYD/DbiWRZ2KQs=;
        b=lE+Yc7450iK6oJNTd0RcEk0ENcfKcGzpwQKT9lkmJU+DXDz/uoQPiM0in6hw+7U7k4
         Lf8HxrmsStchHjQV9fRiLGh9ZC8CVxnxeLPCpBxa13QNbtv0SNUOpKDgCmyumwI5N5WX
         YMw6SYJq0j/mYu8fvgvj7QsHqGQgWPxZjmyCPT+F6RO1gRh7Gp/QE34dA0Md+nKssHbz
         Xh98XLDv8ju0ratqr47t2BeWnJ6BnHz4UVul5Rq27k0Ugs9/KB2vC4YZ0VF6ZLLB0cZL
         cigi+fNgnRept4XEk/iJ7ERPjelEIolsTMbcDDlFjnwhMmvhHNJrWmBI5bvrpazwTnbv
         autA==
Received: by 10.180.79.135 with SMTP id j7mr24846306wix.19.1332833890762; Tue,
 27 Mar 2012 00:38:10 -0700 (PDT)
Received: by 10.223.154.205 with HTTP; Tue, 27 Mar 2012 00:37:50 -0700 (PDT)
In-Reply-To: <4F715ABD.4080102@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194031>

On Mar 26, 2012 at 11:14 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Git is not a shell. And I'm sure it is not the only program that has this
> issue. "Don't do it, then."

I haven't found any other program that has this issue yet.  It seems
like a pretty unique situation, since it's basically a side effect of
Git having aliases with lower precedence than executables.  Most
programs don't have that combination - they either don't have aliases
at all, or their aliases have higher precedence than executables.

> Don't check the
> sanity of your PATH by testing how your shell looks up executables.

I'm not claiming that it's sane to have a broken PATH, but as I
mentioned in an earlier email, sometimes my PATH gets broken through
no fault of my own, and it would be nice if Git could be more helpful
in that case.

James
