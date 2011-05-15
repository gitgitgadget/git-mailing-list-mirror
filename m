From: Zganyaiko Dmitry <zdo.str@gmail.com>
Subject: GLib
Date: Sun, 15 May 2011 19:36:17 +0300
Message-ID: <1305477377.3612.5.camel@mamburu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 15 18:36:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLeIx-00062c-SX
	for gcvg-git-2@lo.gmane.org; Sun, 15 May 2011 18:36:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755645Ab1EOQg0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2011 12:36:26 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:51068 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760119Ab1EOQg0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2011 12:36:26 -0400
Received: by fxm17 with SMTP id 17so2600172fxm.19
        for <git@vger.kernel.org>; Sun, 15 May 2011 09:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:from:to:content-type:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=+/XSBSoTIEYYCkEhyKLleSAGxixhGr0Kk3eGLC1oySI=;
        b=N+3N9c4rW1Gqered+y/vz0tVWi/TdQAGwpgTaJZOmnlyT+XYkp2WhU355iQVH5aoOQ
         jnro1JKOPVYdu4QdxiPdRx7duYxUTW3+D3REGArKLqptEpuc+/9CKzWm8kmzgkdt88YS
         r3zK8S05wr5t897rFPTYpV85BUYgw2YZA49Ow=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=qk2cCWKHBONfChTIA5MX4gSuRH51nIOxVslAH3F23UbineS3dssK9BjSb5x1uPRK/3
         53gcFi0DjoD0EADIS9aqRlzBEBEdfQ2XI/6ZQCXKpBvd9ZPBNU4lD6kHhrCLIK/GVPIT
         0W60wm8V4g+EB+jZxNyO4xhiHqXle8YNp1ygQ=
Received: by 10.223.28.19 with SMTP id k19mr1947741fac.139.1305477384870;
        Sun, 15 May 2011 09:36:24 -0700 (PDT)
Received: from [46.173.68.128] ([46.173.68.128])
        by mx.google.com with ESMTPS id d16sm323271faa.12.2011.05.15.09.36.21
        (version=SSLv3 cipher=OTHER);
        Sun, 15 May 2011 09:36:22 -0700 (PDT)
X-Mailer: Evolution 2.30.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173639>

Hi all!
My question is very simple:
why git doesn't use glib as base C framework? For example, in git there
are xmalloc, xrealloc functions that duplicates glib functionality, and
these routines are only small piece of all duplicated code that already
exists in glib.

So, why git was designed and is developing now without mature stable C
library like glib?

Best regards,
Dmitry.

P.S.
My question is not a joke or smth like that. It's really interesting for
me.
