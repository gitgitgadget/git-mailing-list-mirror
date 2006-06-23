From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: git-format-patch builtin isn't using git-cherry?
Date: Fri, 23 Jun 2006 12:32:01 +1200
Message-ID: <46a038f90606221732k6d93bcceic2761081d7a7c72b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Jun 23 02:32:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtZah-00029O-9e
	for gcvg-git@gmane.org; Fri, 23 Jun 2006 02:32:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932230AbWFWAcE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Jun 2006 20:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932734AbWFWAcE
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jun 2006 20:32:04 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:56797 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932230AbWFWAcD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jun 2006 20:32:03 -0400
Received: by ug-out-1314.google.com with SMTP id a2so773289ugf
        for <git@vger.kernel.org>; Thu, 22 Jun 2006 17:32:01 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=DKFw038nfw9VOAc3pcqJ6X1RsRpXJnSbdV50bIcfCONRqblX2wZqSlaFU1/NWTQkz+1nLqy5ykLSlAWTrVOhykWxYNkgCdsoY0dwDW7nt7HV+YSKHV59GlLDOSsy+XTf1HB5S26XYjgDCT0k3weLXsaKsi2NedgndtKMLx9ZHe4=
Received: by 10.78.139.5 with SMTP id m5mr1092559hud;
        Thu, 22 Jun 2006 17:32:01 -0700 (PDT)
Received: by 10.78.117.11 with HTTP; Thu, 22 Jun 2006 17:32:01 -0700 (PDT)
To: git <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22389>

I used to rely on git-format-patch to be calling git-cherry in the bg,
so that I'd know that the obviously merged patches were upstream
alredy. It doesn't seem to do it any more.

Reading cmd_format_patch() in builtin-log.c, it seems to have lost
that magic that made it so useful... :( Can a kind soul that speaks C
fluently help me out here?

(The new format-patch gives me 180 patches to merge/rebase, where the
old one tells me there's only 51. guess which one I prefer ;-) )

cheers,



m
