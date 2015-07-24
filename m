From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [RFC/PATCH] log: add log.firstparent option
Date: Fri, 24 Jul 2015 00:46:57 -0700
Message-ID: <CA+P7+xo11PwE+L3zCy8Nw=xt+ZWKadd_-ra7C-QvNV80B6dCGw@mail.gmail.com>
References: <20150723012343.GA21000@peff.net> <CAGZ79kbY8hAom+voAOourkDy34nwaACQEM-n=f25Qbg0+ha_8g@mail.gmail.com>
 <20150724074028.GE2111@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Josh Bleecher Snyder <josharian@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 24 09:47:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIXhS-00052H-6e
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jul 2015 09:47:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753599AbbGXHrT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2015 03:47:19 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:35402 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752851AbbGXHrR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2015 03:47:17 -0400
Received: by igr7 with SMTP id 7so10434808igr.0
        for <git@vger.kernel.org>; Fri, 24 Jul 2015 00:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=jbe7FZ7KHEVrtScihpFt1luYxvZPq5/QqMrkwM+HwIM=;
        b=S8eYivcqVjNhrnyZz1cRWD7l7VYZitZWbj32nrbvaDf8k4byvO43uQddQ6wZHux7/Z
         HNy2PGyA5oNuKlWNYKgqbz6YidWT6R9UMQRMot1/oUjNGyY8VzWq1yGbG08heIJ0Qy4o
         p26pW4EVaNgd+2V8GojxyN6Bbr/QA0TV6w5pvMkbsKYW97rVR6r6+hsl9x93J3TO076T
         4IQI1Sk+nvyVU1QcoetQTYRfPGQkG5dr2dbr4vE4UNEeSJJnheI/1eFJUJYV2VhCbDuX
         D5dyq6JLDgp1O83ekgHh/nXaf2DRF5WjrAnv502sAYcLU90+7XAa/1zxXOHL9bVIcMYl
         GneA==
X-Received: by 10.50.23.98 with SMTP id l2mr3640875igf.25.1437724037216; Fri,
 24 Jul 2015 00:47:17 -0700 (PDT)
Received: by 10.107.5.203 with HTTP; Fri, 24 Jul 2015 00:46:57 -0700 (PDT)
In-Reply-To: <20150724074028.GE2111@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274562>

On Fri, Jul 24, 2015 at 12:40 AM, Jeff King <peff@peff.net> wrote:
> Whoops. Usually I "format-patch -s" and then add any notes while
> sending. But the wifi at OSCON was so abysmal that instead I wrote the
> notes directly into the commit message to send the whole thing later.
> And of course format-patch is not smart enough to know that I meant
> everything after the "---" as notes. :)
>
> -Peff

Kind of a side track but...

I think it's up to the caller of git-am to use "--scissors" to cut the
log? But maybe we could add an option to git-format patch which
formats and cuts via scissors as it generates the message? Not sure
the best way to interpret this, but I know I've had trouble where I
wrote some notes into an email and lost it because I killed the email
for some other edit. Keeping them inside my local commits before
sending out email would be handy.. hmmmm

Regards,
Jake
