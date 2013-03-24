From: Matt McClure <matthewlmcclure@gmail.com>
Subject: Re: [PATCH v2 2/3] t7800: fix tests when difftool uses --no-symlinks
Date: Sun, 24 Mar 2013 09:24:02 -0400
Message-ID: <CAJELnLF0UbHD_fZ1VMuUfrF79JQSeOABA-i3t-qX0KGo7na-hA@mail.gmail.com>
References: <cover.1363980749.git.john@keeping.me.uk>
	<cover.1364045138.git.john@keeping.me.uk>
	<e44349728c07d8ae22d4b73527b1d124b49cc4a9.1364045138.git.john@keeping.me.uk>
	<7vd2up4bo7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org,
	Johannes Sixt <j.sixt@viscovery.net>,
	David Aguilar <davvid@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 24 14:24:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJkuX-00016u-EO
	for gcvg-git-2@plane.gmane.org; Sun, 24 Mar 2013 14:24:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753722Ab3CXNYE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Mar 2013 09:24:04 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:45875 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753658Ab3CXNYC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Mar 2013 09:24:02 -0400
Received: by mail-pa0-f46.google.com with SMTP id wp1so597435pac.5
        for <git@vger.kernel.org>; Sun, 24 Mar 2013 06:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=SAwbus+/cZv0phKYU9mxIU97aXE1winhitFyEZZ5zD4=;
        b=A1A1OWEw9NxJHnjXTQHFqHmd8ZTnniJvEXWoHK7GFhFitZ6fkKwbiPALnNEA9+tHFp
         qDxFWwnIBvqEWjmRXXKOVQsL85NeOG6AnFM498IjbCiM8pcL4X7/p3lFl8jlUS/u8jfV
         JsV8UijzRAHMxXaCSQfSGVHOK6X+FaxNhtHb7yZ15Cua+WnbkYRAU0DgnkqmjjApsrF2
         7hOFIqZfMkXwcZC18LY3Q1FYeVAkKcA1rUGg/qx7jTDVbuPuvfPdKFIM7YOXzZqvL5eq
         4/IezmVPBbkLMsOOCSIufnLtAGu1n4iLVnZBd6WTOmxTo97AMzrugziKPs+Yt0CTuFWg
         zY8Q==
X-Received: by 10.68.138.193 with SMTP id qs1mr12488166pbb.9.1364131442179;
 Sun, 24 Mar 2013 06:24:02 -0700 (PDT)
Received: by 10.68.11.70 with HTTP; Sun, 24 Mar 2013 06:24:02 -0700 (PDT)
In-Reply-To: <7vd2up4bo7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218956>

On Sun, Mar 24, 2013 at 1:19 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Admittedly I do not use difftool myself, and I have long assumed
> that difftool users are using the tools to _view_ the changes, but
> apparently some of the tools let the user muck with what is shown,
> and also apparently people seem to like the fact that they can make
> changes.  So I've led to believe the "update in difftool, take the
> change back to working tree, either by making symbolic links or
> copying them back" behaviour was a _feature_.

Definitely. Here's how I use it:
http://matthewlmcclure.com/s/2013/03/14/use-emacs-dircmp-mode-as-a-git-difftool.html

-- 
Matt McClure
http://www.matthewlmcclure.com
http://www.mapmyfitness.com/profile/matthewlmcclure
