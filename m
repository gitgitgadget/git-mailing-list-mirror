From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] remote-helpers: point at their upstream repositories
Date: Tue, 20 May 2014 16:31:35 -0500
Message-ID: <537bc9b733534_1d08f2d2f83b@nysa.notmuch>
References: <xmqqa9aid52a.fsf@gitster.dls.corp.google.com>
 <20140516084126.GB21468@sigill.intra.peff.net>
 <xmqq8uq1br9c.fsf@gitster.dls.corp.google.com>
 <537693aee4fdd_3e4812032fcc@nysa.notmuch>
 <xmqq7g5i4r48.fsf@gitster.dls.corp.google.com>
 <53795c3e58f73_10da88d30829@nysa.notmuch>
 <xmqqha4lwj57.fsf@gitster.dls.corp.google.com>
 <537B6CF5.4020808@alum.mit.edu>
 <CALKQrgcdSgZ76hKR35SDxGHYQ_cE3toEXphDVSu99B-pbTsSNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Jeff King <peff@peff.net>,
	Git mailing list <git@vger.kernel.org>
To: Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue May 20 23:42:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmroB-0001bq-Hp
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 23:42:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbaETVms (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 17:42:48 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:52416 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750735AbaETVmr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 17:42:47 -0400
Received: by mail-ob0-f175.google.com with SMTP id wo20so1188913obc.34
        for <git@vger.kernel.org>; Tue, 20 May 2014 14:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=A6NpybhSZGXtz//3Mabg2ROe+m+jAfM5RgPd+gYcxgE=;
        b=sAgQR2IIz5ZTyPx85xbSRlV+D5u+hdYt9hp9T9kj9iBQxKHrK8EFN+ZIzyEZq3F3nz
         edix69QYjIW2J43fCSWbrXEcDOTRAT3QH1XzbLiAhjybZrQglmXLXFySIMz/PwFvj+pZ
         kos5iAEzklqSmHSLJOsE6PM8gJLTU8+HqRfhr2LAUe5tIIqF5Oa60TRzwNcOhfdLbFWg
         AtTk64o20XB+KrjtO90ZzX+HKBWTLVnOoq8HWEJTvc5zB0tmXjbUhm4Fq4dn0ExsrtZo
         4Th8VqAdte3uFFnBFxtbZV6nSq++zyIKi3LMg+ZGTWt1qd7Z8k9FQVq5tBnmBgoUQ4N7
         jSmA==
X-Received: by 10.60.133.107 with SMTP id pb11mr47014730oeb.48.1400622166944;
        Tue, 20 May 2014 14:42:46 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id jr2sm39963282obb.8.2014.05.20.14.42.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 May 2014 14:42:46 -0700 (PDT)
In-Reply-To: <CALKQrgcdSgZ76hKR35SDxGHYQ_cE3toEXphDVSu99B-pbTsSNQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249751>

Johan Herland wrote:
> On Tue, May 20, 2014 at 4:55 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> > On 05/19/2014 11:31 PM, Junio C Hamano wrote:
> >> Felipe Contreras <felipe.contreras@gmail.com> writes:
> >>> Where is git-imerge packaged?
> >>
> >> I didn't see it on the archive the said Ubuntu box slurps from, but
> >> I did not check all the other distros.
> >>
> >> Michael, do you know what distro folks are doing with imerge?  For
> >> the purpose of this thread, "I do not follow distros, and I do not
> >> know" is a perfectly acceptable answer, but it would be very
> >> relevant if your answer is "I suggested these distros to include it,
> >> but so far they have been uncooperative and I haven't had much
> >> success".
> >
> > I haven't heard of any Linux distros that have git-imerge packages.  I
> > just searched the package archives for Debian, Fedora, Gentoo, and Arch
> > without finding it.
> 
> FWIW; someone has made an AUR package (a user-contributed Arch package
> recipe) for git-imerge:
> https://aur.archlinux.org/packages/git-imerge-git/

That doesn't say much. Anybody can put packages there, and it has a
single vote, which suggests not many people use it (if any).

-- 
Felipe Contreras
