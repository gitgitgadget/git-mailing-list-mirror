From: Patrick Palka <patrick@parcs.ath.cx>
Subject: Re: [PATCH] Improve contrib/diff-highlight to highlight
 unevenly-sized hunks
Date: Thu, 18 Jun 2015 16:27:51 -0400
Message-ID: <CA+C-WL9vAxxHvPA5XkHL-USBR7Dj1Or1vrbWsnpsJnWvmjBEqg@mail.gmail.com>
References: <1434388853-23915-1-git-send-email-patrick@parcs.ath.cx>
 <xmqqwpz1f22b.fsf@gitster.dls.corp.google.com> <CA+C-WL-CC9o13Rxrr+mKw+vbx=aEJmguLnwMwO=fE-JPJ2DqEg@mail.gmail.com>
 <20150618190841.GB12769@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 18 22:28:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5gQ5-00048o-8o
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 22:28:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755250AbbFRU2O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 16:28:14 -0400
Received: from mail-oi0-f54.google.com ([209.85.218.54]:34659 "EHLO
	mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754641AbbFRU2M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 16:28:12 -0400
Received: by oigx81 with SMTP id x81so66125446oig.1
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 13:28:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=eaq3jaD9zo17AiGkY8ugirGJlTv2JeIwirp5+aCTpt0=;
        b=ewufBZOL8/jcojuGPC1WbYJyWaMLf+I5NkBHhCJKW75As4PgxQAfzJaXEwF5QIYzlo
         C8dup+waQcijNXSJsg8wcIZ1HHmSbjkkorkVPMua/N7XzsGImso6ZpBbwTcuNLXEg7PB
         gSdZVLfFngbqUdlULTylYeZUqpHHZHzbMSPrA/R9EnX6pqQQffRxcx2CENRfaGwze/2h
         fNU21YmvqvK6I5DlzUHW8Klkbka7N9RO+lSkWRislcat2HRoLiurBfiHaoKNljRVqux9
         UrERE3szsY0QHFxcTaMTJ75rzIjkQuxW2HiGIB6XFoljedMxLibZssRbZtoM2iVSvZxB
         zrWw==
X-Gm-Message-State: ALoCoQkBSesD2iHHYtpWtSEesnVjP+24JUTUuPwh2OYM+2UHWK3m8lXpjXAmxIwX2aMsZCEbSPhh
X-Received: by 10.182.42.131 with SMTP id o3mr10581243obl.59.1434659291708;
 Thu, 18 Jun 2015 13:28:11 -0700 (PDT)
Received: by 10.182.96.167 with HTTP; Thu, 18 Jun 2015 13:27:51 -0700 (PDT)
X-Originating-IP: [67.83.172.216]
In-Reply-To: <20150618190841.GB12769@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272069>

On Thu, Jun 18, 2015 at 3:08 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Jun 18, 2015 at 12:28:58PM -0400, Patrick Palka wrote:
>
>> By the way, what would it take to get something like this script into
>> git proper?  It is IMHO immensely useful even in its current form, yet
>> because it's not baked into the application hardly anybody knows about
>> it.
>
> I think if we were going to make it more official, it would make sense
> to do it inside the diff code itself (i.e., not as a separate script),
> and it might be reasonable at that point to actually do a "real"
> character-based diff rather than the hacky prefix/suffix thing (or
> possibly even integrate with the color-words patterns to find
> syntactically interesting breaks). There is some discussion in the
> "Bugs" section of contrib/diff-highlight/README.
>
> -Peff

Thanks for the pointers.  This is something I am interested in
implementing (though not any time soon).  I was actually in the
process of familiarizing myself with the diff code before I discovered
the existence of diff-highlight by accident.
