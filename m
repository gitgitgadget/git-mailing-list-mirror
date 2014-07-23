From: Christoph Bonitz <ml.christophbonitz@gmail.com>
Subject: Re: Test failure in t9814-git-p4-rename.sh - my environment or bad test?
Date: Wed, 23 Jul 2014 23:26:34 +0200
Message-ID: <CABUJjW8rjQNhfG6yw=6FaMoqMzudcrhV1RaZfQK94yxT64oZng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Pete Wyckoff <pw@padd.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 23:26:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XA43c-0000Kh-Fh
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jul 2014 23:26:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933689AbaGWV0h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2014 17:26:37 -0400
Received: from mail-vc0-f170.google.com ([209.85.220.170]:63732 "EHLO
	mail-vc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933670AbaGWV0f (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2014 17:26:35 -0400
Received: by mail-vc0-f170.google.com with SMTP id lf12so3322066vcb.15
        for <git@vger.kernel.org>; Wed, 23 Jul 2014 14:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=IhpnHmXBB3glUKrjb98ptnG+/05QRtMUEGuGCTsId7I=;
        b=FL4gET+38LbGScjZWQWEKte6315u1IAJoVV/yHg0pyFYK/XXzEHVlAVIjKIpyGcSib
         3F5sAVztqKrTsqWJQIFIFEI7q7TMXkxoz96DqiXwJaqyVXHHHVseu04m6UT+TAyBULSG
         C3K1VU9qoePuQsH28Af2Zp9D7YI3qWj7rIyCbYRD9lggVgHrpP7NL6tKXIieFbyM5WHL
         A+q62Towk2sCAmmnJfbFUsDVSaiuudHud7PNLoylWlgQ+P0E1q7kskx2JQx+NeBhWfwH
         80g1EwQTcOTy3IbX1geClOFVrg68BZvlc3aXHu+b2XNfwtwy7mY8go5T9pEJZd1H0R5H
         fjlg==
X-Received: by 10.53.7.204 with SMTP id de12mr5274530vdd.41.1406150794989;
 Wed, 23 Jul 2014 14:26:34 -0700 (PDT)
Received: by 10.220.80.132 with HTTP; Wed, 23 Jul 2014 14:26:34 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254125>

On Mon, Jul 7, 2014 at 11:14 PM, Junio C Hamano <gitster@pobox.com> wrote:

> "Choosing any of these as the copy source is fine" is a sensible way
> to fix the problem with this test.  Would it be a better solution to
> avoid having multiple/ambiguous copy source candidates in the first
> place, by the way?

I agree that this would be the best solution, although I feel more
confident making a less invasive change first.

Thanks,
Christoph
