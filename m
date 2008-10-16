From: "Richard Hartmann" <richih.mailinglist@gmail.com>
Subject: commiting while the current version is in conflict
Date: Fri, 17 Oct 2008 00:10:55 +0200
Message-ID: <2d460de70810161510ha220593g4615a55b2c3e3b25@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 17 00:12:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kqb4k-00034p-Hh
	for gcvg-git-2@gmane.org; Fri, 17 Oct 2008 00:12:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757645AbYJPWK5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 18:10:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757600AbYJPWK5
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 18:10:57 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:50871 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757505AbYJPWK4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2008 18:10:56 -0400
Received: by gxk9 with SMTP id 9so366494gxk.13
        for <git@vger.kernel.org>; Thu, 16 Oct 2008 15:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=GglZj+P9CSr+DMJPj5v956y9aZRw7KBTZximcvb1bgs=;
        b=MzP2x17u78vdbP2LERp0FW8P2dT5ntZu9iqlHpT6b5o0ypyvFxQDaIaPpzHfDL89/m
         qyRdVCRILJHHvXhg3vKDoW8Aud4/t3fjZYnfxHYTEwmcNFeJ5SkbPVyjIpyyGch6QNpO
         A5aCUxYol/WzUJM1PYYOM3147KqrO+nuw0hGE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=BQvfxjv1///b/wdK0c1gRsYFhoMB9lk2fS19OyGx1/CLg0n3NFGl5UBWT8BCrDS2OC
         c+lVFP/c9/0nYJSbcd2cFiqqGJW2Cj9Qs1DJx+sjWvl20WYBnfWKnw35WpsIvnY22i4S
         GK0v28YCrh09Rs4E/pS7NY7465gidSEa5JecQ=
Received: by 10.100.6.19 with SMTP id 19mr4397441anf.90.1224195055054;
        Thu, 16 Oct 2008 15:10:55 -0700 (PDT)
Received: by 10.100.43.19 with HTTP; Thu, 16 Oct 2008 15:10:55 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98430>

Hi all,

I fooled around with git a liitle bit and noticed something
rather strange. I merged two branches, creating a conflict
on purpose. When I then did a

 git commit -a

all changes were submitted. Of course, I now have a
file with the conflict markers inlined in my repository. Not
a good thing, imo. Is there a way to make git block all
conflicting versions?

Also, I would be interested in the design decissions
behind the current behaviour. Any pointers?


Thanks,
Richard
