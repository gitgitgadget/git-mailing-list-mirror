From: Bruce Korb <bruce.korb@gmail.com>
Subject: How do I .gitignore files starting with "#"?
Date: Fri, 10 Sep 2010 09:59:03 -0700
Message-ID: <AANLkTimaPrDX4rn2xRYyLn-bh2rB-TgKaEtGSQ+JxSnM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 10 18:59:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ou6wh-0008R8-TX
	for gcvg-git-2@lo.gmane.org; Fri, 10 Sep 2010 18:59:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755025Ab0IJQ7W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Sep 2010 12:59:22 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:33366 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754125Ab0IJQ7V (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Sep 2010 12:59:21 -0400
Received: by gwj17 with SMTP id 17so1231487gwj.19
        for <git@vger.kernel.org>; Fri, 10 Sep 2010 09:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type;
        bh=K8qAh3aInuen6LO0Mi4kx0D8RRhkUNwXN1zFQWUL6XY=;
        b=m2k5VQJnWiBByu+K+5A+5LcAyGNoae79V91A2D79s9SqMXFQJY/8m3we8LEEULVC1O
         RhD3KlUPTwuEAMvcMiyyyuDozPDS6266XQaOWcHbMh36449mUDoM2fdrfupnDZXSosrw
         MJ/TcTWeOOEpbiIlUbCRBojayIZLYywIBM+jk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=h524qNv9zfv3VAoHyTH5TZJ7zr38feOlAtIwajEqnNxBLJdA7PQLrYs1hYMdZk/W5m
         ur45yyeW6eZKOKxTa71fiz7MzIH8NA32hACw0JF35deM+K0OPNZl1ALFPERLQz78n4ql
         vh8l6FiJGg/Cq3J+jqtaZXhjt95wO/7fQlHHo=
Received: by 10.150.52.11 with SMTP id z11mr655967ybz.149.1284137959286; Fri,
 10 Sep 2010 09:59:19 -0700 (PDT)
Received: by 10.231.182.11 with HTTP; Fri, 10 Sep 2010 09:59:03 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155947>

After trying lots of variations, I found it to be:

\#*

Not obvious and not easy to look up.  Please add it to your
.git/info/exclude sample text.  Thanks!
