From: Tuncer Ayaz <tuncer.ayaz@gmail.com>
Subject: correct git merge behavior or corner case?
Date: Mon, 20 Apr 2009 00:40:51 +0200
Message-ID: <4ac8254d0904191540j68246cd8qa36a034209d4c800@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 20 00:42:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lvfin-0002IL-U7
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 00:42:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752040AbZDSWlL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Apr 2009 18:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751909AbZDSWlI
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Apr 2009 18:41:08 -0400
Received: from mail-ew0-f176.google.com ([209.85.219.176]:64729 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751744AbZDSWlH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Apr 2009 18:41:07 -0400
Received: by ewy24 with SMTP id 24so935440ewy.37
        for <git@vger.kernel.org>; Sun, 19 Apr 2009 15:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:content-type:content-transfer-encoding;
        bh=fxQEkVfgfPNpMJ7xwX6r2mmKJNNB3Obh2av30W03/ow=;
        b=UnbRoxMGI8lOqHPoEYvUedMtYS1iI1R5bKUBazjFJBrJ9ploWr9XmTbAYTJZXJaYW1
         DMCSHWwFjDoZwQffWmDxUVuca6GyuDiMZZBfBlJ8aeGlN1bcr0MCradYlvwjicLF33+P
         2WV2J7armI0iAFj6Use7y2YgEIamiVxD2rs74=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        b=aTyorcdXir5SQNZ5pkAfcfXn+3E2F+L6m6xg16Z7yxDzyCwMCuOmhSViXrsNaXm7fd
         YFeTiWqkehrjJ+9AdqMUE1oJsfIUoGZKFJs6t+Xac48pXqCWdytCHZGaorJDDWWWWc8k
         Xa29YshiOm/yCC2kaupZMt0hi2xeBLv33nQVo=
Received: by 10.210.76.4 with SMTP id y4mr3047155eba.12.1240180866171; Sun, 19 
	Apr 2009 15:41:06 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116917>

I have stumbled upon the following blog post via one of
the news aggegrators and wondered whether the behavior
is correct and expected or he's expecting something wrong
or doing something wrong.

I cannot see a wrong usage pattern from what he has written.

http://blog.teksol.info/2009/04/15/beware-of-gits-content-tracking.html

as the author hasn't posted here after a couple of days
I decided to take his question here for at least understanding
what behavior he is experiencing.
