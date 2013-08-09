From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/2] remote-hg: shared repo upgrade fix
Date: Fri,  9 Aug 2013 15:02:59 -0500
Message-ID: <1376078581-24766-1-git-send-email-felipe.contreras@gmail.com>
Cc: Antoine Pelisse <apelisse@gmail.com>,
	=?UTF-8?q?J=C3=B6rn=20Hees?= <dev@joernhees.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 09 22:07:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7sxh-00014t-Pu
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 22:07:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030948Ab3HIUGz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 16:06:55 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:45858 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030920Ab3HIUGy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 16:06:54 -0400
Received: by mail-oa0-f43.google.com with SMTP id i10so7485355oag.30
        for <git@vger.kernel.org>; Fri, 09 Aug 2013 13:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=qi42QFIsQFvd/3QygXWdDBL5nbVKEXJhXAEO59qZdVc=;
        b=tt2QjHPvnTIjjOcmf7x0JGoHtDLknMb6yTsLXgkztWDoCmhEckzpDg1BKwI2QPsnwZ
         WXDs12xhCGIRbq33QuEJAUTOm31gKhH1oTJVL20TBicj7qXvqBOeIM9iMOsiHJJhVJZu
         2Bri/lSxsY6+OGTQAhn7nA281ScC69uvegIiqf0yF5E8a8V9CaltaCstuLWA2JxxDIbx
         L22Jp3QQ6iCBOuJUquhrxhbJYAdmDlBDVbbsRKmd4aREDDKj37Mfccp7WckD7+8G3CF7
         aqB2MEIiUtX4hxvdLzptadSNCXXV8rWs8j381T7ByeHlkB7+w0nKf2f+Za1GqJibs6jZ
         5Lww==
X-Received: by 10.60.63.33 with SMTP id d1mr1889684oes.103.1376078813788;
        Fri, 09 Aug 2013 13:06:53 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id g1sm20794669oeq.6.2013.08.09.13.06.51
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 09 Aug 2013 13:06:52 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.267.gbb4989f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232018>

Hi,

Here's my proposal split into two patches, as I suggested. With the fix for
when there's more than one shared repo.

Felipe Contreras (2):
  remote-hg: simplify share repo setup
  remote-hg: add shared repo upgrade

 contrib/remote-helpers/git-remote-hg | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

-- 
1.8.3.267.gbb4989f
