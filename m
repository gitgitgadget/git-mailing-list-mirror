From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH v4 1/4] Introduce wholesame directory move detection in diffcore.
Date: Mon, 4 Oct 2010 02:59:20 +0000
Message-ID: <AANLkTinhfxXPqapzdBkSehq9Qxv20=bxq9HwR8kQfPdn@mail.gmail.com>
References: <1286138529-6780-1-git-send-email-ydirson@altern.org>
	<1286138529-6780-2-git-send-email-ydirson@altern.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Mon Oct 04 04:59:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2bGw-0007ok-Q6
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 04:59:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751486Ab0JDC7W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Oct 2010 22:59:22 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:39078 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751403Ab0JDC7V (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 22:59:21 -0400
Received: by iwn5 with SMTP id 5so6345094iwn.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 19:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=9zzj1RXR3CjZjwTdAH7olRgkG0LJooa+FheOGy345co=;
        b=Y/TM6Ys+bxen8RTk3KdULbU7IN2E6cluYUMUOv5LEIbgpd3x6m0ib1Fu77FY+afY05
         K7UfqbUozKIxDxXCVbBjpt3+Xm50B/mXdCeUIpqGHlCDh1GrgzhdvlUWKGuoj6C6Ao3h
         W2vrK8gEUFB3IlgoCmqRCcNrUDNgtsNqD+l/w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=aWdMYdz9grhO41R1PCssEVXcElFwLv9Rvo/E1sBhmQ0LqRu4+MQaWE22UhTchmk5IO
         XBNj+d4Q0Oekxo4jUy21ASoWL0HQo+z3G3rJPOg401UW+H4Gf+p1IfaSytJtZHWIeeX1
         ryyXXNkNL7TJXA5H4785pi2QGMV1V5AJKpp80=
Received: by 10.231.157.212 with SMTP id c20mr9346022ibx.186.1286161160945;
 Sun, 03 Oct 2010 19:59:20 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Sun, 3 Oct 2010 19:59:20 -0700 (PDT)
In-Reply-To: <1286138529-6780-2-git-send-email-ydirson@altern.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157961>

On Sun, Oct 3, 2010 at 20:42, Yann Dirson <ydirson@altern.org> wrote:
> This feature tries to group together files moving from and to
> identical directories - the most common case being directory renames.

You should change the C++/C99 comments to C89 comments since we target
the latter.
