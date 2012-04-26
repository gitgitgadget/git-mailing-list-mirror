From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git 1.7.8.6
Date: Thu, 26 Apr 2012 12:51:39 -0700
Message-ID: <xmqqvckm6z26.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 26 22:03:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNUuT-0000Fp-Ix
	for gcvg-git-2@plane.gmane.org; Thu, 26 Apr 2012 22:03:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758830Ab2DZUDT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Apr 2012 16:03:19 -0400
Received: from mail-vb0-f74.google.com ([209.85.212.74]:43990 "EHLO
	mail-vb0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752077Ab2DZUDP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2012 16:03:15 -0400
Received: by vbnl22 with SMTP id l22so193019vbn.1
        for <git@vger.kernel.org>; Thu, 26 Apr 2012 13:03:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:subject:date:message-id:user-agent:mime-version
         :content-type:x-gm-message-state;
        bh=e6JWiURrlci6/hA8adtY7qbx6gd7ToJ2+Zn6P8Rvmu4=;
        b=R7gjIudn7hFiHAo5bi4XqPEDmU8ZFptFUmQbqFxBMys+QXqMz/arBaEDnZBOwrt2F3
         R7yZb9X3nPZB7sUWZ4OBHDyXjJLEhQFQcbSmarPJ+oMRTY6bNBkNxY4DYfGj2bLRL3GP
         m0BmkYaU9Yi+ZUY2KfI8geNw9ETMl6R7U23+MTwN7RatZCTPrZ6Lsplzy7YHo+7yCVXz
         HxTi0Jn4WJZsJ6I3ycJVW3f+RIXDFMicC6wn8zVCph8RSKAt5C5+DPzg5bU1DZQ58PYg
         ra+45wzyFtHFbLpFwCOvguTzLrZ/9nKTcI+I5UOuk6HdOMpRP8Q9VDGBUbg5RHraBona
         dknw==
Received: by 10.101.2.21 with SMTP id e21mr3073011ani.18.1335470594726;
        Thu, 26 Apr 2012 13:03:14 -0700 (PDT)
Received: by 10.101.2.21 with SMTP id e21mr3073000ani.18.1335470594610;
        Thu, 26 Apr 2012 13:03:14 -0700 (PDT)
Received: from wpzn4.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id z48si4058393yhn.7.2012.04.26.13.03.14
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Thu, 26 Apr 2012 13:03:14 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by wpzn4.hot.corp.google.com (Postfix) with ESMTP id 7A2C61E004D;
	Thu, 26 Apr 2012 13:03:14 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id 26DA1E1203; Thu, 26 Apr 2012 13:03:14 -0700 (PDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQkBhzGGmqMr/8ceUTZBkSmdsRFxDF3BOTmeCej9E1YsNY+PRaGVB4Yz+4aRvcLXZQJ50aGElYtU0oeBx7VY9JoPO4qU1NlWMwiWHbU6MYwl/wRs3ykNtYsQpmV9X/LTwANmGUscJNCucLN7tecWogdv2CNOkiLBVLhdMEZPiWEYXfE7hac=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196398>

A maintenance release Git 1.7.8.6 is now available at the usual
places.

This contains minor documentation fixes and code clean-ups.

The release tarballs are found at:

    http://code.google.com/p/git-core/downloads/list

and their SHA-1 checksums are:

b204ae56e511c541425c5db757132fcd35f64117  git-1.7.8.6.tar.gz
0618da00f11a6bb91da7d639f348bb806b153650  git-htmldocs-1.7.8.6.tar.gz
2d2da141cebb2d7cce03abb556ee52c3dbad3831  git-manpages-1.7.8.6.tar.gz

Also the following public repositories all have a copy of the v1.7.8.6
tag and the maint-1.7.8 branch that the tag points at:

  url = git://repo.or.cz/alt-git.git
  url = https://code.google.com/p/git-core/
  url = git://git.sourceforge.jp/gitroot/git-core/git.git
  url = git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url = https://github.com/gitster/git
