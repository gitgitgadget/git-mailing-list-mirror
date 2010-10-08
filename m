From: "=?UTF-8?q?=C5=A0t=C4=9Bp=C3=A1n=20N=C4=9Bmec?=" 
	<stepan.nemec@gmail.com>
Subject: [PATCH 0/6] Unify argument and option notation in the docs
Date: Fri,  8 Oct 2010 19:31:14 +0200
Message-ID: <1286559080-27257-1-git-send-email-stepnem@gmail.com>
References: <87fwwhszsf.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: jrnieder@gmail.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 08 19:35:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4Gqh-0000hg-G9
	for gcvg-git-2@lo.gmane.org; Fri, 08 Oct 2010 19:35:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759250Ab0JHRdy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Oct 2010 13:33:54 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:33353 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759114Ab0JHRdw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Oct 2010 13:33:52 -0400
Received: by fxm14 with SMTP id 14so629256fxm.19
        for <git@vger.kernel.org>; Fri, 08 Oct 2010 10:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=+cwhYBiJAfeGTP95R8NSW8GId9IUQ4xBy6tQEd8iywU=;
        b=Mglhm0TmdM+uf1jntKdStMwebtBn2RfnUEN/WfKbpa1nkEg7aRnCJjngC74t+g0bWA
         9Zc+xMIkGWC/L1rAoixMFly4a2pG5i9eJKmCNT2vzOjyR9fT14eNRNEillyP0N1pzD/0
         SvJNgWn3hxHEjELPMz+rnM7/Fqq3x4sbh8Qok=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=DhEc6Wut3HEQ7rJHLXNvryIrf6QSNMrhOLHdPm4TQ3BV+MMExyZ65IsiaiGcP08gxL
         pN6ko2j5stqoGnWV9CXDtOB1OLvNSdmZxuHDna7WEvQGYVp3LpQVdA54u83O4QbG3KX1
         6Lu9BleAJ2wKNr/KZqArSbiBujCQIVB+4nqAc=
Received: by 10.223.106.204 with SMTP id y12mr3637969fao.9.1286559230982;
        Fri, 08 Oct 2010 10:33:50 -0700 (PDT)
Received: from localhost (176.119.broadband10.iol.cz [90.177.119.176])
        by mx.google.com with ESMTPS id j14sm1743866faa.23.2010.10.08.10.33.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 08 Oct 2010 10:33:50 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.rc2.221.gbf93f.dirty
In-Reply-To: <87fwwhszsf.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158508>

Other than splitting up the patch, the only change since the RFC version is
having got rid of the GIT_* special cases in `git(1)' synopsis.

[PATCH 1/6] Use angles for placeholders consistently
[PATCH 2/6] Fix odd markup in --diff-filter documentation
[PATCH 3/6] Use parentheses and `...' where appropriate
[PATCH 4/6] Remove stray quotes in --pretty and --format documentation
[PATCH 5/6] Put a space between `<' and argument in pack-objects usage string
[PATCH 6/6] Fix {update,checkout}-index usage strings
