From: James B <coderer@gmail.com>
Subject: SSL certificate password storage?
Date: Fri, 23 Sep 2011 15:41:07 -0700
Message-ID: <CAEsSSh2MDPgcFtrwYJ7uCDHBHPEfo35deE4dsWrb7Ukp7b310A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 24 00:41:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7ER2-0005Wd-A8
	for gcvg-git-2@lo.gmane.org; Sat, 24 Sep 2011 00:41:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752663Ab1IWWl2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Sep 2011 18:41:28 -0400
Received: from mail-pz0-f66.google.com ([209.85.210.66]:57839 "EHLO
	mail-pz0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751583Ab1IWWl1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2011 18:41:27 -0400
Received: by pzk1 with SMTP id 1so2135193pzk.1
        for <git@vger.kernel.org>; Fri, 23 Sep 2011 15:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=rvvFpLp1UpF49LgvYGum6oLlsX0H70DnSH+HMCJx8TI=;
        b=GFEMJBZVdXdtLzzEdqVnqfnaZAoCCyhHGhbWsnelI4TvsjqN7JKBOAA4URWoTj+x8E
         RJpdCZ4dRbLDlVjX9L/tbWn0bBW3mX+kE1iST7aPmYcCYYQQwVcBW+Q3XZvd3kjFb7R6
         cYNP+xMTZSfVPRn5ZWShyPUM3sUypNxPh7CiA=
Received: by 10.68.20.226 with SMTP id q2mr12560222pbe.115.1316817687032; Fri,
 23 Sep 2011 15:41:27 -0700 (PDT)
Received: by 10.68.63.162 with HTTP; Fri, 23 Sep 2011 15:41:07 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182010>

I'm accessing a Git repository over an HTTPS transport, where client
certificates are required.  My certificate requires a password to use,
and Git prompts me for this every time I use it -- it's starting to
get a little old.  I've got Subversion set up to use Gnome-Keyring for
credentials, so I only have to unlock that once per session.  Is there
something similar for Git?  Is it planned?  If not, is there a good
place to make feature requests?

R/
James
