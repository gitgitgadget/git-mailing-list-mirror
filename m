From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: pack operation is thrashing my server
Date: Mon, 11 Aug 2008 11:30:04 +1200
Message-ID: <46a038f90808101630k4bcdef91h64189a2991106174@mail.gmail.com>
References: <a6b6acf60808101247r4fea978ft6d2cdc53e1f99c0e@mail.gmail.com>
	 <46a038f90808101606j7534b855j9205ae219c350c94@mail.gmail.com>
	 <a6b6acf60808101612l300227e9od97e767fe4621dc5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Ken Pratt" <ken@kenpratt.net>
X-From: git-owner@vger.kernel.org Mon Aug 11 01:31:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSKNr-0007JY-Hx
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 01:31:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754741AbYHJXaH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 19:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754770AbYHJXaH
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 19:30:07 -0400
Received: from wf-out-1314.google.com ([209.85.200.170]:49482 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754741AbYHJXaF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 19:30:05 -0400
Received: by wf-out-1314.google.com with SMTP id 27so3501919wfd.4
        for <git@vger.kernel.org>; Sun, 10 Aug 2008 16:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=wwzv0v41h/xDQ6MAdx3M3jy40Yf0peT8hBR+9ccKKCE=;
        b=W8TSi9RKS21wMZa+Eeh2ttNrtBcr5pKn46mF4DB1UNiaGd/KJLOOiRODfNReOtZC13
         EuPYEgug1y3zSX7i4CY6AEFW2wdpOFI/c1JfRTh1b394oHT56bWKnhbaMLlHKEjR7kku
         Y77Anj5xt2f9BYgWtZdShzf46qy4hSo74ddW8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=XuqoXI34SqEHK22SxmDH462hv7Hmmw7u2OsdzqI+L54/c6yEdCvOQO3pSVTBOZKwmv
         iJjKFEWajWjRbWdDYeg4TraJsxiXrUN+5ooDtU6MgRztlFy+eQkB38xLMdp2LdaSLELc
         Ixqt6lO4zFKDSI/Z4iqNKmxLvUALxm9hPv438=
Received: by 10.143.42.3 with SMTP id u3mr1871026wfj.148.1218411004934;
        Sun, 10 Aug 2008 16:30:04 -0700 (PDT)
Received: by 10.142.43.6 with HTTP; Sun, 10 Aug 2008 16:30:04 -0700 (PDT)
In-Reply-To: <a6b6acf60808101612l300227e9od97e767fe4621dc5@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91903>

On Mon, Aug 11, 2008 at 11:12 AM, Ken Pratt <ken@kenpratt.net> wrote:
> Thanks for the tips, Martin.

NP! :-)

> How does git over rsync work? It is unauthenticated, like git over
> http? Or authenticated, like git+ssh?

I've always used it as rsync+ssh. Not sure about bare rsync.

> Great ideas though. Unfortunately I don't think I'll be able to use
> the repack locally and then upload strategy for this particular
> workflow, but the rsync clone approach might do it.

A few specific versions of git had bad repack cpu/memory usage
patterns, so an update to git might help. In any case, the repack
machinery experts are probably asleep. Give it a bit of time and
smarter answers will probably materialise.

cheers,


m
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
