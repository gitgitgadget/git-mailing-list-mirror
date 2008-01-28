From: "David Symonds" <dsymonds@gmail.com>
Subject: Configuration overrides via environment variable
Date: Mon, 28 Jan 2008 12:08:10 +1100
Message-ID: <ee77f5c20801271708k124dc9d7n942b3c95299cb7fb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 28 02:08:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJIUN-0006PF-K8
	for gcvg-git-2@gmane.org; Mon, 28 Jan 2008 02:08:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753567AbYA1BIN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2008 20:08:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753454AbYA1BIM
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jan 2008 20:08:12 -0500
Received: from rv-out-0910.google.com ([209.85.198.187]:27257 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752546AbYA1BIL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2008 20:08:11 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1519139rvb.1
        for <git@vger.kernel.org>; Sun, 27 Jan 2008 17:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=bPMifEPnFFriPcycsreIFVMexSJ0IbTPKcEPVVlMnBc=;
        b=Nrmksdk7FpnZpmrizKNw/yCbwaYqdz/gpVHRFhDKrLMz9mpVoaAwcNgJ2sLLND+hB70LJOCTYkoIjuc3o19GLldEhR0HTwT/q9Pt4AOWdPkb+6lAhnXDvp670qzMZGbaFO0EeM+mDVy+FyrZEvxquuemJdja/ySZQgqrNkCJ0OY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=GR1pAJU9CZQWcOjVa0Y2nNlyir0Y4RIHRSnFc36I0KzkOgWx7YOiRWcN4p3MHUgkiRNnZiYU+nxwkhvS6tCzzbmTRdeyOpo3yfCJ8HFkLHHKu/rysLKcFRHroesihAFdqz8iRy8GW7bXuryGwLfkC6Q4ZEWDZlaz0qqxz7p3Lyc=
Received: by 10.140.82.38 with SMTP id f38mr3067542rvb.27.1201482490561;
        Sun, 27 Jan 2008 17:08:10 -0800 (PST)
Received: by 10.141.115.4 with HTTP; Sun, 27 Jan 2008 17:08:10 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71844>

Hi,

I'm using Git in some scripts, and wanted to get its colorised output
even when it is not going to a tty. I don't want to permanently change
~/.gitconfig or the per-repo config; I just want to set color.status
(and perhaps others) to "always" for a one-off run. I suppose I could
munge the config files, storing the previous value and restoring it
later, but that's messy.

Ideally, an environment variable like GIT_EXTRA_CONFIG or something
would be nice, so I could just do:

GIT_EXTRA_CONFIG="color.status=always" git status | ...

Thoughts? Does this already exist, and I've overlooked it?


Dave.
