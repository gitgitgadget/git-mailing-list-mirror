From: Matt Whiteley <mattwhiteley@gmail.com>
Subject: [PATCH] --disassociate alias for --dissociate clone option
Date: Fri, 20 Feb 2015 11:10:21 -0800
Message-ID: <1424459423-11727-1-git-send-email-mattwhiteley@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 20 20:10:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOsyV-0000Uq-2y
	for gcvg-git-2@plane.gmane.org; Fri, 20 Feb 2015 20:10:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754658AbbBTTKp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2015 14:10:45 -0500
Received: from mail-pa0-f50.google.com ([209.85.220.50]:33647 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754195AbbBTTKn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2015 14:10:43 -0500
Received: by pabkx10 with SMTP id kx10so10197856pab.0
        for <git@vger.kernel.org>; Fri, 20 Feb 2015 11:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id;
        bh=lDBNGZgPGGZ8OdSzP7lOWjlCmfD1Fj9mfyXEK4OK2Jw=;
        b=tkKgmq+AdNZ0n2MD6jm6xHjW6mh91oKNRBI4oZvKdm2LieCBfqGNNVzP1+8xVXourG
         60Kf0byhGXpTYtyvWxuJtC1+yvkCHYSUBW1uymjXGKMfoBGqgm9OXpVRtB/T+F3lrctl
         ZR+fgxPkCL0ionxo1/FVGUNgnSNHq9NtfJBXe8jVnO52L9zu5aS305a8SlAidoCDZ7bH
         x8ofa7cuOtPoGKSQXLVO0e6cHA0a7q76bs4xj0CXZV2wi2H5Ds5/e7ac1X2ven7Fl8Ey
         8kkK8FoXBMzfjkcQyOozF4oGd47M3RivtAuX833YBWM5rekb0mFr3yfnSVyyY/cLJ8aM
         cYpg==
X-Received: by 10.68.219.103 with SMTP id pn7mr18981674pbc.73.1424459442700;
        Fri, 20 Feb 2015 11:10:42 -0800 (PST)
Received: from localhost.localdomain ([67.204.180.114])
        by mx.google.com with ESMTPSA id ak7sm7474955pad.47.2015.02.20.11.10.41
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Feb 2015 11:10:41 -0800 (PST)
X-Mailer: git-send-email 2.3.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264178>

I find the new --dissociate option for clone very helpful but I have a
hard time with the spelling. It seems reasonable to have an alias since
one exists for --recursive.
