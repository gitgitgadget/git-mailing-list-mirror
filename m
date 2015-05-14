From: David Turner <dturner@twopensource.com>
Subject: [PATCH v12 0/3] git cat-file --follow-symlinks
Date: Thu, 14 May 2015 17:58:12 -0400
Message-ID: <1431640695-24741-1-git-send-email-user@ubuntu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 14 23:58:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yt19M-0002RB-0v
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 23:58:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422821AbbENV6f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2015 17:58:35 -0400
Received: from mail-qg0-f50.google.com ([209.85.192.50]:34421 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422652AbbENV6e (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 17:58:34 -0400
Received: by qgfi89 with SMTP id i89so44667532qgf.1
        for <git@vger.kernel.org>; Thu, 14 May 2015 14:58:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=+eOt1SxI3yih/BTJRZhgLPE5oi8ZDVa8Oj/gpZ7x7Gw=;
        b=jHG4HNL6PCL2IkEQYeDpl5CiBRKMNSsj5lbA9UC4sFB8T79hIaLscMiY3OacLZEfMq
         KM+YwtjIPL8x3fcsDQlSNuuWAjzm+LuXt/fZ8Fdq2dkX14gw80LW2QtU7KqohQcPxax+
         hS5me+mXMtFetJgw/I7L67Iyg4G/TwjFB3UiZl81wDMfl4DPxFpP5w5yh4L76bG4s0RP
         JXwcpGvpWRnx9nEKfd54AMXBpVR2kyNuAdwKFmCxJpcp8Z8hRRilp1fzK0ijrd793+T8
         rIgluRaMrOZRLAXHrvrkTQMhtd2ckZZgeMuJjOamhl2jD37KwLusTyWID9yH/yIRtq4H
         Myvg==
X-Gm-Message-State: ALoCoQmDLxu6P6xeDCLM7dwtSar+Z5y0qdVa36Fgj7pCR/384pDTrfL1cQLA6Hj/vp2zmcxBwdY8
X-Received: by 10.229.130.71 with SMTP id r7mr2744328qcs.13.1431640713991;
        Thu, 14 May 2015 14:58:33 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by mx.google.com with ESMTPSA id o65sm237191qge.34.2015.05.14.14.58.32
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 May 2015 14:58:33 -0700 (PDT)
X-Google-Original-From: David Turner <dturner@twopensource>
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269109>

Adjust asciidoc to use +-continuation with non-indented sections
instead of [normal].
