From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 6/5] git-diff.txt: banish the <commit>..<commit> form
Date: Thu, 25 Apr 2013 00:03:54 +0530
Message-ID: <CALkWK0n7GwWy6FenZiJYyqetY3LQH=CM_eB0wag5n8uN9er5DQ@mail.gmail.com>
References: <1366821216-20868-1-git-send-email-artagnon@gmail.com>
 <1366822980-21926-1-git-send-email-artagnon@gmail.com> <7vip3bdbpg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 24 20:34:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV4We-0005JO-6Y
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 20:34:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757168Ab3DXSeg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 14:34:36 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:55336 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757116Ab3DXSef (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 14:34:35 -0400
Received: by mail-ie0-f171.google.com with SMTP id e11so2554972iej.30
        for <git@vger.kernel.org>; Wed, 24 Apr 2013 11:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=FaA71Ndxtxiy70XHF1kM+FC1bkYdFSMeA1tvXStddso=;
        b=e5vUFgY/VDbN9cXtUIKKKMUWqO9+SFQjxfxtecVnGBLQ9166rcSuvdmMVl16b0vOy3
         KvsvnNJ/pTqZXF+bi0oChlBmHqwQ89u4YSUlFkKh19JP98/Bw1bREqqyRI4MPx/BbXsB
         28d/O6jne/Obg/2UAJt+CsTajqBHfNoTWb0Nkp4/6gjXMIOW2LaZ38NB2Ia8XxbLxpZl
         vk6jQjYgD0aQ5PCcEP2LdA/00VtMkwbbxvvNTQkNwxV/LyYXxoEy8FzmLuifCDjImh2N
         RPxB5ymrhgpdN5KRfUzflF2QCyhn86BF6chGmCat7N3Wl58QDfrteUhRik/AP6y9wGyK
         +k+A==
X-Received: by 10.50.73.65 with SMTP id j1mr16251335igv.49.1366828474930; Wed,
 24 Apr 2013 11:34:34 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Wed, 24 Apr 2013 11:33:54 -0700 (PDT)
In-Reply-To: <7vip3bdbpg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222290>

On Wed, Apr 24, 2013 at 11:59 PM, Junio C Hamano <gitster@pobox.com> wrote:
> I agree with the end result not to list .. form in the SYNOPSIS, but
> you shouldn't have added it in the first place in the earlier patch.

I'm expecting to re-roll anyway.  I just wanted to show it to you now.

> I do not think it is a bad idea to drop this enumerated item, but I
> would have expected a sidenote to be added for the description for
> "git diff A B" form, so that people who saw "git diff A..B" somewhere
> on the web and wonder what it means can look it up.

Yeah, good idea.  I'll put it in the section after the ... syntax.
