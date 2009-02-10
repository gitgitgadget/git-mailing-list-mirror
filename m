From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [ANNOUNCE] tig-0.14
Date: Tue, 10 Feb 2009 19:29:04 +0100
Message-ID: <2c6b72b30902101029s72628a88n16473ee30f853198@mail.gmail.com>
References: <20090205204436.GA6072@diku.dk> <4991814A.6050803@tedpavlic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Ted Pavlic <ted@tedpavlic.com>
X-From: git-owner@vger.kernel.org Tue Feb 10 19:30:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWxNW-0008GL-1F
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 19:30:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753851AbZBJS3L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 13:29:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753429AbZBJS3J
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 13:29:09 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:39598 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752457AbZBJS3I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 13:29:08 -0500
Received: by bwz5 with SMTP id 5so3029932bwz.13
        for <git@vger.kernel.org>; Tue, 10 Feb 2009 10:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=+V4uWUIS9v8HAXlbBSLDFAQoBampRN6eqY3OgyJ/lYg=;
        b=XxvuKg28lsUmhYUrhtQT/G2cl0EQbBpNunBC32ozyxKWZIKl8YB2KN4FuHs6uoap38
         MEt3EUFxpEw+4ZXpBp+p8q43DftzGsnhDJlqxtzTH6+0+Ke7dn7EMHBl1sv1wd2nFBSW
         cYDgumAyUlLZlXZ1Tt3AvPPdGiLvdyG3MZxvA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=STTAirr+56x/NqSSXAFK24AOF/BmEb0iwzETO6zGT4+0mEB0AaqjiXWX9D3Akzqhb2
         /8dsPiCVlplR5LHwt+kJWhVrLfHhFC1/1wdnoiKCXqR6XqXy9lNLp/lVlZ2KEEQy51Kh
         hK/AZvySIrt2JVbE+so1xNEG88O94nUqZzq9o=
Received: by 10.181.48.13 with SMTP id a13mr557420bkk.43.1234290544976; Tue, 
	10 Feb 2009 10:29:04 -0800 (PST)
In-Reply-To: <4991814A.6050803@tedpavlic.com>
X-Google-Sender-Auth: 906235fdd2f221e0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109288>

On Tue, Feb 10, 2009 at 14:29, Ted Pavlic <ted@tedpavlic.com> wrote:
> I notice that when I do the sequence...
>
> *) open tig
> *) hit <CR> to view first changeset
> *) hit "j" to scroll one line
>
> the green highlighting on the first line moves to the second, but the
> whitespace following the "commit 00000000000000" stays green. For example,
> if I do the sequence above in the tig repo, I'm left with
>
> commit e278600f599f60a2b98aeae6bfbb6ba92cf92d6f---GREEN BG HERE---
> ---This line (Refs:) has GREEN BG---
>
> The "commit" has a black background.
>
> Is that a bug? Or do I need to upgrade my ncurses?

Sounds like a bug. Probably from the drawing optimizations in tig-0.14.

No upgrade should be necessary. Could you give me some information
about what terminal application you are using. Also, have you added
any specific color settings to ~/.tigrc?

> If I hit <CR> a few more times (to move the screen) and then hit "j" more
> (to move the highlighted line), I get this same bug randomly on different
> lines.

This is a good hint. Does it happen a mostly when you hit "j" and it
causes the view to be scrolled down?

-- 
Jonas Fonseca
