From: Igor Lautar <igor.lautar@gmail.com>
Subject: Re: commit gone after merge - how to debug?
Date: Mon, 26 Nov 2012 18:01:25 +0100
Message-ID: <CAO1Khk9oNoCpAmWaEfew1K976B+8bn+R6XMi3vGtH-Vj3TJMqg@mail.gmail.com>
References: <CAO1Khk_eugH--wp3s-gr4HTvuRyL=SaWHWtEXCRZ_Ak7+s5U=w@mail.gmail.com>
	<1353935441-ner-9639@calvin>
	<vpqr4ngsdjl.fsf@grenoble-inp.fr>
	<CAO1Khk9mzJjnysnc1iDFeMgqnRq0z35t0kgC-8nrsjJ-oOvdOg@mail.gmail.com>
	<vpqehjgscv3.fsf@grenoble-inp.fr>
	<CAO1Khk8=nrKknfqY-k6XaGPDbLrHyrK-8fxfB7XXUWeB7L4EUA@mail.gmail.com>
	<vpqa9u4pgew.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Tomas Carnecky <tomas.carnecky@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Nov 26 19:18:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Td3Fr-0007Rg-9U
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 19:18:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756212Ab2KZSRp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 13:17:45 -0500
Received: from mail-vc0-f174.google.com ([209.85.220.174]:59013 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756144Ab2KZRB1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 12:01:27 -0500
Received: by mail-vc0-f174.google.com with SMTP id m18so7885172vcm.19
        for <git@vger.kernel.org>; Mon, 26 Nov 2012 09:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=pOP2cXe1LmjPG1UkDi1yUfVwKKEbiRVNrK2gfqntADU=;
        b=EA5yJK/HE0RmIaDmllE8Cf8fEdzJDHHTqQtNwPE3TJhLS8nq1MJybdmG4N1Zr8Gfjy
         JE6l8CPXqLAvP45TsmrasJ0vPVyeH4N2+5AoQuPRun45aX/DuSxI0HK3JEtpovgLE3Ww
         Ld4siKmAdVLopZ1nau7SsCYHuEN2BmL/iMchydmUC1BlFhFfxOhUnAafVWrPES5rRLeJ
         yMnntaswXr4Z7UFh9TiTKbWMpt7q+QURMGY2gWA0GBdLvWAEYf/PEAXRnnAEOxvtqTtO
         hUHYkvuTNW4BtmWU35fj4rrz0xXHcsm+LMMBgEoQ3oR3JSgkMEvHlN7GFiu1gHV7HhXA
         SPHQ==
Received: by 10.58.116.212 with SMTP id jy20mr20503230veb.5.1353949285614;
 Mon, 26 Nov 2012 09:01:25 -0800 (PST)
Received: by 10.58.69.112 with HTTP; Mon, 26 Nov 2012 09:01:25 -0800 (PST)
In-Reply-To: <vpqa9u4pgew.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210465>

On Mon, Nov 26, 2012 at 3:50 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> What's possible is that someone had already merged the branch containing
> "new", got conflicts, and resolved it in favor of "old" somewhere in the
> history of your master branch.

This is exactly what happened. I've actually found a merge of origin
to mirror which reversed the change some time back and was
subsequently merged back to origin later on. Most probably human error
during merge.

Interestingly, this was my first thought as well, but I've must have
overlooked that particular merge the first time.

Anyhow, it sorted now, many thanks for your help,
Igor
