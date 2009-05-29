From: =?ISO-8859-1?Q?Thorben_Schr=F6der?= <stillepost@gmail.com>
Subject: After update to 1.6.3.1. I get this error: error: bad index file sha1 
	signature
Date: Fri, 29 May 2009 09:25:27 +0200
Message-ID: <64fe838e0905290025h6bf2172agea4beb1ccff6dd6e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 29 09:26:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9wTX-0005Ic-4s
	for gcvg-git-2@gmane.org; Fri, 29 May 2009 09:25:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755357AbZE2HZ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2009 03:25:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755019AbZE2HZ1
	(ORCPT <rfc822;git-outgoing>); Fri, 29 May 2009 03:25:27 -0400
Received: from mail-fx0-f168.google.com ([209.85.220.168]:41117 "EHLO
	mail-fx0-f168.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753554AbZE2HZ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2009 03:25:27 -0400
Received: by fxm12 with SMTP id 12so4193157fxm.37
        for <git@vger.kernel.org>; Fri, 29 May 2009 00:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=Sg+FbyO3gjHKV9pGr/AIuGjvJpP/nfQ1VusvCrw2LKo=;
        b=pS3IbBkdfjTvDX7x9U194QF3XVdS8iaPAIkQEADkDIL4kutIEjFCINoWCvo9izfEHD
         JKkXgAWIsH6zH/4PYiiFbZujtCe0ILzG5EGTr08l/TW/t82jj+Ejibh2KJLmO/PVmCgK
         R1ECNhr+gbSxC3U0Oe/d7keNpwfm9sS/efEDw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=lgpPzU8mEHK5yTsmYHLL7M//fP9qskZgsaSlKdyaqbru897LLcd3rBaDq7UrJHe+ul
         W7RUziH36fteFkg45oZ9p3ffXe74uoA0TEPs1j9T7RHL2GFzsYVM5Hl81BIxySTr8/0A
         bKOjbxQmTnJU1DKhVwJfwuFwEz00CASZIzmdw=
Received: by 10.223.111.134 with SMTP id s6mr1745716fap.37.1243581927920; Fri, 
	29 May 2009 00:25:27 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120253>

Hi,

I've recently updated from 1.6.1.2 to 1.6.3.1 on OS X. And after that
transition I get this:

  error: bad index file sha1 signature
  fatal: index file corrupt

on any git command I invoke in any of my repositories. I even tried to
go back to 1.6.1.2 but the error still occurs.

Is there any thing I can do to fix this? Would be great, otherwise all
my local repositories are busted :/

Thank you a lot for your help in advance!

Thorben
