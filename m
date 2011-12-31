From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git alias question
Date: Sat, 31 Dec 2011 15:30:00 -0800 (PST)
Message-ID: <m3zke8e2vh.fsf@localhost.localdomain>
References: <CAFLRbopjqW7OEWN4kxy+6Gb828h4zBC_h=4WiP-q1__LeezxUw@mail.gmail.com>
	<CAD0k6qTp9sKCb==Jh1vuLuZoxx99Kt2Z=VAbjYbGaUE7nbOxdQ@mail.gmail.com>
	<CAJDDKr5a8TB82h4ULWtamLOVu_4Fv+cGw1YfEL987gM3yM4TMg@mail.gmail.com>
	<CAFLRborAuoWKxOeHtPRujSYbQPk67RCxTiVBavtWDeh-Byfa2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>,
	Dave Borowitz <dborowitz@google.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Michael Horowitz <michael.horowitz@ieee.org>
X-From: git-owner@vger.kernel.org Sun Jan 01 00:30:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rh8NO-0000Qd-BW
	for gcvg-git-2@lo.gmane.org; Sun, 01 Jan 2012 00:30:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753364Ab1LaXaE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Dec 2011 18:30:04 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:64024 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753251Ab1LaXaC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Dec 2011 18:30:02 -0500
Received: by eekc4 with SMTP id c4so14504952eek.19
        for <git@vger.kernel.org>; Sat, 31 Dec 2011 15:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=MzArfe9U+Nd2HGCSN0VIupgpsdzOta2S5sf3ZQD8S0g=;
        b=kvrzakPnSzRLTqLDHDxRsV7kOa/EVCpNVdGy53uBprpPM5FbORtcRDIhIsttrHom/2
         WGB0sGlkVTDoX3qVKofYKc2Ph1V2schavNjLzsBVO6moTZRPgVy/QH5h8ZiyfFanHeMz
         hsTK4Wo9s83+ltTejAuXM8uqPiEW4i86OhQmo=
Received: by 10.14.122.136 with SMTP id t8mr18175924eeh.36.1325374201617;
        Sat, 31 Dec 2011 15:30:01 -0800 (PST)
Received: from localhost.localdomain (abwr197.neoplus.adsl.tpnet.pl. [83.8.241.197])
        by mx.google.com with ESMTPS id z43sm169063250eef.7.2011.12.31.15.29.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 31 Dec 2011 15:30:00 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id pBVNTu04005661;
	Sun, 1 Jan 2012 00:29:56 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id pBVNTtBT005658;
	Sun, 1 Jan 2012 00:29:55 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <CAFLRborAuoWKxOeHtPRujSYbQPk67RCxTiVBavtWDeh-Byfa2w@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187818>

Michael Horowitz <michael.horowitz@ieee.org> writes:

> The log operation does seem to make the most sense as the mechanism to
> search for the results.  Making it work with difftool would work...
> Not sure if "--log" to difftool or some other options as suggested in
> the other thread would be most consistent UI-wise as stated, but
> either would work for me.
> 
> On a separate note, some environment variable like GIT_PREFIX with the
> CWD would make the alias functionality more flexible.

1f5d271 (setup: Provide GIT_PREFIX to built-ins, 2011-05-25) is
present in v1.7.7; 7cf16a1 (handle_alias: provide GIT_PREFIX to
!alias, 2011-04-27) is in 1.7.6

-- 
Jakub Narebski
