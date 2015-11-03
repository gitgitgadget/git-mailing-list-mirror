From: Jonathan Lebon <jonathan.lebon@gmail.com>
Subject: Re: [PATCH 1/4] diff-highlight: add `less -r` to cmd in README
Date: Mon, 2 Nov 2015 22:12:13 -0500
Message-ID: <CAM0PgJ6XZmtuSXPq77V_TSoj_b=KhU2AFxmUgbkoE_f9e8Prmw@mail.gmail.com>
References: <1446516334-27652-1-git-send-email-jonathan.lebon@gmail.com>
 <1446516334-27652-2-git-send-email-jonathan.lebon@gmail.com> <xmqq7flzerda.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 03 04:12:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtS1h-00030t-3B
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 04:12:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752288AbbKCDMo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Nov 2015 22:12:44 -0500
Received: from mail-qk0-f181.google.com ([209.85.220.181]:34796 "EHLO
	mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751229AbbKCDMn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2015 22:12:43 -0500
Received: by qkcn129 with SMTP id n129so1648236qkc.1
        for <git@vger.kernel.org>; Mon, 02 Nov 2015 19:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=PuPvP+42z9FijyFGqBeGVvkkBBaqPEhD21UupFTM1dY=;
        b=FUkfUxS8QM07mild7xkXmw5uYDye5ZO+OlPndbx3j6VDXoa0LSM+fYyw51W0wGkMsg
         VLUVx/CRW5dvxKlWLFKiBg5D/m0v2rquM1Nb+MwAt6YrqeeUIv0UfV6EiMBpLWficZCv
         HJXxAyffdDp6DwrS0u3ZTDuE9oPxGzTzm2eShrJ7qOkqhSBtqXGRaWUQ+7OXt0m22B64
         h/WLakFCj3AA9GkPWaafWjoA/fcaggnUvLxG+ujLb0N16erZYVSsD8oAj3wVaFDK7/2k
         XDqAbMGCWwoSR8EYLL+eE4Asn26yakKeG/WPSYn6wyVc9zaAWs6vt/yUNj/4UU7cYpuy
         Nd/w==
X-Received: by 10.55.50.149 with SMTP id y143mr33521554qky.86.1446520363206;
 Mon, 02 Nov 2015 19:12:43 -0800 (PST)
Received: by 10.55.221.141 with HTTP; Mon, 2 Nov 2015 19:12:13 -0800 (PST)
In-Reply-To: <xmqq7flzerda.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280747>

On Mon, Nov 2, 2015 at 9:41 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Jonathan Lebon <jonathan.lebon@gmail.com> writes:
>
> > As it is, the suggested command for trying out diff-highlight will just
> > dump the whole git log output to the terminal. Let's pipe it through
> > `less` so users aren't surprised on the first try.
>
> That justifies the "less" part but not your choice of "-r".
>
> I am assuming that you are telling "less" not to show the ANSI
> "color" escape sequences using the caret notation with "-r", which
> is a very natural and sensible thing to do when using `highlight`.
>
> But if that is the case, you don't want "-r" (raw control chars for
> everything).  You would want to say "-R", I think.

Ahh thanks, that makes sense. I will update this for v2 tomorrow.
