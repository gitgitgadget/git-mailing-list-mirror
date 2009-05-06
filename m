From: Jacob Beard <jbeard4@cs.mcgill.ca>
Subject: git svn import missing tags
Date: Wed, 6 May 2009 18:46:32 -0400
Message-ID: <8e648abd0905061546s52dcd36fu94b46bf72cc991d1@mail.gmail.com>
Reply-To: jbeard4@cs.mcgill.ca
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 07 00:47:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1ptG-0002vB-FR
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 00:47:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbZEFWqx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2009 18:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbZEFWqx
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 18:46:53 -0400
Received: from mail-qy0-f125.google.com ([209.85.221.125]:58118 "EHLO
	mail-qy0-f125.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751041AbZEFWqw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2009 18:46:52 -0400
Received: by qyk31 with SMTP id 31so742352qyk.33
        for <git@vger.kernel.org>; Wed, 06 May 2009 15:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:reply-to:received:from:date
         :x-google-sender-auth:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=3HLqtmuiADiSKvZqh0MO5OLkiwSf75wWS4/oEU1vThk=;
        b=qm1WyiEysfyjJ42YqYx8IzIZapdEuu3BunQAUdpYVqiOl5CfdRmCha5MfeYIkqAmOW
         sq/LH0tUlnhdRlqGMKQiVprpbTOTMX74CV9EFyuCvOwDcDpGCiWL+jo1not3SjDetULd
         wPMF63NpCxxPJabjURcQBbUll+gSyTvO+kFII=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:reply-to:from:date:x-google-sender-auth
         :message-id:subject:to:content-type:content-transfer-encoding;
        b=Z32ZeYd8dPDJg0ZIH2Y95NuhvlNROg9DkKrnA1cz6IqfQ6ayL/UjhzRwj7KhlyS6BR
         6mSNxFX/3EtDa6foJxeCrhVz9ivdqAwnZN1j3JIKFbQtUTxVlCfwzchUTY0A34pJ/ys6
         S4vzIkYSkJIRWN9S33X4HQgzl/qhkDwIMGM+8=
Received: by 10.229.86.196 with SMTP id t4mr1670676qcl.39.1241650012124; Wed, 
	06 May 2009 15:46:52 -0700 (PDT)
X-Google-Sender-Auth: 7fcfeede1864aaaf
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118397>

Hi all,

I just tried using git-svn clone to import the GWT SVN repo, located at:

http://google-web-toolkit.googlecode.com/svn/

GWT has a standard SVN structure, and so I imported it using:

git-svn clone --stdlayout http://google-web-toolkit.googlecode.com/svn/

You can see here, that GWT has the following tags:

http://code.google.com/p/google-web-toolkit/source/browse/#svn/tags

# 1.3.1
# 1.3.3
# 1.4.10
# 1.4.59
# 1.4.60
# 1.4.61
# 1.4.62
# 1.5.0
# 1.5.1
# 1.5.2
# 1.5.3
# 1.6.0
# 1.6.1
# 1.6.2
# 1.6.3
# 1.6.4

Unfortunately, these are the branches that I get after using git's svn import:

jacob@jacob-laptop:~/workspace-gsoc/gwt/svn/user/super/com/google/gwt/emul/java$
git branch -a
  oophm
  opt_imgs_and_startup
  tags/1.3.1
  tags/1.3.3
  tags/1.3.3@288
  tags/1.4.10
  tags/1.4.59
  tags/1.4.60
  tags/1.4.60@1399
  tags/1.4.61
  tags/1.4.61@1504
  tags/1.4.62
  tags/1.4.62@2104
  tags/1.5.0
  tags/1.5.0@2941
  tags/1.5.1
  tags/1.5.1@3391
  tags/1.5.2
  tags/1.5.2@3587
  trunk

It is missing all of the tags after 1.5.2

I am using git version 1.5.4.3, from the Ubuntu 8.04 repo.

I'm a git newb, so I expect I'm forgetting to pass in an extra flag or
something, but I'd appreciate it if someone could point me in the
right direction.

Thanks,

Jake
