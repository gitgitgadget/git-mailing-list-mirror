From: Junio C Hamano <gitster@pobox.com>
Subject: Re: compile error in Git v2.7.0-rc0
Date: Mon, 14 Dec 2015 13:11:19 -0800
Message-ID: <CAPc5daWWSNRdMSaQvakkK=mA_626QfuafmU5SkDTRC9kZpKzSw@mail.gmail.com>
References: <CALibRqFajuBuv9ooaBWL1kUzaVps2WfodqucyHni2ggv6JpwDg@mail.gmail.com>
 <xmqqvb80ix9u.fsf@gitster.mtv.corp.google.com> <20151214204624.GA14788@sigill.intra.peff.net>
 <20151214205241.GB14788@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: johan defries <johandefries@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Elia Pinto <gitter.spiros@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 14 22:12:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8aPX-0002xk-6H
	for gcvg-git-2@plane.gmane.org; Mon, 14 Dec 2015 22:11:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932469AbbLNVLz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 16:11:55 -0500
Received: from mail-io0-f177.google.com ([209.85.223.177]:36798 "EHLO
	mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932608AbbLNVLj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2015 16:11:39 -0500
Received: by iofo67 with SMTP id o67so58179587iof.3
        for <git@vger.kernel.org>; Mon, 14 Dec 2015 13:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=aMtnMGFNe0aur3eS3AuybVz5tlAY+MuL8QB7v6OZmJk=;
        b=XSh5/JQYn7ESR6lhlZUM1LZUGtbU4F3QX3+rnsDN/AsTWiFsUsmFg9CwkYTK2ynHYW
         MutJeLKGR9PyRjxHy8pIedOKZeI6TkKybAGH5xobkc0KqhLbInZzAdX4Yqay7owO+RHt
         SRLvmzBkue73ov0eOVhPLpv1U8r8v/5twqrdPSDAeS33YfrOxiDbiF4Ficy26Sa6RqMa
         8XcPnjSTCHPP4Xf8B4FAQGKHy9QBaty5DONOmi3fZfZi0nsDAkCWOmoytpkv7Rxt6E0s
         sB7K2uQsxEn+/sV18QuBV0GVfo4V6NRcdooAf43V005CY9Z76HemGcHhDhiC6eSjB5KJ
         aNxw==
X-Received: by 10.107.133.205 with SMTP id p74mr37467954ioi.44.1450127498682;
 Mon, 14 Dec 2015 13:11:38 -0800 (PST)
Received: by 10.36.52.203 with HTTP; Mon, 14 Dec 2015 13:11:19 -0800 (PST)
In-Reply-To: <20151214205241.GB14788@sigill.intra.peff.net>
X-Google-Sender-Auth: L8mCz-YeCpTTazWILaS0CYEOAkg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282415>

On Mon, Dec 14, 2015 at 12:52 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Dec 14, 2015 at 03:46:25PM -0500, Jeff King wrote:
>
>> I don't think that fix is right, though. We should be passing "host" to
>> gethostbyname.
>
> Here it is in patch form. It can go on top of ep/ident-with-getaddrinfo.


Thanks.

I recall you were looking for a brown-paper-bag earlier.
When you are done with it, could you pass it to me ;-)?
