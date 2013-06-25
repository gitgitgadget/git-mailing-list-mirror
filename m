From: Alexey Shumkin <Alex.Crezoff@gmail.com>
Subject: [PATCH v6 0/5] Reroll patches against v1.8.3.1
Date: Tue, 25 Jun 2013 12:55:27 +0400
Message-ID: <cover.1372149305.git.Alex.Crezoff@gmail.com>
References: <cover.1371720245.git.Alex.Crezoff@gmail.com>
Cc: Alexey Shumkin <Alex.Crezoff@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 25 10:56:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrP2b-0007sw-Ds
	for gcvg-git-2@plane.gmane.org; Tue, 25 Jun 2013 10:55:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752841Ab3FYIzr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Jun 2013 04:55:47 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:54674 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751461Ab3FYIzm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jun 2013 04:55:42 -0400
Received: by mail-la0-f50.google.com with SMTP id dy20so11481730lab.23
        for <git@vger.kernel.org>; Tue, 25 Jun 2013 01:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rarus.ru; s=google;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=XofIIzn2j9Qjnu6ULlV4IUKC1QPwJlrJLBG8vI//dt8=;
        b=TcBryeBeH9fziQaDvB7eBsNY7Fnz+1CvO4oOIkoJV7cSQyOfEVru7iKAbG92sLvpes
         Q0vg5T1LxuX3wr9ML9ZQIQa0pPqvYdkZVoY3cI8skfGLA1EjMnx7OnFArfVU6PpAhzRz
         7TD6TQUyyAvDEAOwkwvRSriarXGJT14MyBtRQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=XofIIzn2j9Qjnu6ULlV4IUKC1QPwJlrJLBG8vI//dt8=;
        b=RpNGoS+KSvfLMh7O5OpBk5lSnhsu/A28PYo7hg/X/62xOSOxzXx+7WDBeIjIEiHQqG
         Pv8o5uI9v6NABbjUqRNkBFhkDQqAKMV2UmspEGQq24PWhJw83vnzT7lnfWmu/psFnQmC
         +JRP0HIeHNQz12fDpjpGeDvrgtwi2hN4VRUMJVOVKReYawzKymySFe+SRlrOpWZFXIrk
         RW1su4Vh3U3ohnjmn2q2kLzATotWboNMQAtWijuU01v9oBeG1UYhxHj7ltzcHe9MONjJ
         TtAN//J4NA7d9mazh108idexmWC84fDZoxP3Rpey4sreYsN3f+uYSRZPlnVNEn5tXrs4
         HMCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=XofIIzn2j9Qjnu6ULlV4IUKC1QPwJlrJLBG8vI//dt8=;
        b=T2calDJO5UtAn6mZ1Fdk6MRG1ooX894JGRKOcH04+OtfN1DyOHsdjZXqo7d/IUFOn2
         jWcdqvzQ+vOKzE6zDBHP2VkETyglf+by3/mfk+BTGv51pOd7U8ZGwa03nNHJlhRP6o1W
         A8zRp0+YAVbZzMlE2XiG/G7gaLr9aFOsXMSBsgJFTbF4TFpuf5nVeDyR8wwXCg6NLttA
         zzOFJ9iTTDYF8qpYBMCT6vK7yzAWjCesRFcnrb+zdDOCqbXYkHREivogdAJP78rEnnr5
         /zmtzJVbzz4hS+zpTe5RFV5fA+w4t9LO/5nc5eHTAeD0hUOWH1akxemGo675o7i/uwn4
         u5NQ==
X-Received: by 10.112.5.134 with SMTP id s6mr14443382lbs.95.1372150539991;
        Tue, 25 Jun 2013 01:55:39 -0700 (PDT)
Received: from localhost ([85.21.218.130])
        by mx.google.com with ESMTPSA id a3sm8223200lbg.2.2013.06.25.01.55.37
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 25 Jun 2013 01:55:38 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.15.g5c23c1e
In-Reply-To: <cover.1371720245.git.Alex.Crezoff@gmail.com>
X-Gm-Message-State: ALoCoQksCLNkSzUlrrxN90PGLHO33iQbRCpLllnVSY1RzHmvdPG2gBokrOr8o5hCgsBYZLQUdNEd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228948>

It's all started here [http://thread.gmane.org/gmane.comp.version-control.git/177634]
and recently continued later [http://thread.gmane.org/gmane.comp.version-control.git/214419]

v6 of this patch series includes Junio's suggestions against v5:

1. [PATCH v6 1/5] t6006 (rev-list-format): don't hardcode SHA-1 in expected outputs
	using modern 'git rev-parse HEAD:' git syntax to get commit tree ID
2. [PATCH v6 2/5] t7102 (reset): don't hardcode SHA-1 in expected outputs
	untouched
3. [PATCH v6 3/5] t4205 (log-pretty-formats): don't hardcode SHA-1 in expected outputs
	using 'rev-parse --short' instead of 'git rev-list --max-count=1 --abbrev-commit'
4. [PATCH v6 4/5] pretty: Add failing tests: --format output should honor logOutputEncoding
	iso8859-5 encoding reverted back to cp1251 encoding (as it was in v4 series)
	reworded log message
5. [PATCH v6 5/5] pretty: --format output should honor logOutputEncoding
	reworded log message


Alexey Shumkin (5):
  t6006 (rev-list-format): don't hardcode SHA-1 in expected outputs
  t7102 (reset): don't hardcode SHA-1 in expected outputs
  t4205 (log-pretty-formats): don't hardcode SHA-1 in expected outputs
  pretty: Add failing tests: --format output should honor
    logOutputEncoding
  pretty: --format output should honor logOutputEncoding

 builtin/reset.c                  |   6 +-
 builtin/rev-list.c               |   1 +
 builtin/shortlog.c               |   1 +
 log-tree.c                       |   1 +
 submodule.c                      |   1 +
 t/t4041-diff-submodule-option.sh |  25 +++--
 t/t4205-log-pretty-formats.sh    | 179 ++++++++++++++++++++-------------
 t/t6006-rev-list-format.sh       | 207 ++++++++++++++++++++++++---------------
 t/t7102-reset.sh                 |  37 ++++++-
 9 files changed, 293 insertions(+), 165 deletions(-)

-- 
1.8.3.1.15.g5c23c1e
