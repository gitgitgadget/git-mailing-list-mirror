From: Jay Soffian <jaysoffian@gmail.com>
Subject: checkout vs reset
Date: Thu, 26 Feb 2009 02:08:36 -0500
Message-ID: <76718490902252308r474b193yba21b14e14a3baa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 26 08:10:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcaNi-0001fJ-VT
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 08:10:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751493AbZBZHIi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 02:08:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751010AbZBZHIi
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 02:08:38 -0500
Received: from rv-out-0506.google.com ([209.85.198.234]:61651 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750818AbZBZHIi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2009 02:08:38 -0500
Received: by rv-out-0506.google.com with SMTP id g37so408357rvb.1
        for <git@vger.kernel.org>; Wed, 25 Feb 2009 23:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=jAzzYC/sTkEr4BHAzwp9ZoGzDxwPdUZv6dGtY0tMBlw=;
        b=KKfOXZCaHvnfMBmKaYAvf3hXBfjZG9GbX65H81E/8dEdGs/BHlr6ZNOiapwBQtGMKk
         nJfv5XJMdw2XlZIhlLHPhm9NBR4Xv3izC8Nl7wKwvaZrUeL6YkgwV4eKL8AHetostRQD
         noPeNlhB9B88P9PKuWUCrDctWdbh/g0meuOns=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=Fo3tny2QYzNY39nf1Z5WXi956ff4wly5yjLPtQGE0bNI7V1UqQF7dGBtcu6JzKas1X
         j8rvwj3FZ9Wnq05A0y1x7m3ZXaxuKDqv+Y8yJV5lRAm/jDiSKOiBPyHlDvzpwCLtEHkF
         kCkQJ9lrWpxEZ/DHS9znQSU0nb9Q69nV11s5w=
Received: by 10.140.158.4 with SMTP id g4mr466543rve.248.1235632116485; Wed, 
	25 Feb 2009 23:08:36 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111534>

Is there any different between the following two commands?

git reset <commit> -- <paths>...
git checkout <commit> -- <paths>...

As far as I can tell from the man pages, they are equivalent. To wit:
both update the index and working copy for the given paths to the
state that they were in in <commit>.

j.
