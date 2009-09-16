From: mr.gaffo@gmail.com
Subject: [PATCH JGit] Adding update-server-info functionality try2
Date: Tue, 15 Sep 2009 19:48:31 -0500
Message-ID: <1253062116-13830-1-git-send-email-mr.gaffo@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 16 02:54:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mniml-0001mq-RD
	for gcvg-git-2@lo.gmane.org; Wed, 16 Sep 2009 02:54:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751614AbZIPAx7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2009 20:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751471AbZIPAx6
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Sep 2009 20:53:58 -0400
Received: from mail-qy0-f182.google.com ([209.85.221.182]:52578 "EHLO
	mail-qy0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751195AbZIPAx6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2009 20:53:58 -0400
X-Greylist: delayed 308 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Sep 2009 20:53:52 EDT
Received: by mail-qy0-f182.google.com with SMTP id 12so3798556qyk.6
        for <git@vger.kernel.org>; Tue, 15 Sep 2009 17:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer;
        bh=iZ6Pw7U4HXfelRLzQaR0xBAY/s53wdIcI44QO0T9HTI=;
        b=drDL9w7zQz2YNFH1d9DmLFUoxXBFyCe5YJZWkCOJpuSVqXa8GBmdFEgNPwEWJp/uWx
         O4Ttfl8J/4EFgYmr6XWiT0X/GS+/kqH5G0TDI6aQOF6bBTbVELCEeY4OnQ5AS0rg9MNy
         579xGWwB/c64TaWurpxQhXwPaNg5iDe1yB6S8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer;
        b=vOW+ngMMg9YZETLKZIyLqGfrzhPYsSmfVZD5MCIQpeKrVbR9MT3878uUZlq0mvT/Wd
         SknQ8JmiIQQINAC8a+ZxEdey4bBsadtIR/JOW/usj++Q7rjhtxn3eQ0K2nlZ9Vlqda7O
         k9jV6+cDS+SfQATtQLd0YwC2S8Ng7yX0S1We0=
Received: by 10.224.23.10 with SMTP id p10mr6847795qab.72.1253062124685;
        Tue, 15 Sep 2009 17:48:44 -0700 (PDT)
Received: from localhost.localdomain (nat.asynchrony.com [66.236.120.131])
        by mx.google.com with ESMTPS id 4sm173278qwe.5.2009.09.15.17.48.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 15 Sep 2009 17:48:44 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128597>

This patch series implements update-server-info functionality
in JGit and integrates it with ReceivePack so that repositories
hosted by git-http can also be hosted by JGit.

It also incorporates suggesions from RobinRosenberg.

Please be gentle.
