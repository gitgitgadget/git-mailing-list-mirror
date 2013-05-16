From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/8] remote-bzr: patches for next
Date: Thu, 16 May 2013 03:36:39 -0500
Message-ID: <1368693407-21267-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 16 10:38:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ucthp-0000Cc-1h
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 10:38:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756769Ab3EPIi3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 04:38:29 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:35891 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756547Ab3EPIiZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 04:38:25 -0400
Received: by mail-oa0-f46.google.com with SMTP id h2so3392002oag.19
        for <git@vger.kernel.org>; Thu, 16 May 2013 01:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=4MvSZK+khpm/fSbm/AevUku1MLRjzEg1EJyC64q+9eM=;
        b=mFK8Vc7KXl9U6bYGXftdLmBl++cbaHkbCJl/j0DtudWXEDYb9ni+17jxJXqUyjw07u
         LJ7wMnZZuLy95AqQMF+oevrCgMHnASEtsgd1aAvJKy/tAq3+Us4+QvoWXU1inSJxsVyH
         yv/uZhBf7B3/U7lwF1cAUcbW+bJmULBsiiqdIaMXO5WkECt732gXS4jS4hWPqgPjPG/I
         DwTDzkZn0TeEgaEDUh4g2QGdrXFusmsS7Lu6Xe4zLgDkSz2mxKwAFJC3uBNRd3P9WcFJ
         gRUAqt501bG45QdpWysMJDAVdsXVxfVuxKMEPABHy12hERqGUbOTG/TTMYC4hEmZ6BFc
         u/6A==
X-Received: by 10.60.47.1 with SMTP id z1mr22005785oem.134.1368693505191;
        Thu, 16 May 2013 01:38:25 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id x10sm7112575oes.6.2013.05.16.01.38.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 16 May 2013 01:38:24 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc2.542.g24820ba
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224501>

Hi,

These patches have been cooking in my github repository, and improve the
situation when bzr servers don't support repositories properly.

Felipe Contreras (8):
  remote-bzr: recover from failed clones
  remote-bzr: fix for files with spaces
  remote-bzr: simplify get_remote_branch()
  remote-bzr: delay cloning/pulling
  remote-bzr: change global repo
  remote-bzr: trivial cleanups
  remote-bzr: reorganize the way 'wanted' works
  remote-bzr: add fallback check for a partial clone

 contrib/remote-helpers/git-remote-bzr | 102 +++++++++++++++++-----------------
 1 file changed, 50 insertions(+), 52 deletions(-)

-- 
1.8.3.rc2.542.g24820ba
