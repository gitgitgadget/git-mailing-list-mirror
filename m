From: Erez Zilber <erezzi.list@gmail.com>
Subject: Is there a way to enforce '-x' when running git cherry-pick?
Date: Mon, 28 Jun 2010 18:55:22 +0300
Message-ID: <AANLkTinWcGZksUfs33BcA-Dz6z8uvUFSW_SY6QQyDhVy@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 28 17:55:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTGgE-00016k-Gf
	for gcvg-git-2@lo.gmane.org; Mon, 28 Jun 2010 17:55:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754202Ab0F1PzY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jun 2010 11:55:24 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:64156 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751620Ab0F1PzY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jun 2010 11:55:24 -0400
Received: by bwz1 with SMTP id 1so267028bwz.19
        for <git@vger.kernel.org>; Mon, 28 Jun 2010 08:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=qXAvECBvrPaYBFB0z74xqdgx00CikLt6GkhyU0IFuSs=;
        b=ksEZo4CpOtnO9w/U3KCS8Zc98/w4cUn/8I47KpIOlnJ8LPgGgAc9VqjryVc4RCDb2K
         bXAtJNhPJf9mGEiR309FknNqhxWavYJvvUZWIRpK5Q0PDFaiRHgMaZYa7aRSoybPQ2yK
         ABdTIxeEnQ3FZBhoQ+Tgh9DqIQxEhOStcQAjw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=vJqgsB31UebifeimknewRpWHqSMKyp/GIEOsK7WJW7nJO0JP/FQwR2G+Bw2UTYIlyc
         zXjwsX5xQZEDlrvaayaCOVJxOsW7cePPfTX3bC0LsgfMaIMC+8s2KGt0Y4RhjSEERnzV
         8egaMJlVH2WlfVbg0PIsvQLvxQDMkVHNGSLO4=
Received: by 10.204.47.138 with SMTP id n10mr2393128bkf.120.1277740522179; 
	Mon, 28 Jun 2010 08:55:22 -0700 (PDT)
Received: by 10.204.68.4 with HTTP; Mon, 28 Jun 2010 08:55:22 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149833>

Hi,

Running git cherry-pick with the '-x' flag seems very helpful for me
when cherry-picking commits between branches on a public reporsitory.
Is there a way to run it with '-x' by default?

Thanks,
Erez
