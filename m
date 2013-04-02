From: Garrett Cooper <yaneurabeya@gmail.com>
Subject: Re: [PATCH 2/5] branch: factor out "upstream is not a branch" error messages
Date: Tue, 2 Apr 2013 12:36:16 -0700
Message-ID: <CAGHfRMC6mRSzdrY-iL3bvCETd5eY4D1-T85zMFcJg5tyNK7ciw@mail.gmail.com>
References: <20130402190134.GA17784@sigill.intra.peff.net>
	<20130402190355.GB32316@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 02 21:36:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN70t-0003l1-1i
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 21:36:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932945Ab3DBTgS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 15:36:18 -0400
Received: from mail-ia0-f181.google.com ([209.85.210.181]:33442 "EHLO
	mail-ia0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932613Ab3DBTgR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 15:36:17 -0400
Received: by mail-ia0-f181.google.com with SMTP id o25so608920iad.40
        for <git@vger.kernel.org>; Tue, 02 Apr 2013 12:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=1FVeC5AJQhUleJrrsL+3xQCXpi5gaYN/24wM1cQ2aIQ=;
        b=npaRa9T8ZEDpjZiMSFGD4plozxBMIrOr8FnRr3Jtae9X3jjzgF7DyIfK/kpdvBKrz3
         E9ualIf9hbGun3MlksGgypCg4CeXyFrRTRcVQ9ZYpQLsjXWXk4gHR1E6JxCp/rQP9vQy
         /6m19z+QxYd4imdtblIH0Ex5DTuYNhSuXfn7BySjiElp8tBcQU3VnY3xSnJ2UdNQcay3
         ww9sae9YsdXInG7XdBJi4h3tT0/YT+9uzarZx1J8MdaEPXHThdwV0SI9xSSKYQ5dMMd7
         aoxNxmgorGdhNBq2d8I/zGOYEWjlRVVnOTwy1bo/GNj2hIeS4aveQ+/enzF2ZH/ri4Uy
         VaCg==
X-Received: by 10.50.236.100 with SMTP id ut4mr5401509igc.86.1364931376765;
 Tue, 02 Apr 2013 12:36:16 -0700 (PDT)
Received: by 10.64.30.99 with HTTP; Tue, 2 Apr 2013 12:36:16 -0700 (PDT)
In-Reply-To: <20130402190355.GB32316@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219862>

On Tue, Apr 2, 2013 at 12:03 PM, Jeff King <peff@peff.net> wrote:
>
> This message is duplicated, and is quite long. Let's factor
> it out, which avoids the repetition and the long lines. It
> will also make future patches easier as we tweak the
> message.
>
> While we're at it, let's also mark it for translation.
>
> Signed-off-by: Jeff King <peff@peff.net>

LGTM!

Signed-off-by: Garrett Cooper <yaneurabeya@gmail.com>
