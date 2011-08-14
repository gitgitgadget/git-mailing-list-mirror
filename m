From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [feature wishlist] add commit subcommand to git add -i
Date: Sun, 14 Aug 2011 14:26:38 +0530
Message-ID: <CALkWK0=9sT6wDwoa3vDF1bt1e8AiubwW42-o=c++MpzV47LhQg@mail.gmail.com>
References: <CAJfuBxwW8Dyp8FTS13uPOBKZGL9JOEqaSOhGN+zBJ_8BHpJE3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Conrad Irwin <conrad.irwin@gmail.com>
To: Jim Cromie <jim.cromie@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 14 10:58:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QsWWZ-0002NJ-14
	for gcvg-git-2@lo.gmane.org; Sun, 14 Aug 2011 10:58:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752517Ab1HNI5A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Aug 2011 04:57:00 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:52378 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751939Ab1HNI47 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Aug 2011 04:56:59 -0400
Received: by wyg24 with SMTP id 24so2946209wyg.19
        for <git@vger.kernel.org>; Sun, 14 Aug 2011 01:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=ffY21mTkSovBoiFOq5ZmaKNUGbFPbATaoBmE7CD3Jkk=;
        b=LZYbk4g2/blbE01S5RaZl40eD7n23wxELFx7Dsm58rM455gHMjp81/kiYd0OFBGeGZ
         XZsYRfEmhFSnBIhUFhsflAvBB6ciO369W23ZSf235+eLGOkX78lEWUYcTp+q8+u6GofP
         +GWD4fh86NgykSCaQ928RcIhY/PrFhgmPad7c=
Received: by 10.216.231.210 with SMTP id l60mr1082430weq.63.1313312218156;
 Sun, 14 Aug 2011 01:56:58 -0700 (PDT)
Received: by 10.216.172.132 with HTTP; Sun, 14 Aug 2011 01:56:38 -0700 (PDT)
In-Reply-To: <CAJfuBxwW8Dyp8FTS13uPOBKZGL9JOEqaSOhGN+zBJ_8BHpJE3g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179315>

Hi Jim,

Jim Cromie writes:
> when using git add -i, it would be handy to have a [c]ommit option.

I can't personally comment on this because I use Magit for staging/
unstaging and committing.  It's quite an awesome application- do check
it out if you use Emacs.

> going further, if git rebase -i =C2=A0had ability to =C2=A0"back" a f=
ixup patch
> back to where it should have been, and adjust the intervening patches
> where conflict would normally happen, that would be awesome.
> Simplistically, this would just shift the patch 1 step back iterative=
ly,
> until it wouldnt apply properly, and then --abort, stopping at the la=
st
> clean rebase.

Hm, I'm not sure if I understand fully: is the idea about moving a
commit backwards iteratively so we have to resolve several simpler and
smaller conflicts?  I have to admit that I work around this problem by
running 'rebase -i' several times, moving the commit back in the
sequence little-by-little.

-- Ram
