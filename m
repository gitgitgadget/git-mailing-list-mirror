From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Fri, 5 Apr 2013 01:12:10 +0530
Message-ID: <CALkWK0moEg1iFd5HUQq3-P2ZV+xf98vL1+WEotNHEpL3egSLCA@mail.gmail.com>
References: <1365100243-13676-1-git-send-email-artagnon@gmail.com>
 <CA+55aFz1D_dMtMHHMpiGi3KL=Y-m4DVxHVr=1ZX8zYWQ2TPvwA@mail.gmail.com>
 <CALkWK0nNjvV5VGvT_eaubFoOhMnJ-N8FECAayd5A2K3BzeRh6Q@mail.gmail.com> <CA+55aFyQwJfiYo06y1bRNpKT6wOquhG9a9M_4YvLG_UT3b34-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Apr 04 21:43:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNq4C-0004p4-7l
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 21:43:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764711Ab3DDTmw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 15:42:52 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:61468 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764578Ab3DDTmv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 15:42:51 -0400
Received: by mail-ie0-f180.google.com with SMTP id a11so3412960iee.25
        for <git@vger.kernel.org>; Thu, 04 Apr 2013 12:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=acll1W7MSRW/DvXCPLxIPAevbYxQqta4vlIkHjFi06o=;
        b=sZU4TM/dyFaadJ035WyTKzFj4FGTb79iZrjaSE2Iombh4tcIbBfOD72Tq/uyNsRgZm
         JiFj/HklttYbsJmSX7CGB32GVgUAdhFcelZhukD2K/dO2TTAuKmIB+yFcYdpqm+HPaYt
         9X6fSFKyar2Ipb+o40ub6+UJKJVOngd/oRW1epIJTt6v9NJGIEYs6NC1VWbwlDzNH2eG
         9xBSvg8mYVZs4Srv7wDszYP1+rYj34yKVAOLHRPQys2a515CAKj7upJq+xmxGOXIn28Y
         UwKeTPjqRL2Zp6A476YzueryfSOmzGotdSwCFxfowkwFmuq3/8hqFVJ0NsZHPcUZGfq8
         kfVg==
X-Received: by 10.43.9.68 with SMTP id ov4mr3976553icb.22.1365104571100; Thu,
 04 Apr 2013 12:42:51 -0700 (PDT)
Received: by 10.64.166.33 with HTTP; Thu, 4 Apr 2013 12:42:10 -0700 (PDT)
In-Reply-To: <CA+55aFyQwJfiYo06y1bRNpKT6wOquhG9a9M_4YvLG_UT3b34-w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220077>

Linus Torvalds wrote:
> .... don't seem fundamentally antithetical to the
> current model

I don't think it's fundamentally antithetical either.  This basically
makes the life of git-submodule much simpler, and eventually obsolete
it away completely.
