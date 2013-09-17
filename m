From: "Burton, Ross" <ross.burton@intel.com>
Subject: Bisect needing to be at repo top-level?
Date: Tue, 17 Sep 2013 17:31:57 +0100
Message-ID: <CAJTo0LZ=bNNUc8O=bDDOp2vudsc_wL+-nqsXW5r1rq3H7M0e7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 17 18:32:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VLyCU-0003v5-E8
	for gcvg-git-2@plane.gmane.org; Tue, 17 Sep 2013 18:32:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753447Ab3IQQcT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Sep 2013 12:32:19 -0400
Received: from mail-vc0-f169.google.com ([209.85.220.169]:33363 "EHLO
	mail-vc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752914Ab3IQQcS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Sep 2013 12:32:18 -0400
Received: by mail-vc0-f169.google.com with SMTP id ib11so4294570vcb.14
        for <git@vger.kernel.org>; Tue, 17 Sep 2013 09:32:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=B85Rrp3GbDMcf1XsjbwY4I3gEsIU9p7wIIRSKzpg9LU=;
        b=J1uyqApQOm8sfMW/neRotZRJv8XDIbqBQc39+Bm1sqAp4fmlqhZwujEdTsTD9IjQlo
         WWNUBwU8cVCFWZ3BKyMNEOXzPRvHAinbXpn146Ug6LPk4rVqlFe6B3/jVYBAqCSPZq9J
         CDixWuLLZU9SDLANJnp+ERIxhzICXGyBL1NnHwlQURZDzkQywh/ZXzL+cvAg7680z9Oh
         gkcpojqZXz4wR4FUyDrQsdG/9HoMCliqGyg9eXHd8JYsw3fciLKZJWSBWnX15Kgfffmx
         Z99t3HZBRRhqxX3VTH5jRLvqtZyV5P5oz4DRLJhoZ0EkXL1UtOD8hwP5+se/l+25dU82
         CmIg==
X-Gm-Message-State: ALoCoQklxOJxt0XOe88/B2f0rObiGAx6O2p+zZxO3IdfIVkBbPtPGyWsP+fZJBkjJrThg6cVAQYh
X-Received: by 10.52.120.78 with SMTP id la14mr28567830vdb.9.1379435537557;
 Tue, 17 Sep 2013 09:32:17 -0700 (PDT)
Received: by 10.220.71.201 with HTTP; Tue, 17 Sep 2013 09:31:57 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234885>

Hi,

Why does git-bisect need to be ran from the top level of the working
tree?  It sources git-sh-setup.sh which sets GIT_DIR, which
git-bisect.sh then appears to consistently use.  Is there a reason for
needing to be at the top-level, or is this an old and redundant
message?

Cheers,
Ross
