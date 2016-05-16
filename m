From: Chris B <chris.blaszczynski@gmail.com>
Subject: Re: git push --quiet option does not seem to work
Date: Sun, 15 May 2016 20:51:53 -0400
Message-ID: <CADKp0pzPOdcSfBESzGMhrY5itSa4KDeOQ2VgwewuwH8CGZcwCw@mail.gmail.com>
References: <CADKp0pwrKzHG7KVSMH+6OHuv9sKXTcKSsdKMEZ_fFdjWT+kW6g@mail.gmail.com>
 <CADKp0pw5FFDVvPz0CcjOTYteQ9jFn2jBZwaX6_n8r3UQRGcGdQ@mail.gmail.com> <20160515212332.GB31809@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 16 02:52:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b26m5-0008MI-Cy
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 02:52:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752113AbcEPAwe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2016 20:52:34 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:35105 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751871AbcEPAwd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2016 20:52:33 -0400
Received: by mail-io0-f181.google.com with SMTP id d62so192982762iof.2
        for <git@vger.kernel.org>; Sun, 15 May 2016 17:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jVeodTI3W/+DlDWAFqA2CYfk3Sf2SFp6u/iMCbOg1EQ=;
        b=0ERv2h+xmNOTq0YFvjuP+7MWXImaIjUk+GlQ5rO+msnzu3WJysNPlO9AHwL4y5hiX4
         G9z1bT2AX5YKQIFwAA4QqihaXy+c6BTji3AYl8C9b8zG71zmR0e3icWftx9fLqyZmG7L
         WrFs9SGKj7TP6Al4kqPte8UtJ7sgUlXSach9RuCO1QkLhz5UMNEkIgyEkr6B518yMyRb
         S5MCpsxXDzOVPsRNt+Iyr1sf8vBtCSVXo4m1h8hzeHDHUJ85la2s24jgmx79OO6/242I
         eBhkXiJc7xkonBv6cw9SEs8wacLY00HBLn4olzrrT2sNONmCt4/t/rBA7CDoAo2X4yXL
         Cc5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jVeodTI3W/+DlDWAFqA2CYfk3Sf2SFp6u/iMCbOg1EQ=;
        b=CLqUvTKGXbA29UQFPODZGLzkuL34C1PYPFVNAOKjfjNaKWBwF4DEUXxHkVwxSvxiDZ
         /dKJdCGh/iDQZNsVeMuS4cw+kWBosC8jah6k94KgrFqf8zzI/72gnGEZuYFpjYnXkd39
         +po6ksHE9k8LxYU95Fonr073dCI33CY1ajTgT7cpfeQ/YaM71i7UXXYYHZ/AMrhFMXYf
         /+IEndcUzkzZ+KWC2vZilzhU8aLy74pCXG8hdwWR2HVIx9YHmSUFz/Aftoztp4maMu1J
         bENvP+wjlchZLyqfdQpo+yIYGcLf2SrUyg0mt7w30Urry8I4YFi3dLAlSEM1EMwVIkAj
         ey+Q==
X-Gm-Message-State: AOPr4FVxHLQufXYwHFghUMT7hGAY2t3GnxniznWzyS66uCzGOKIk3qlhzmlocCyyumhL22Vh21YUJy11W8vnKw==
X-Received: by 10.107.38.79 with SMTP id m76mr20514594iom.7.1463359952656;
 Sun, 15 May 2016 17:52:32 -0700 (PDT)
Received: by 10.107.20.88 with HTTP; Sun, 15 May 2016 17:51:53 -0700 (PDT)
In-Reply-To: <20160515212332.GB31809@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294711>

I did not see in your example any commit. But if you say so.
I saw git init which would be a new repo.. don't know if it makes a difference.

It's pushing to HTTPS.

I can provide the real example tomorrow.
