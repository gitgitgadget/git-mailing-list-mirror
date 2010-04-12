From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH] git-gui: Fast staging/unstaging of hunks/lines
Date: Mon, 12 Apr 2010 08:49:01 +0200
Message-ID: <q2m36ca99e91004112349l9e336fffl7e69bb75bce07a40@mail.gmail.com>
References: <7ed246d74b2ea872a4af3b99d519590ab17ffefc.1270457921.git.bert.wesarg@googlemail.com>
	 <x2o36ca99e91004110038oce1ffa15jc49244f228ce218@mail.gmail.com>
	 <201004112101.54908.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Apr 12 08:49:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1DSO-0002Uj-62
	for gcvg-git-2@lo.gmane.org; Mon, 12 Apr 2010 08:49:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752928Ab0DLGtH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Apr 2010 02:49:07 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:51444 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752438Ab0DLGtE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Apr 2010 02:49:04 -0400
Received: by fg-out-1718.google.com with SMTP id 22so783897fge.1
        for <git@vger.kernel.org>; Sun, 11 Apr 2010 23:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type;
        bh=b0sOCoQtP38DhFXiuKUHCO+P/Xlp1VQa/yGNfNlx5dE=;
        b=rrux16w64U5FtiamHZIW4H+8O+4WTYHYXx28CqP4fOlKCdiW1lpCh3q/G770/ED4sT
         atJIufvPGhspupxMkL1PEVJmdbmsSYv15HMhAe4KfsdbYi6ywxu4vFFFyW9hTjtiB0Mi
         48+qagFcGuMKmQaVngTwKRfor6gUSjmf1bKLA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=h78q5q8li6wfiIvowcQeVpLCTA+GmiGMZCVcJZLO6hWI7I/nXKnjrOjmYdniqBStzt
         XDJ4udhdICtqyxLi4K7KHg3xr6ASx1MuvkAidk4JAWNHyEg/UkhEZ+FYeXR5MuTcSLX9
         bb2U8vJKm/f72kMtJct4QV8f3pImVVTolO248=
Received: by 10.223.111.7 with HTTP; Sun, 11 Apr 2010 23:49:01 -0700 (PDT)
In-Reply-To: <201004112101.54908.j6t@kdbg.org>
Received: by 10.223.62.202 with SMTP id y10mr481520fah.100.1271054941651; Sun, 
	11 Apr 2010 23:49:01 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144706>

Hi,

On Sun, Apr 11, 2010 at 21:01, Johannes Sixt <j6t@kdbg.org> wrote:
> On Sonntag, 11. April 2010, Bert Wesarg wrote:
>> On Mon, Apr 5, 2010 at 11:01, Bert Wesarg <bert.wesarg@googlemail.com>
> wrote:
>> > This adds a shortcut to stage/unstage hunks or a range of lines. Which is
>> > done on a mouse button 1 release event and holding the control key in the
>> > diff view. If there is currently a selection only the selected lines will
>> > be staged/unstaged. Otherwise the hunk will be staged/unstaged.
>>
>> Ping.
>
> I gave the patch a quick try.

Thanks,

>
> I don't think that I would use it a lot because it is very easy to mess up a
> staged change: The problem is that a click without anything selected will
> stage an entire hunk. I frequently use "Stage Line(s)" to separate
> neighboring changes that must go to separate commits, but with you feature it
> is very easy to forget to select something and, hence, to stage the entire
> hunk accidentally - which means that I would have to start over with the hunk
> and all the "quick" aspects of the feature would be lost.

I don't feel comfortable with this ambiguity myself. I see two ways to
solve this:

    a) Use Shift-Button-1 for lines

or

    b) Use Shift-Control-Button-1 for lines

and make Control-Button-1 only stage hunks.

May this interface be more usable?

Regards,
Bert

> -- Hannes
>
