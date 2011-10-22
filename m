From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/6] revert: fix buffer overflow in insn sheet parser
Date: Sun, 23 Oct 2011 00:27:05 +0530
Message-ID: <CALkWK0n3srWcsDxaWvgd7s7jHVuSKv+aLJ1n0inae2hMA_C3kQ@mail.gmail.com>
References: <1319058208-17923-1-git-send-email-artagnon@gmail.com>
 <1319058208-17923-4-git-send-email-artagnon@gmail.com> <7v8vogbgai.fsf@alter.siamese.dyndns.org>
 <20111020080328.GA12337@elie.hsd1.il.comcast.net> <4E9FE061.3080601@gmail.com>
 <20111020090912.GA21471@elie.hsd1.il.comcast.net> <7vmxcva8k1.fsf@alter.siamese.dyndns.org>
 <20111020180533.GA5563@elie.hsd1.il.comcast.net> <7vaa8va3xm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 22 20:59:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RHgn5-0006AW-G4
	for gcvg-git-2@lo.gmane.org; Sat, 22 Oct 2011 20:59:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751583Ab1JVS51 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Oct 2011 14:57:27 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:41358 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750758Ab1JVS50 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Oct 2011 14:57:26 -0400
Received: by wyg36 with SMTP id 36so4965502wyg.19
        for <git@vger.kernel.org>; Sat, 22 Oct 2011 11:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=grY7KZxV66arxNkPrtoAi2IlnjK3mNgNdNMazUQGxt8=;
        b=XMBVY5erxvWyYGRcsB2VF6kCFFq+Jh1eW/QwrVjxQtXKPKO984jNXoMq/m3/a/BGeY
         zLHBqySifxVuUIRmKHjlA9mcYpbAnMe0MvvO+r7TBorgQKUDN8fBc8vldYB3Oa1ZAUY4
         VaZBlxZetK3xNtSYyJRvbL91qjNoa5GwtL/8o=
Received: by 10.216.131.161 with SMTP id m33mr1707243wei.55.1319309845147;
 Sat, 22 Oct 2011 11:57:25 -0700 (PDT)
Received: by 10.216.159.78 with HTTP; Sat, 22 Oct 2011 11:57:05 -0700 (PDT)
In-Reply-To: <7vaa8va3xm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184109>

Hi Junio and Jonathan,

Thanks for the good suggestions.  Will post the next iteration in a
few minutes (some tests running now).

Junio C Hamano writes:
> [...]
> When the log message justifies the cause and the approach in the right
> way, the actual patch becomes self evident. Also I often find myself
> coming up with a _better_ solution than the patch I originally prepared
> while writing the commit log message to explain it, and redoing the patch
> text to match the description.

Wow.  It looks like I have a long way to go :/
Maybe I should practice writing more Haskell.

-- Ram
