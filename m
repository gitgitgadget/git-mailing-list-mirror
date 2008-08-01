From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: stgit and rm a file
Date: Thu, 31 Jul 2008 22:02:13 -0400
Message-ID: <9e4733910807311902nd3a02bep68c8a26a7e6303cd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 01 04:03:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOjzA-0006s0-8U
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 04:03:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752507AbYHACCP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 22:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753066AbYHACCP
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 22:02:15 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:9061 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752418AbYHACCO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 22:02:14 -0400
Received: by yw-out-2324.google.com with SMTP id 9so502216ywe.1
        for <git@vger.kernel.org>; Thu, 31 Jul 2008 19:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=MFolMQlQnvjMYYFiZEpsvg9S9Tv4ZcIZj8BUGgwpt3A=;
        b=XJmyJ7oq2GlXi01EbyCI2hh//CnQKgH2mZ1nBnNkOhgw39guXawJaPDXWpzkmDKf5w
         vuUJ+uKryBeHmu18r03vDuwmAokTQQpqKy5PLFA0okY24cxz3FP6QezmrNlmUS76Jk8B
         tlyL2fCv8xxepJ1j5JUJ9wyAw6oODj4pklYYU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=CbPal8wxsrW7vWmKLiyuggsCud+PrmDmztdDFi2CGJ2f9aJ5GHdUwHVFdAMv+GSUYF
         1V+qkZt0y2thTLHlVtXtHRfJpH7q11kceEXH0LT3IU0qZds6fxMfvnV+QqBmknDZ5Fv0
         1n51jAyXs1ZsFRqa7CAoQM2fWlAOodc9p9BNo=
Received: by 10.151.155.10 with SMTP id h10mr2284953ybo.96.1217556133982;
        Thu, 31 Jul 2008 19:02:13 -0700 (PDT)
Received: by 10.150.205.1 with HTTP; Thu, 31 Jul 2008 19:02:13 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91018>

Make a new patch, git rm a file, refresh. It won't pick up the rm. Do
something else besides just a rm and it will pick up the rm. Is it
already fixed in the much anticipated refresh rewrite?

jonsmirl@terra:~/fs$ stg --version
Stacked GIT 0.14.3.173.g2e37
git version 1.6.0.rc0
Python version 2.5.2 (r252:60911, Apr 21 2008, 11:17:30)
[GCC 4.2.3 (Ubuntu 4.2.3-2ubuntu7)]
jonsmirl@terra:~/fs$

-- 
Jon Smirl
jonsmirl@gmail.com
