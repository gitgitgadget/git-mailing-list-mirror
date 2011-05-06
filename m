From: Francis Moreau <francis.moro@gmail.com>
Subject: git-cherry and merge
Date: Fri, 6 May 2011 17:40:23 +0200
Message-ID: <BANLkTimvmj1xkGiLeV4u3KB31xd+BvV4Vw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 06 17:40:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIN8n-0002qs-Ei
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 17:40:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756414Ab1EFPkY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2011 11:40:24 -0400
Received: from mail-px0-f173.google.com ([209.85.212.173]:59409 "EHLO
	mail-px0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752140Ab1EFPkY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2011 11:40:24 -0400
Received: by pxi16 with SMTP id 16so2343059pxi.4
        for <git@vger.kernel.org>; Fri, 06 May 2011 08:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=Vggvq6+bC9xNP5b/TBgw5VIK7guKHjb36yQWig83Fq0=;
        b=uXIn9kYl+6Dk1UYi8eROC6dEWYbYpJDMAtt8rq7m60s6iUfdxoSfr2WXyg4fext6q0
         my5cCgRkDQxcXVHSxcfgDdugdaOMGFmQyPo7Sf9qEGFneScWyxhr+umLEivV29Odc0M2
         YXJjSoBBPMNAFv9x8vl5RgG4kLmQeWLWSkugs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=bQnpLC+P+Hyo+8k1dyt0fFUxylsopoJDoAU3/mNnXKa35solMlRswz5DaTZH7zX3Z9
         wvepQJsYeonR/8e+PCR1KkxgJ+B9t6S1k4/asR+5FPQkdudHlpSNFa7F5rwiGyoen1nz
         ZhHM5u0bZUmqhVt7SGJlj6I03bzWq3EJF3bnA=
Received: by 10.142.136.19 with SMTP id j19mr1917610wfd.167.1304696423541;
 Fri, 06 May 2011 08:40:23 -0700 (PDT)
Received: by 10.142.77.4 with HTTP; Fri, 6 May 2011 08:40:23 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172981>

Hello,

I'm using git-cherry and would like to know if there're anyways to
tell it to skip merge changesets instead of following them and compare
each imported commits.

Thanks
-- 
Francis
