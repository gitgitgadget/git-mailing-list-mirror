From: Alex MDC <alex.mdc@gmail.com>
Subject: Re: Unhappy git in a jailshell?
Date: Wed, 4 Nov 2009 12:17:03 +1100
Message-ID: <130714cd0911031717q7aa68a33wec501aec066d228d@mail.gmail.com>
References: <130714cd0911020416r6a686026q697d843f47b68692@mail.gmail.com>
	 <20091102124746.GA27126@dpotapov.dyndns.org>
	 <4AEEE3D2.9040905@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>,
	Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 02:17:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5UUo-0007RY-Hp
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 02:17:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752166AbZKDBQ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2009 20:16:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751707AbZKDBQ7
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 20:16:59 -0500
Received: from mail-pz0-f188.google.com ([209.85.222.188]:48877 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751170AbZKDBQ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2009 20:16:58 -0500
Received: by pzk26 with SMTP id 26so4348170pzk.4
        for <git@vger.kernel.org>; Tue, 03 Nov 2009 17:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=aLKprJmvsdIg+caD4aPcQYhIs7lYBoI5YYbG/c0mhkU=;
        b=Epud7quYPXwyDrx4HGanMCXhbdZvea3zXyTGW3h91gKaDusHuO2YbVDWYSDFLAUL2s
         W/UWecAiWwP0Aa/Og5asFYZPQopplqtd5nqh3jis9c6DiPBb7ihLm8K7AASvaSFcweac
         zY2XEEhrEFR411jdpq+mJB/MLeLV5qCfUYvWE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=KTFXKI5vXhgKDQawSzH/OdUyg4mW2cMafF4ZU2VZgwJuUOTw+sQEOWy1lPsqgWWva4
         GdpPE4fs3ImDpClzc30V+t3/AqB3GXQrGbMx0OF9vS5rDFGdDfNDajzTcTlPM2+8HqNB
         4d8qpEaBjjZqitaXooCmZdcNhif11GZeIHaiw=
Received: by 10.142.5.27 with SMTP id 27mr82166wfe.59.1257297423771; Tue, 03 
	Nov 2009 17:17:03 -0800 (PST)
In-Reply-To: <4AEEE3D2.9040905@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132018>

Hi guys,

I requested the admins allow access to the `git --exec-path` directory
from the jailshell and incredibly, they granted it! Now everything is
working and "git --help --all" lists all the commands as expected, so
that was indeed the problem.

It was just a bit deceiving at first that some git commands were
working but others weren't, but Dmitry explained that one.

Thanks for your help,
Alex
