From: Drew Northup <n1xim.email@gmail.com>
Subject: Re: git push tags
Date: Sun, 28 Oct 2012 19:58:20 -0400
Message-ID: <CAM9Z-n=VGiio0V=SmyXmSA9cBhqGjXaEGfAvh3wLQR+eDQpNNQ@mail.gmail.com>
References: <CAB9Jk9DMOwhDf3SvMzTmTZiyZg_4pgXx-evrfWkB3U4w-KqtVw@mail.gmail.com>
	<508D7628.10509@kdbg.org>
	<CAEUsAPYREy=CvPxy_Mzh5icVQo3=NV-AMC096Op0WWODLPH47Q@mail.gmail.com>
	<4B8097A9D6854CDFA27E7CF6574B37BA@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Chris Rorvick <chris@rorvick.com>, Johannes Sixt <j6t@kdbg.org>,
	Angelo Borsotti <angelo.borsotti@gmail.com>,
	git <git@vger.kernel.org>, Kacper Kornet <draenog@pld-linux.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Mon Oct 29 00:59:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TScky-00010g-RH
	for gcvg-git-2@plane.gmane.org; Mon, 29 Oct 2012 00:59:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754681Ab2J1X6W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2012 19:58:22 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:54860 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753489Ab2J1X6W (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2012 19:58:22 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so1741365bkc.19
        for <git@vger.kernel.org>; Sun, 28 Oct 2012 16:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ne0DREsy4y31K0IiFl8kqkEDn8JOK+Ty4epIIaa+fLQ=;
        b=pgNtHB8DxDVAOBRZnqKAzQhAmbn7rSB5wCsGmEBcUgCU20GrXN5VkDlvVPagrQ7b/B
         yzld9yvZw7Qh5bASB9D5uFZkgamQt8N36sJxSpZXPo0wZtoXtydGi5PhANhn8VdB1BlS
         DoRUAbtL4u9bV0o++RiuBSmlwhx+Z7oxt2lSriR821F96wmr8ZohCRpdPu7zik0U9LkC
         01CmSfKUrjijDDsadB9iFMaBOeDdmM2w+sTsrkDMLyHooq6ZqGto0+3GNHKGP1e31xBk
         PnfhmbUNE6Bdkhi3o7h8AhLrx7yeoTIwJYDprFsmjfZqHVbDrQ/K641XYDx682K1lPqC
         k9lg==
Received: by 10.204.11.70 with SMTP id s6mr8989272bks.63.1351468700498; Sun,
 28 Oct 2012 16:58:20 -0700 (PDT)
Received: by 10.205.122.144 with HTTP; Sun, 28 Oct 2012 16:58:20 -0700 (PDT)
In-Reply-To: <4B8097A9D6854CDFA27E7CF6574B37BA@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208577>

On Sun, Oct 28, 2012 at 5:49 PM, Philip Oakley <philipoakley@iee.org> wrote:

> If I read it right it was where two users can tag two different commits with
> the same tag name [e.g. 'Release_V3.3'] and the last person to push wins, so
> anyone in the team can change what is to be the released version!

Philip,
Please look at Kacper's patch and Angelo's response to it. He seems to
be asking that tags not be permitted to be pushed as if doing so were
a "fast-forward" update.

This weekend I was, in part, trying to figure out what the correct CC
list for that patch would be, what the documentation change would be,
what changes would need to be made to the advice, what test would need
to be included, and so on to build a proper patch bundle. All of that
while tring to keep the house from "falling in" (I've been doing some
cleaning) and prepare for the Northeastern USA Coast to be doused and
blasted by Sandy in about a day and a half. If we decide to continue
in the path that Kacper and I have stumbled upon (with Angelo's
prodding) I'd appreciate a little help putting all of this together to
mesh with the aforementioned patch. (Heck, if there's somebody better
than me to take this over I'd be game for that too...)

-- 
-Drew Northup
--------------------------------------------------------------
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
