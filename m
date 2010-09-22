From: skillzero@gmail.com
Subject: Restore annotated tag?
Date: Wed, 22 Sep 2010 11:14:28 -0700
Message-ID: <AANLkTinafiikD0Lzgw2gw1ti2pCK6cSTk5bQZFcCRJnS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 22 20:14:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyTq0-0000fU-Of
	for gcvg-git-2@lo.gmane.org; Wed, 22 Sep 2010 20:14:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753850Ab0IVSOa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Sep 2010 14:14:30 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:44925 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753083Ab0IVSOa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Sep 2010 14:14:30 -0400
Received: by wyb28 with SMTP id 28so116332wyb.19
        for <git@vger.kernel.org>; Wed, 22 Sep 2010 11:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=8AfZHHP4FdSAj4TlYHg2Xa5jQIueciqYa1CpNHwTYII=;
        b=xGozvUmX9WPhVzZsgy9li8L9AdPRJeIeQe3DbDOm3MKRJgVjF4rEZ7VH8VnAFO28fx
         sg1uRgheSGLaKEHhNI+TdVxdM18n9z1wKEw2bYKNcd4fvjmq6r9jjNoKcasyh8tkawLV
         l7UnuVXParcpqUiiQO13IMmEkxEYk6q0j9OQE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=LOCpZ0kTpQwTGjKHzsKyImv5c85II5ZVRAhew7iZ3BjB8fmSVhV84MQJuGN/pWlUEa
         NTPQax8kKSNBoqjj0TC5Krgg5Nm4KZDxKSAoQFxZH4rqYaALEq2oU122fb0thY65juwQ
         ML1XXUkU7eFgwPBb0+hUsqkock13ZA80Ilo6g=
Received: by 10.227.134.206 with SMTP id k14mr529324wbt.121.1285179268700;
 Wed, 22 Sep 2010 11:14:28 -0700 (PDT)
Received: by 10.227.135.202 with HTTP; Wed, 22 Sep 2010 11:14:28 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156817>

Is there a way to restore an annotated tag? One was accidentally
deleted and pushed. I can restore normal tags by just using git tag
again, but for an annotated tag, there's a tag object and I'm not sure
how to restore it.
