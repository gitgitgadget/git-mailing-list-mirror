From: John Szakmeister <john@szakmeister.net>
Subject: Credentials and the Secrets API...
Date: Thu, 27 Oct 2011 12:05:03 -0400
Message-ID: <CAEBDL5Udooim_3Za76Q1Rt_aGXtsSv76nxRegGWRBE=WJQzfZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 27 18:05:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJSS8-00085Q-FG
	for gcvg-git-2@lo.gmane.org; Thu, 27 Oct 2011 18:05:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752792Ab1J0QFF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Oct 2011 12:05:05 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:54678 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751235Ab1J0QFE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Oct 2011 12:05:04 -0400
Received: by vcge1 with SMTP id e1so2601771vcg.19
        for <git@vger.kernel.org>; Thu, 27 Oct 2011 09:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        bh=egkmMS86TB70oCb5LvYzQiJPv7iITxIaUpjgtxJEIUg=;
        b=a+ukva4+06yBy35/QGe7kBKbBZLFXTW/73o17Bcbz8ZkgfGaKIdDGsQHDabDhbOus6
         Jq6V7osj8h6FWf2+zB0WdJraL9FpExUMgprf5AgkwH3dCTRgR1SRBlPJl3VScW+tsXdg
         Kakr1NB4NcYLMKi/zOwCA7Ta24jzvrwY4L3tI=
Received: by 10.220.154.11 with SMTP id m11mr1071578vcw.133.1319731503357;
 Thu, 27 Oct 2011 09:05:03 -0700 (PDT)
Received: by 10.220.94.67 with HTTP; Thu, 27 Oct 2011 09:05:03 -0700 (PDT)
X-Google-Sender-Auth: zxvbMBShjJnDqFaFXjmEhealats
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184298>

Just wanted to keep folks in the loop.  It turns out that the Secrets
API is still to young.  I asked about the format to store credentials
in (as far as attributes), and got a response from a KDE developer
that says it's still to young on their front.  They hope to have
support in the next release of KDE.  But there's still the issue of
what attributes to use.

With that information, I went ahead and created a
gnome-credential-keyring that uses Gnome's Keyring facility.  I still
need to do a few more things (mainly run it against Jeff's tests), but
it's generally working.  Just wanted to keep folks in the loop.
Hopefully, I can get patches out this weekend.

Jeff: it would be really excellent to break out the various pieces.  I
think it would also be better to split the asking for passwords from
the storing of passwords.

-John
