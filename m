From: Aghiles <aghilesk@gmail.com>
Subject: git push in --tracked branches.
Date: Wed, 21 Apr 2010 20:02:49 -0400
Message-ID: <y2w3abd05a91004211702qf4cd42bau20ac52a4d35a6bf1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 22 02:03:21 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4jt1-0000kn-Gs
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 02:03:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754245Ab0DVADN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Apr 2010 20:03:13 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:41532 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753106Ab0DVADM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Apr 2010 20:03:12 -0400
Received: by wwb24 with SMTP id 24so4450624wwb.19
        for <git@vger.kernel.org>; Wed, 21 Apr 2010 17:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:received
         :message-id:subject:to:content-type;
        bh=Zj6ITmS/7FA7umLyyBxN6rr4lNrRD1CVwkc9DbyaFBc=;
        b=Xj0x1D9npTLa8H3oj1G+hJieHV/mfDg6PiDSrfuHnTx/3dgtL2qYhsTam+ElzuyQ+H
         Ec1f3dIH2cSQux0k4TRqL4ykBH7MpzZpGyRPpWpyWnsUjU+jZVcHZyz9BGLHSYb8Yk8V
         lzKrL9B4E0mz4ulfOuSeQdRAU3+TLV+8Ri2Lo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=cNP/EfkcQ4ZADCCIELZuO4xahhUtYNM+Rusu6vQshtueoaC7qjnhUfZVdD/hhrlFbb
         lbfKa2vKYWQ9SMJjgeBYkQdu6Y1cXk6GMqdkpWtc09ce1fgn4hs9b/g2ce7Yy6xw8oZx
         5hF3C1jVczTapezFR0NifZHv4KgypzGG/vqpc=
Received: by 10.216.157.212 with HTTP; Wed, 21 Apr 2010 17:02:49 -0700 (PDT)
Received: by 10.216.90.201 with SMTP id e51mr2573709wef.72.1271894589192; Wed, 
	21 Apr 2010 17:03:09 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145479>

So I created a branch that tracks 'origin' which is remote:

  git checkout -b small_fixes origin

I can do a 'git pull' and everything works as expected. I did some
commits in this branch and I issue a 'git push'. To my surprise
the 'git push' is still operating on the master and not the current
'small_fixes' branch! What is the rationale behind this ? I would
expect to push from my current branch to origin (especially that
I am --tracking origin).

  -- aghiles
