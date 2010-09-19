From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] Makefile: add CC to TRACK_CFLAGS
Date: Sun, 19 Sep 2010 19:27:03 +0000
Message-ID: <AANLkTikBP3pJ7ZN9jC9yQeVKssgr2KMpaY-nQtpJZiP-@mail.gmail.com>
References: <1284331065-3394-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 19 21:27:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxPXc-0005ga-5D
	for gcvg-git-2@lo.gmane.org; Sun, 19 Sep 2010 21:27:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752357Ab0IST1G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 Sep 2010 15:27:06 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:54935 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752021Ab0IST1E convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Sep 2010 15:27:04 -0400
Received: by iwn5 with SMTP id 5so3631633iwn.19
        for <git@vger.kernel.org>; Sun, 19 Sep 2010 12:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Xnse5pEP/ZUb3V2Xe8tKN52ZfeVSWAsQMdpMT9wJII0=;
        b=L5FA5J1INVxwSxNXi9TtdmPZvptPUbYjWzeQxHU52MZS6Qqbdnr3xK8q9thcDZGtZD
         8NLzQR/zDcavzThM9BFkMLMilu6pTrD4eb+2vj7vwiGqyrghnXSptCc+5vNy3FVj3D3X
         T1qYHhvRTJsKHc4h8jUIxO1m37OsXQ0DiYoAg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=sb9E1b7JMB2STk+9zUt+OLrJG002BNK+/j6ghRfAyovOax4Ool5wfMQQqvwXMjE3L8
         ZnDgmuEGlXGCMgm3opGiyEu/c4AMJeayyiCIjlbMWqN36C+fspfR9X+B5bB77Hidy67T
         J+9u3i4+vWPYar6IPARdhEdYwSCGJJZaYy0tE=
Received: by 10.231.182.196 with SMTP id cd4mr8909599ibb.191.1284924423550;
 Sun, 19 Sep 2010 12:27:03 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Sun, 19 Sep 2010 12:27:03 -0700 (PDT)
In-Reply-To: <1284331065-3394-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156512>

On Sun, Sep 12, 2010 at 22:37, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <=
avarab@gmail.com> wrote:
> Change the git make process so that everything's rebuilt if the CC is
> changed. Before we wouldn't rebuilt if e.g. the CC variable was
> changed from gcc to clang.

Is there a reason for why this didn't get picked up other than falling
through the cracks?
