From: Alexey Shumkin <Alex.Crezoff@gmail.com>
Subject: [PATCH v5 0/5] Reroll patches against v1.8.3.1
Date: Thu, 20 Jun 2013 13:26:16 +0400
Message-ID: <cover.1371720245.git.Alex.Crezoff@gmail.com>
References: <cover.1359018188.git.Alex.Crezoff@gmail.com>
Cc: Alexey Shumkin <Alex.Crezoff@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 20 11:26:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Upb8n-0002oC-CS
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 11:26:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965203Ab3FTJ0t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 05:26:49 -0400
Received: from mail-la0-f44.google.com ([209.85.215.44]:42121 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935297Ab3FTJ0s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 05:26:48 -0400
Received: by mail-la0-f44.google.com with SMTP id er20so5519885lab.17
        for <git@vger.kernel.org>; Thu, 20 Jun 2013 02:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rarus.ru; s=google;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=DbylhbESfQYiYKIJAbK0DOSboDzAbWB2pfXPMZNQgDo=;
        b=fxPBaCCgyYzX1a4VAeGExWZJtjY1ws5/JHJxVr2rP3yvqTJ6oRTtWmNwViiSmbPW33
         pnhtrwIuXz8dnOOsE4aym3F1S7VUTPCsr3vx9bvDUtY4buJZJPEhkbUkrekTyUPBPBIq
         5Y1KursMeioDakxTisI9C14/c/6DSXnS6IrZA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=DbylhbESfQYiYKIJAbK0DOSboDzAbWB2pfXPMZNQgDo=;
        b=wnccd4rLtnHSAKfWwQnY3ouXgmwlXCjfwG24pPT9kqFSvwGvNyxE9QoHyOPwLTLU4Q
         So5ax2dMQlVJOEHkwuRZFmj09ibaZTj9+1ClaokrzZNKWEjSm8EOphvVjMmxwCjW3Dm4
         obG3rcpF/fGl9C1YTrxPW2Z4tNLHaZCZ0McNwnPCTJUyQZckd03nxSnT15svvVEGlCv+
         TrlKeSGIlR8iK+1HO+KtQJuFdkGWGR2F5LrD1tNIyPytmpk4/92jwEbK+K25oM8lRFb9
         vH7/oviXo+OP4Sd1JBCgDkrWI6cB2kDVrjO36q+XmPCUmo8HjCBPq6ipfOciT6JjtlRh
         djsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=DbylhbESfQYiYKIJAbK0DOSboDzAbWB2pfXPMZNQgDo=;
        b=N4FZyIQFprnxsaIhypBEKiNDZkLGlg6NkoBhGdBw13NWGy06aAk6h8J7pN2FexGbh4
         dyUnj23Ytjktei2c+ciVaeuUfkdxmXWbovgWSpnVK5esSbkKk3TysPTylulh5Z9/+pjf
         wP+RsBWLhaQuxzwOM8i7kpNoprr3soU2QXlnybLO/ZZHeHTIOcUIAVjS4lQ7uLPwprt/
         io78HYYgseJzURZtfWemm+aPIEqFV0mtmVhMUSY6VjSD8wroG18ztppk9zAiH0zjANnc
         iZHudCcldFOWOYjU8qrFMwcqPf/InJi8AIZXSHozVw0xB/wU7cMEl19D+rV4dS3oSzCR
         nWnA==
X-Received: by 10.112.58.135 with SMTP id r7mr5179463lbq.89.1371720406238;
        Thu, 20 Jun 2013 02:26:46 -0700 (PDT)
Received: from localhost ([85.21.218.130])
        by mx.google.com with ESMTPSA id m14sm30244lbl.1.2013.06.20.02.26.44
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 20 Jun 2013 02:26:45 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.15.g5c23c1e
In-Reply-To: <cover.1359018188.git.Alex.Crezoff@gmail.com>
X-Gm-Message-State: ALoCoQlt1c7xv0TgRsnuWqtanogdrz3R3gZGqI9AIiNNydsP0Nv97zjDz8SeDVMtbwhReDqe0BfZ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228468>

Alexey Shumkin (5):
  t6006 (rev-list-format): don't hardcode SHA-1 in expected outputs
  t7102 (reset): don't hardcode SHA-1 in expected outputs
  t4205 (log-pretty-formats): don't hardcode SHA-1 in expected outputs
  pretty: Add failing tests: user format ignores i18n.logOutputEncoding
    setting
  pretty: user format ignores i18n.logOutputEncoding setting

 builtin/reset.c                  |   8 +-
 builtin/rev-list.c               |   1 +
 builtin/shortlog.c               |   1 +
 log-tree.c                       |   1 +
 submodule.c                      |   3 +
 t/t4041-diff-submodule-option.sh |  25 +++--
 t/t4205-log-pretty-formats.sh    | 179 ++++++++++++++++++++-------------
 t/t6006-rev-list-format.sh       | 209 ++++++++++++++++++++++++---------------
 t/t7102-reset.sh                 |  37 ++++++-
 9 files changed, 299 insertions(+), 165 deletions(-)

-- 
1.8.3.1.15.g5c23c1e
