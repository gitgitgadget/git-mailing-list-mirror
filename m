From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 3/3] grep: stop looking at random places for .gitattributes
Date: Thu, 11 Oct 2012 15:17:45 +0700
Message-ID: <CACsJy8AKT4VzYg_aBrK2UNAhv=yO=ddSFPdi3sZakD9UBc388w@mail.gmail.com>
References: <7vk3uzfp3p.fsf@alter.siamese.dyndns.org> <1349868894-3579-1-git-send-email-pclouds@gmail.com>
 <1349868894-3579-4-git-send-email-pclouds@gmail.com> <5075615B.8020702@viscovery.net>
 <CACsJy8BG0HJNePG-j27SrfEenEkZ5a5nCdMEuDGn=qXxq=VzhA@mail.gmail.com>
 <50756646.5060505@viscovery.net> <7vy5jeaz81.fsf@alter.siamese.dyndns.org>
 <50765F34.1070108@viscovery.net> <50766F94.4020104@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Oct 11 10:18:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMDyS-00050Z-KM
	for gcvg-git-2@plane.gmane.org; Thu, 11 Oct 2012 10:18:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751477Ab2JKISU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2012 04:18:20 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:34562 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953Ab2JKISQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2012 04:18:16 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so2521902iea.19
        for <git@vger.kernel.org>; Thu, 11 Oct 2012 01:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=nw6WVGR2Qe92MSqVF35gWP8VS8sYHUHhjyHi+pKh+vE=;
        b=tETiDqAMfFRv2Tf1NxPGHJyXburhKXbLkakHrf8C2Cn0ERK0GFy96+Dj/5kFMG4/1L
         BPaXXdq8kwk6vLYtnbsGT6bHWB0np5PhPseQHGwZTYRSLyu4jKCZqq8Hu/mJqzxL6157
         mHup2b1MNL0yoWZuHUlRsNhFskiJGV4fSedGbRJVb8rALVZcdwd8/k5j8XufhQ/56h0x
         g415MV/7A+Z2EW0pD6E3vhlSQ9Gh7bQyrEFr1KsYR9QTU/9fBdv28AFNtwligXEDsfKB
         kml399uIToQpulPto+r81U6JC3mZ+33H0WgMjngsamppCvRYRNmYKLey0xvQXqW/RqSc
         tL9A==
Received: by 10.50.153.130 with SMTP id vg2mr7866798igb.26.1349943496061; Thu,
 11 Oct 2012 01:18:16 -0700 (PDT)
Received: by 10.64.143.168 with HTTP; Thu, 11 Oct 2012 01:17:45 -0700 (PDT)
In-Reply-To: <50766F94.4020104@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207468>

On Thu, Oct 11, 2012 at 2:04 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> Maybe I'm being too much of a purist, but I don't think that git should
> retroactively reinterpret history on its own initiative in a way that
> might not be correct (e.g., maybe your encoding changed from ASCII to
> Shift-JIS sometime in the past).  It would be more appropriate for this
> to happen only if explicitly requested by the user.  For example, why
> don't you override the incorrect historical attributes via
> .git/info/attributes?

I think git-notes is a more appropriate place to correct these things.
If the incorrect commits are pruned, their notes can also be pruned.
No poluttion in $GIT_DIR/info/attr.. And i'm your side, no checking
worktree without user's permission.
-- 
Duy
