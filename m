From: "Sitaram Chamarty" <sitaramc@gmail.com>
Subject: mismatch between doc and program in git commit -u (--untracked-files)
Date: Thu, 8 May 2008 15:40:14 +0530
Message-ID: <2e24e5b90805080310p2cb77814i45a418a0cfc8a2c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 08 12:11:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ju35g-0002re-Hx
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 12:11:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757364AbYEHKKS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2008 06:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757342AbYEHKKR
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 06:10:17 -0400
Received: from ti-out-0910.google.com ([209.85.142.190]:65011 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750735AbYEHKKQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2008 06:10:16 -0400
Received: by ti-out-0910.google.com with SMTP id b6so245607tic.23
        for <git@vger.kernel.org>; Thu, 08 May 2008 03:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=yrIqziD1Y3VBNEqVA7C9Cs2uDF94HRojvvhunzwFcYA=;
        b=P4znJyahnqJ5w+yDzwQIIhOFFdmNArAzFUOCT0UmjZX21pcr715LrVDJAIbQi1IuBUIRKIQz6xY7TNwY+h7GDeIoVEK+vxjcLQHLj402SbLnPK9tK0YhJqhShkg8reLu6kxPpIpQ/jytv0hGxbG1dQbhQSIddcO85ySOr5n1ktM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=x3JITjX6oNnIzn0OFH0yicQ1090ENr9FDFpvuf9s/ie0dY7JNfd5R0CM5wAdgpjCHFilJ4X/PALZYNJv7Ln54Rxy8AausfM6t4dCNqOyXrP4mXUYKcXTtRm5kKsXk0J9RUhj27rvyr1/ap5C0bYHpzxWujdP++oIvo2iHSTifcQ=
Received: by 10.110.46.14 with SMTP id t14mr300694tit.22.1210241414452;
        Thu, 08 May 2008 03:10:14 -0700 (PDT)
Received: by 10.110.105.1 with HTTP; Thu, 8 May 2008 03:10:14 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81521>

Hello,

The doc for commit says "-u" is a suitable abbreviation for
--untracked-files, but only the latter works.

I'll submit a patch, but being new, I thought I'd ask which is correct
-- the doc or the code?

Thanks,

Sitaram
