From: Derek Mahar <derek.mahar@gmail.com>
Subject: Re: git-svn and incorrect working copy file timestamps?
Date: Thu, 19 Mar 2009 17:31:43 -0400
Message-ID: <5f4b18bf0903191431t20313bb4u14a717fecc27f18@mail.gmail.com>
References: <1237492452300-2505059.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 19 22:33:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkPrY-000841-S1
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 22:33:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759075AbZCSVbr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 17:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760743AbZCSVbq
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 17:31:46 -0400
Received: from mail-gx0-f208.google.com ([209.85.217.208]:40089 "EHLO
	mail-gx0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760665AbZCSVbp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 17:31:45 -0400
Received: by gxk4 with SMTP id 4so2531445gxk.13
        for <git@vger.kernel.org>; Thu, 19 Mar 2009 14:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=bMYPycT1ke0CCwBAADg0+mX50b/Dznp05a8zGgYCzjQ=;
        b=JCGR9H8UY3ggXFNVnOwBa0BnX52nixuLAcAEgVkDg1BF+lrFTNjvpMFhI9zrNjPT7n
         a3axt7sMkXPG1QJVymQh1pUT1sMk6++9oN285QlXsUUlCu3mJYLbNWwrQxtiAClu2lcl
         Rg8mk5DH83OAcLXD0iDuJc9MCe//qablHPDgo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=TF/M8rEn7zQtijaqrVsCo+Q9NZHaHXqE4sCN8iosWqF/etAS4+PN1ObbJ2bE2PYs4B
         as25GNl4LCoLZKdY4vCjoBbO7fG/vUpugTb3XgcEjl7/eH7vBKkGDJyUJjmPUxPRlfzA
         Koma9EyiRM2c6yQe1KIqKEQV2Q5AAGKm7/AVI=
Received: by 10.151.27.15 with SMTP id e15mr5053414ybj.207.1237498303093; Thu, 
	19 Mar 2009 14:31:43 -0700 (PDT)
In-Reply-To: <1237492452300-2505059.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113831>

> Should "git svn" not preserve the file timestamps of the original commit tree
> in the working copy?

I learned from http://marc.info/?l=git&m=122783905206964&w=2 that all
Git commands do not preserve file timestamps because Git, by design,
does not record timestamps in the tree objects.  So, in order to see
the last time a particular file changed, you must examine the commit
log.  I guess I'll just have to get used to ignoring the working copy
file timestamps.

Derek
