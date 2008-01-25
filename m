From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: stgit: patch import with fuzz
Date: Thu, 24 Jan 2008 22:01:37 -0500
Message-ID: <9e4733910801241901t230898d2t90ce2a14152e1af1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 25 04:02:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIEpV-0004VK-Pw
	for gcvg-git-2@gmane.org; Fri, 25 Jan 2008 04:02:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752470AbYAYDBi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2008 22:01:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752459AbYAYDBi
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jan 2008 22:01:38 -0500
Received: from rv-out-0910.google.com ([209.85.198.190]:14568 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751295AbYAYDBh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2008 22:01:37 -0500
Received: by rv-out-0910.google.com with SMTP id k20so501469rvb.1
        for <git@vger.kernel.org>; Thu, 24 Jan 2008 19:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=VQbD/x1D4XibZak6hLPV36nks2Si/m1d4SMAYET0Lvw=;
        b=oU0S6xR5Y9MWIZJxFyUnaQNsjqEYeszsSkYoevbK9uHpACOC9Q18sdGFbjJry2O07lVHAVsq1m6KgDdL76YMZdT37t5AxIeqUaonDzJFQBxavWlKvSuSec0y/uF2HmFNoIuhRsdk36Ne7cDYpUpWO8qxxUtBeA4LirsR3TyLlg4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ZypGo6N4rsdUbdmVHdv6ImSrHwa1A3zlBNbBM9TdbqZPICKe76ZJ4R/8u85bFBqDDcIhAjVYDLvPk4Txvp8UifNATJLMK/2UjBWRc65ZNqW+WBtsxX/jrB0+mxA5YQ/HDoZOqPzqo+5/xor8TFgd4oBSWC3mvdJnTy8b4JoJ8TE=
Received: by 10.140.193.16 with SMTP id q16mr1050449rvf.109.1201230097258;
        Thu, 24 Jan 2008 19:01:37 -0800 (PST)
Received: by 10.140.166.14 with HTTP; Thu, 24 Jan 2008 19:01:37 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71674>

Is there a way to allow a patch import with fuzz?

jonsmirl@terra:~/ds$ stg import patches-i2c/jds-mpc-i2c-to-of
Checking for changes in the working directory ... done
Importing patch "jds-mpc-i2c-to-of" ...
error: patch failed: arch/powerpc/sysdev/fsl_soc.c:318
error: arch/powerpc/sysdev/fsl_soc.c: patch does not apply
  Warning: Diff written to the .stgit-failed.patch file
  stg import: git failed with code 1

Import it manually....

jonsmirl@terra:~/ds$ patch -p1 <patches-i2c/jds-mpc-i2c-to-of
patching file arch/powerpc/sysdev/fsl_soc.c
Hunk #1 succeeded at 320 with fuzz 2 (offset 2 lines).
patching file drivers/i2c/busses/Makefile
patching file drivers/i2c/busses/i2c-mpc-drv.c
patching file drivers/i2c/busses/powerpc-common.c
patching file drivers/i2c/busses/powerpc-common.h
patching file include/linux/mod_devicetable.h
jonsmirl@terra:~/ds$


-- 
Jon Smirl
jonsmirl@gmail.com
