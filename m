From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH] [GSoC15] git-credentials-store: support XDG config dir
Date: Wed,  4 Mar 2015 04:24:57 +0800
Message-ID: <1425414299-24000-1-git-send-email-pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 03 21:28:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YStQk-0002PU-Lc
	for gcvg-git-2@plane.gmane.org; Tue, 03 Mar 2015 21:28:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756371AbbCCU2e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2015 15:28:34 -0500
Received: from mail-pa0-f49.google.com ([209.85.220.49]:38205 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755528AbbCCU2d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2015 15:28:33 -0500
Received: by pabrd3 with SMTP id rd3so3024586pab.5
        for <git@vger.kernel.org>; Tue, 03 Mar 2015 12:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id;
        bh=tmcElzgfpWXru0bJ3voYSNspjuTjBrH5Tb67Z4rVqVc=;
        b=nGelg6XKqupEr8JdrTjIClKkUlZ5bZ8TmNIAK5sE3SitGp0jW7wdI39JitnIOTWZAR
         dkdv1FqM22AZVYkZesGpB5NjvjvIFRAP7SIQV1gSHGtbMt9KlwpRKwvV3Rca9Wj3IeNc
         6AFzTI0Hax1a2w/S/0vqs373KqZfrMS9hwSe+FWbJp404aGyXmbX5h8M7V6J66oLUex4
         IyjSTqrMzCpBZTkgFZiQxC5j/c3D1FLJe2BEajFWqb9i5+rc1Rbr7GcbiJTjuBBfgQd6
         0rvG9aFgge+lHn7mYw/zdPldiWKFg6vrO2atAYaGF+CDW6El08bXb77L6l0Ar2W0vY6E
         SK1A==
X-Received: by 10.68.132.103 with SMTP id ot7mr1218887pbb.0.1425414512927;
        Tue, 03 Mar 2015 12:28:32 -0800 (PST)
Received: from yoshi.chippynet.com ([101.127.143.183])
        by mx.google.com with ESMTPSA id ev2sm1776232pbb.69.2015.03.03.12.28.30
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Mar 2015 12:28:31 -0800 (PST)
Received: from pyokagan by yoshi.chippynet.com with local (Exim 4.84)
	(envelope-from <pyokagan@yoshi.chippynet.com>)
	id 1YStQa-0007R8-O5
	for git@vger.kernel.org; Wed, 04 Mar 2015 04:28:28 +0800
X-Mailer: git-send-email 2.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264682>


Hi all,

This is my initial implementation for the GSoC15 microproject for
supporting both ~/.git-credentials and the XDG standard
$XDG_CONFIG_HOME/git/credentials.

I wrote the XDG tests in t0302-credential-store.sh in the end because it
depends on the helper_test and check functions defined in
lib-credential.sh.

For your feedback please.

Regards,
Paul
