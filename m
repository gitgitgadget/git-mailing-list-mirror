From: "David Syzdek" <syzdek@gmail.com>
Subject: Re: What's cooking in git.git (Nov 2008, #01; Sun, 02)
Date: Sun, 2 Nov 2008 14:13:35 -0900
Message-ID: <9a0027270811021513h2739c825o8f989a614a11f69@mail.gmail.com>
References: <7vbpwx3j7q.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"David M. Syzdek" <david.syzdek@acsalaska.net>, pasky@suse.cz
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 03 00:14:53 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kwm9j-0007Hr-Qf
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 00:14:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753615AbYKBXNh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2008 18:13:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753596AbYKBXNh
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 18:13:37 -0500
Received: from rv-out-0506.google.com ([209.85.198.236]:51609 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753447AbYKBXNg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Nov 2008 18:13:36 -0500
Received: by rv-out-0506.google.com with SMTP id k40so2270253rvb.1
        for <git@vger.kernel.org>; Sun, 02 Nov 2008 15:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=emIWN2ujqFs0DjmWh3+lvqNcTpSLpbSdOISTSWlPSss=;
        b=bvv4dmbRMHbAeh8a8GSDOPrW9xiW5tOWfcru8mfTeaCwXSukuA5KUprW1YQerBgfrN
         89ZPQqLbj1TzGUUmOS6Fz74AqkR777b/Ujb5MWfKZHMy0oMCq0IXKHAJw1QVvRSPOO9n
         bzvMvCIS0/CKo4ZK0jWfWvaM/fX3iEGNGaWPI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=DkIDKkgyoaez93ZyG+gZLDfG55JnCtcj+/nN2jBeWuFjCbh395S+o35zrX9wAB6JKd
         UmORbCTd8L7P/TRY1/4b5SYocAGZYP6fqs1AADf4EJSrKRSac5wAo2rC9BNV/Qfo0Jp9
         uZgLdlgu6f/HJFwhSjZbzLnTwdg05fVhyxMzI=
Received: by 10.141.50.11 with SMTP id c11mr8479382rvk.222.1225667615724;
        Sun, 02 Nov 2008 15:13:35 -0800 (PST)
Received: by 10.141.77.7 with HTTP; Sun, 2 Nov 2008 15:13:35 -0800 (PST)
In-Reply-To: <7vbpwx3j7q.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99885>

On Sun, Nov 2, 2008 at 12:34 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Here are the topics that have been cooking.  Commits prefixed
> with '-' are only in 'pu' while commits prefixed with '+' are
> in 'next'.
>
> The topics list the commits in reverse chronological order.  The topics
> meant to be merged to the maintenance series have "maint-" in their names.
>
> There are backlog patches I'm planning to deal with later today; they do
> not appear in this list.
>
> ----------------------------------------------------------------
> [New Topics]
>
> * mv/maint-branch-m-symref (Sat Nov 1 00:25:44 2008 +0100) 5 commits
>  + update-ref --no-deref -d: handle the case when the pointed ref is
>   packed
>  + git branch -m: forbid renaming of a symref
>  + Fix git update-ref --no-deref -d.
>  + rename_ref(): handle the case when the reflog of a ref does not
>   exist
>  + Fix git branch -m for symrefs.
>
> * rs/blame (Sat Oct 25 15:31:36 2008 +0200) 5 commits
>  - blame: use xdi_diff_hunks(), get rid of struct patch
>  - add xdi_diff_hunks() for callers that only need hunk lengths
>  - Allow alternate "low-level" emit function from xdl_diff
>  - Always initialize xpparam_t to 0
>  - blame: inline get_patch()
>
> * ds/uintmax-config (Sun Oct 26 03:52:47 2008 -0800) 2 commits
>  - Add Makefile check for FreeBSD 4.9-SECURITY
>  - Build: add NO_UINTMAX_T to support ancient systems
>
> I amended the topmost one to widen the applicability of this new feature
> to all FreeBSD 4.*, not limited to 4.9-SECURITY; testing before this hits
> 'next' is appreciated.
>
> * ds/autoconf (Sun Nov 2 01:04:46 2008 -0700) 2 commits
>  - DONTMERGE: fixup with a convenience macro
>  - autoconf: Add link tests to each AC_CHECK_FUNC() test
>
> The topmost one is my attempt to simplify the new way of checking; the
> resulting configure.ac produces the identical configure script with or
> without it, so I think it is Ok, but testing before this hits 'next' is
> appreciated.  If all goes well, I think the two should be squashed into
> one patch.

I tested the above changes on FreeBSD.  The changes worked on FreeBSD
4.9 worked.

However pthread is linked on FreeBSD 4.x by using `-pthread' instead
of `-lpthread'.  The current pu branch forces the use of Pthreads and
links using an invalid flag. I am working on a patch now.
