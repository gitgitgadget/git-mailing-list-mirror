From: "lode leroy" <lode.leroy@gmail.com>
Subject: trailing whitespace problem
Date: Tue, 2 Oct 2007 14:07:51 +0200
Message-ID: <b41dbf4a0710020507va40ef83u50c88094f8c2823b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 02 14:08:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcgXh-0006e9-4b
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 14:08:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753822AbXJBMHx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 08:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753505AbXJBMHx
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 08:07:53 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:40031 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753217AbXJBMHw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 08:07:52 -0400
Received: by wa-out-1112.google.com with SMTP id v27so4957209wah
        for <git@vger.kernel.org>; Tue, 02 Oct 2007 05:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=ezYcdwIQ53MK/mlHe/bUD0grmkcXg5fX+lOzWsJTNQs=;
        b=s/c3i4sI5yfIgrdO0xX2e29cC8n6YkASBVxRjcA6XYjo+5fZOkilJ9hUw2FeR0xNNxiuC9VdPRpgcKxRoCkCGf+urz3+1GHREWTx6oOc8VIo4K0gcdfyrAyqLyEaZH9eaKkS218LOgESX6A1Gn0UoRW/dbPLfBRKKOjF+oO4wWg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=h2QAK1iR5wDok44HUKoJj5HCwQgqxd+kFFUZsYWfPnDwrh3FgDvK1rJ1+t1R4kRGc3atdIoOyzF7Veo/OGNA+4hPz8k9y3iViBVEokz5swF3I/n8GHTPX37m94wQS/H6HmaEmQJnM+qPHZwwg/NC4wxpDQQXt7bNDWFuwcqt5vg=
Received: by 10.114.201.1 with SMTP id y1mr4829101waf.1191326871959;
        Tue, 02 Oct 2007 05:07:51 -0700 (PDT)
Received: by 10.141.82.5 with HTTP; Tue, 2 Oct 2007 05:07:51 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59687>

when I use git commit -a, I get the following message:

*
* You have some suspicious patch lines:
*
* In src/test.c
* trailing whitespace (line 60)
src/test.c:60: }

when I fix the whitespace problem,  and do "git commit -a" again,
I still get the same message.

Only after adding the file again, with "git add src/test.c",
I can commit my changes.

git version 1.5.3.2 (on cygwin)

ps: not related to CR/LF...
