From: Paul Sokolovsky <paul.sokolovsky@linaro.org>
Subject: Excluding some refspecs from git push?
Date: Sun, 24 Jul 2011 00:46:50 +0300
Organization: Linaro
Message-ID: <20110724004650.408741c5@x34f>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: repo-discuss <repo-discuss@googlegroups.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 23 23:47:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qkk2M-0002Cv-45
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jul 2011 23:47:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421Ab1GWVrB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jul 2011 17:47:01 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:65164 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751297Ab1GWVrA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jul 2011 17:47:00 -0400
Received: by fxd18 with SMTP id 18so6952567fxd.11
        for <git@vger.kernel.org>; Sat, 23 Jul 2011 14:46:59 -0700 (PDT)
Received: by 10.223.21.219 with SMTP id k27mr1963612fab.54.1311457618886;
        Sat, 23 Jul 2011 14:46:58 -0700 (PDT)
Received: from x34f ([95.15.169.226])
        by mx.google.com with ESMTPS id 28sm2864552fax.3.2011.07.23.14.46.57
        (version=SSLv3 cipher=OTHER);
        Sat, 23 Jul 2011 14:46:58 -0700 (PDT)
X-Mailer: Claws Mail 3.7.6 (GTK+ 2.22.0; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177706>

Hello,

Is there a way to exclude some refspec from being processed by "git
push"? What I'm looking for is a syntax like:

push some-remote 'refs/*' '!refs/meta/config'

, with the meaning of "push all refs except refs/meta/config". What I'm
trying to do with this is to find out a generic way to mirror git
repositories managed by the Gerrit tool
(http://code.google.com/p/gerrit/), which since version 2.2 uses
refs/meta/config branch to store repository-local configuration, so
should not be mirrored between two Gerrit's.

-- 
Best Regards,
Paul

Linaro.org | Open source software for ARM SoCs
Follow Linaro: http://www.facebook.com/pages/Linaro
http://twitter.com/#!/linaroorg - http://www.linaro.org/linaro-blog
