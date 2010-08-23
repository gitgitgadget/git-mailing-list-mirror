From: "Nathan W. Panike" <nathan.panike@gmail.com>
Subject: HTML help files are broken
Date: Mon, 23 Aug 2010 10:59:04 -0500
Message-ID: <AANLkTimMZGswhWXyDMaFa9N1ipzoBXT7RptHMq2TYhmv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 23 17:59:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnZQZ-0000gx-4F
	for gcvg-git-2@lo.gmane.org; Mon, 23 Aug 2010 17:59:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754322Ab0HWP7H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Aug 2010 11:59:07 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:61093 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754317Ab0HWP7G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Aug 2010 11:59:06 -0400
Received: by wwe15 with SMTP id 15so285408wwe.1
        for <git@vger.kernel.org>; Mon, 23 Aug 2010 08:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=kU8MSdXp1ui8L3mUMK1YCmOqWw7EJmL4NdXF+qcYMKU=;
        b=PXrx2vHwFRandZ+XSWY6FhRn9/8rhn0nlACMKerEt/A7hYyJIoUaYLrc3rZJzCALnl
         SJa5QmTXXAJysltrxac3fZn5tswZBEOilm0BoBPoDYtnhF8G2TADEzxW531WcuNkwWL4
         yDsSVr7slMALfMvsK9RydXC68qK1Z7Hmxurrc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=rWUsFQxZaXWX+f4vcuybgO8M5nEWMUk+igWqvbGjl9aC8qDURO9b1aXFfbBQKePcm2
         ngztVVdJYjVuPC1nc6kPlupJ0BY0BC+LrEhwRQkTgQf+pFrZ2InTFb55NFO01NNlocKl
         vecTMEpP4CwIcL/7chh6om3gTQORn1tq+qj4s=
Received: by 10.216.45.16 with SMTP id o16mr2715867web.45.1282579144353; Mon,
 23 Aug 2010 08:59:04 -0700 (PDT)
Received: by 10.216.68.16 with HTTP; Mon, 23 Aug 2010 08:59:04 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154231>

Some of the HTML manual files produced on my machine (Ubuntu 10.04)
from the git source are broken: in git-help.html, I get the following
for the link to the git-web--browse manual page:

<a href="git-web&#8212;browse.html">git-web&#8212;browse(1)</a>

where the &#8212; (en-dash) replaces the "--" (dash-dash) that is on
the filesystem.  How does one fix it, so that the line above would be

<a href="git-web--browse.html">git-web--browse(1)</a>?

The command line I am using is a simple

make doc.

I checked the git repository origin/html, and the correct link is
produced there, so something in my configuration is messed up.

Nathan Panike
