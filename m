From: skillzero@gmail.com
Subject: git svn master pointing to commit for older svn tag?
Date: Wed, 6 May 2009 14:59:46 -0700
Message-ID: <2729632a0905061459v6c257b3ay60e1f454e8f2bb4a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 07 00:01:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1pBE-0002Q9-1y
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 00:01:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762016AbZEFV7t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2009 17:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762168AbZEFV7r
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 17:59:47 -0400
Received: from rv-out-0506.google.com ([209.85.198.230]:55776 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762133AbZEFV7q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2009 17:59:46 -0400
Received: by rv-out-0506.google.com with SMTP id f6so2951354rvb.5
        for <git@vger.kernel.org>; Wed, 06 May 2009 14:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=v4Cx3ML5a5zHyzVJJBk91BZQ9Pi2fcdIjc6bmvQxy6Q=;
        b=Lav4f5wCw3NuXcUVeyKYrQmAk5hPOGxd0sHAx63/VWzQgmPf7bKx2z2sTuQTCTNikF
         HXdoABopost9Kay0ohigq0jyDBxYPsl2cnGKm33+Hwg27rwoUDbYfPIlbzfdetiy4eHR
         tUp4q+GxdU24ugHT+7xHksx1RzpGrNgCl6ww0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=d9NLEX5S/R/mzKjiuOHXIXyuZ85IqNAHNxQdS8FU32bPa/fSwp+CQ7AF/4ayUqHqZ3
         w6RMO/SsW9MH0A4a8HusaqW3d2cx3AeFLmp2uoqeYpMuBQ3vZrKqrhqKrVe9swY4EbU+
         lH4PZ7bPUaGixnumzmJSeJSsGX/YcJJbpl4FA=
Received: by 10.114.133.1 with SMTP id g1mr1687407wad.162.1241647186805; Wed, 
	06 May 2009 14:59:46 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118394>

I'm using git svn to sync to a Subversion repository and it generally
works, but somehow, it seems to have gotten into a state where master
is pointing to the commit for an old svn tag rather than to the svn
trunk so 'git svn rebase' never does anything.

If I look in .git/info/refs, I see that refs/heads/master is pointing
to the commit for a specific tag and I can change to point to
something else, but I'm wondering how it got into this state and if
there's a better way to tell git svn to go back to using the svn trunk
so future rebases work correctly?
