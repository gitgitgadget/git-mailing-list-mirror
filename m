From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: git fsck: unreachable vs. dangling
Date: Tue, 14 Apr 2015 10:52:31 +0200
Message-ID: <CAHGBnuOuMnAsP12dukPSP31ABRoUc=s7iZFnca9-K2hOcog9cQ@mail.gmail.com>
References: <CAHGBnuOYLpkeUop9vNH3+WSKqrM3NCSqvu-NZnPnk3gEkAr6eg@mail.gmail.com>
	<CAPc5daXRpfSrvcae0W+YU-51prCoFGxz_hkhtp7FZ-K9_eeeBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 14 10:52:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YhwaK-0006EZ-J8
	for gcvg-git-2@plane.gmane.org; Tue, 14 Apr 2015 10:52:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753220AbbDNIwf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2015 04:52:35 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:34444 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752447AbbDNIwd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2015 04:52:33 -0400
Received: by iget9 with SMTP id t9so71623240ige.1
        for <git@vger.kernel.org>; Tue, 14 Apr 2015 01:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=4kuSBtBXw4++nx322TSQLBhE1Sz5Ek/Q+UJRjtoG7ao=;
        b=E46ur2punSUKhPtA18vYGqNarP6ko8zb3iuE+s0RSsBjB+HvHLk+0uIV47TmrqZbK1
         VYlnGwseAXGckp52FQNHupKkulmLMPMjvpKZS2GDbAF+0aO2n8IMtcJd3irTwG4e8cwl
         Wq2JNq9fIOtD8jZ0gXt3u1c359YOahG9oF0FuCccLnYoYpqggg8eYIMEnfyGWYFAN0DR
         angj8IKV3Rh1kJXhaBTVvc6AmUB3VVt2+bR/o529meiSAxw5adM9990aaaWiECw0gyA2
         4hnQWICXDEdglvjG8y1TyZt5v68xAoltAINds+4KkLkk0leUgzxS441hV6QhEXP9cL6s
         7i1w==
X-Received: by 10.42.86.12 with SMTP id s12mr24142642icl.47.1429001551765;
 Tue, 14 Apr 2015 01:52:31 -0700 (PDT)
Received: by 10.107.159.82 with HTTP; Tue, 14 Apr 2015 01:52:31 -0700 (PDT)
In-Reply-To: <CAPc5daXRpfSrvcae0W+YU-51prCoFGxz_hkhtp7FZ-K9_eeeBQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267123>

On Tue, Apr 14, 2015 at 10:05 AM, Junio C Hamano <gitster@pobox.com> wrote:

> A dangling object is an unreachable object that cannot be
> made reachable by any way other than pointing at it
> directly with a ref.

Thanks a lot for the prompt explanation!

-- 
Sebastian Schuberth
