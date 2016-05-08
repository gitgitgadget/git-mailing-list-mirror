From: Joe Lencioni <joe.lencioni@gmail.com>
Subject: Re: Config for git-blame flags -w, -M, and -C?
Date: Sun, 8 May 2016 11:39:52 -0700
Message-ID: <CAJzkHHfVK+UtEEx0d+T_ga3v6SiW0=2VhYFcMuMndzy0k9sK7Q@mail.gmail.com>
References: <CAJzkHHf-B0FK=Ow=B49GjSWyHJ6+fdnSvyGphDrEdkCGy1TOAg@mail.gmail.com>
 <xmqqk2j4z9wm.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 08 20:40:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azTcp-0002Az-Hy
	for gcvg-git-2@plane.gmane.org; Sun, 08 May 2016 20:40:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750885AbcEHSkN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 May 2016 14:40:13 -0400
Received: from mail-yw0-f170.google.com ([209.85.161.170]:32923 "EHLO
	mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750852AbcEHSkM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2016 14:40:12 -0400
Received: by mail-yw0-f170.google.com with SMTP id t10so266893399ywa.0
        for <git@vger.kernel.org>; Sun, 08 May 2016 11:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=orovRDlwPW3OzyVD6i3ZoLTsKlLomXgDByozZGlTWIw=;
        b=vg7j8UZGhyVcp24YOoBSjINliruELbLmVDPGNt/UR5gtZGt0oU7F/mMPEKG9Ps8WCz
         A3RmcmR7ErAeiJYqbQn7GNQn16udhXz4DN0CILsKAAkqcdYM6iTl5Wj7l6xd2/WYYTmS
         fxKLxuRsVGSJNILxPRAmdss/VDHUaBqTdDIyCagVM05ymRB9UtC8MgEyRO9JLkbFtLj+
         d6wwkovdTTp33TIisjmVARFhT+O+jJsvXYMGsuC+o4et8/m43KqrUEFWab6gQEWKcUMF
         jCqKhbIF8kKuBM4FV6h8qeTLTkABzhpTV5LBGEHwRAUR8d4AkBJ1hKj0ORkpVUrPmI2o
         OV4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=orovRDlwPW3OzyVD6i3ZoLTsKlLomXgDByozZGlTWIw=;
        b=ZBmv4NOzHhfrjya3lP0HGzW7MycUHH2ZNbWiBlcLZqSPS88oESoRv9I+M4UDunI8RQ
         X3RjGN/p33vILuG43OjwF8ZtlTfdydFZHcFhUmwHC5cXrtPno3TLyL398FvN0y/BoSoX
         54ecMTZPbQ4p6hz5zEd56396odhZIq2uxkyTEZ3M+J7FNaB6dduIXsevYqy68qwqXpy0
         vhyjXJql1OFIszPa9UrlPHlaPFpRTi/5dmey8/9VI2x9KBP/S9y4sxi0Z3WsXLiACi0S
         Ju2vyFQgKbJkKoCuEnm51W02V1NYJPYQ8d3B+93sT30iREj/+38EL9eASRc89Lq1KzS/
         jUhw==
X-Gm-Message-State: AOPr4FV7eugGSHk+IUsbdHhrUCH5XYE+t+sdRUprpnc16QZwUB2c+ppeCbpX9JU00A6MoBkSynhJEPktCc7JFg==
X-Received: by 10.37.68.137 with SMTP id r131mr17028599yba.22.1462732811379;
 Sun, 08 May 2016 11:40:11 -0700 (PDT)
Received: by 10.129.162.144 with HTTP; Sun, 8 May 2016 11:39:52 -0700 (PDT)
In-Reply-To: <xmqqk2j4z9wm.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293974>

> git config alias.bl "blame -w -M -C"

Indeed, that would do the trick when interacting with git directly.
However, I am interested in something that would provide a consistent
git blame across all tools that integrate with git, such as GUI tools
and editor integrations like Fugitive.
