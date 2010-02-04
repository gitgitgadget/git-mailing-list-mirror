From: Timur Tabi <timur@freescale.com>
Subject: Can I exclude .gitmodules (or any file) from git-format-patch?
Date: Thu, 4 Feb 2010 16:10:04 -0600
Message-ID: <ed82fe3e1002041410u65c2332atf5493f751fac8c17@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 04 23:12:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nd9vj-0002yO-Cd
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 23:12:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754651Ab0BDWMA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2010 17:12:00 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:29585 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751568Ab0BDWL7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2010 17:11:59 -0500
Received: by fg-out-1718.google.com with SMTP id 22so6406fge.1
        for <git@vger.kernel.org>; Thu, 04 Feb 2010 14:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:from:date
         :x-google-sender-auth:message-id:subject:to:content-type;
        bh=4RdEJoCEqGHSE/8+crNGIA8//km4OnSY8Tcr5qu0q30=;
        b=b2Uayqfc/BazOXn0J1ijNeEOFlO7OqPzUB0VTHGJ0CYz8hXbIeXEAXHdbLF3wJaJlk
         nOOogRA6ORb4ypA78EmrV4gO11Xsvmql03iW0DFAvjfM8fpSMRMEnpcGasmWW1KgZ96d
         izKiJHWohLZGP052R7p4kRUoNvykKxR6mxBcI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:from:date:x-google-sender-auth:message-id
         :subject:to:content-type;
        b=ODoMehDdoupaK7mboTx3bzFqPYSlsT0ZeskmzzG58EJGEvcBL0z3In2/hPBNZYwL+Z
         j9WY+8YjFxr1UYsrQJtX7Mbik95Z95EWY5KgC5eCVidWWV02DWuZv7BXIo8icynbwbxk
         XmnvIbMox1iLEbPz0u4ohebDrFjmqNeoK6QxM=
Received: by 10.239.187.82 with SMTP id k18mr178282hbh.5.1265321517510; Thu, 
	04 Feb 2010 14:11:57 -0800 (PST)
X-Google-Sender-Auth: 43ba3fea52bb867c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139009>

Is there a way I can get git-format-patch to ignore specific files?
Specifically, I want it to ignore .gitmodules.  This file is changed
whenever a submodule is added or removed, but I don't want git
format-patch to pick it up.  I already specify --ignore-submodules, so
I was expecting format-patch to ignore *everything* related to
sobmodules.

Perhaps --ignore-submodules should also ignore any changes to .gitmodules?

(Why is .gitmodules not in the .git directory, anyway?)

-- 
Timur Tabi
Linux kernel developer at Freescale
