From: Cody Taylor <cody.taylor@maternityneighborhood.com>
Subject: Re: [Documentation/RFC] Submitting Patches
Date: Fri, 13 Mar 2015 04:18:33 -0400
Message-ID: <CAHWMk2ZE1bY0ABcMRTqHGW3oY-oWXaaKdaBOzo2rVyZjJPRzQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 13 09:19:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWKoC-0005Xq-Oj
	for gcvg-git-2@plane.gmane.org; Fri, 13 Mar 2015 09:19:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751617AbbCMISv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2015 04:18:51 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:36492 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751124AbbCMISe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Mar 2015 04:18:34 -0400
Received: by obcva2 with SMTP id va2so18289027obc.3
        for <git@vger.kernel.org>; Fri, 13 Mar 2015 01:18:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc
         :content-type;
        bh=KqvQhxzdDZ6X9M5bs4ZYOVJgjQysWO8uhTHGxpXzFzM=;
        b=IW5pRo7FxixAjjN0uuYjMXOneIQ9Q+Zi1e1Rwcd4hgOpR9Wwrk3cltKmOqF1Y3t0op
         AZ4qBw6JxGpsFJFeZss6yyK2jbc1nR/T/OY3hzqGIoiH3IhmE5RgVgM+7lleuFqAAnvV
         0992a2tRUwlL7PbIRvpK0w+lCl1+J/VZ3usyubU0ngwfftp4KFCU06jzmel8VjRsH35i
         uFvPU5E9hqq/6jCBYID4rT49IvHqcdJTYX4R1pZnda7pYBSh6rQ6sI00L5A106Xbe7Ts
         qos+2yMYmU353y/yFtNh5BojJyTI7BJG2syUA9zAQKqG0/OjYKpfO2v6BnwsTofGKsLq
         vvCA==
X-Gm-Message-State: ALoCoQmwVwCfy2eJsQPHCnUb08EWthiand2ITkjNMltgMc1oWl+JbEES+UUauyegBEGYZyycl6NI
X-Received: by 10.202.67.132 with SMTP id q126mr35073356oia.15.1426234713599;
 Fri, 13 Mar 2015 01:18:33 -0700 (PDT)
Received: by 10.76.109.37 with HTTP; Fri, 13 Mar 2015 01:18:33 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265409>

Junio C Hamano <gitster@pobox.com> wrote:
> Subject: SubmittingPatches: nudge to use send-email
>
> In step "(4) Sending your patches", we instruct users to do an
> inline patch, avoid breaking whitespaces, avoid attachments,
> use [PATCH v2] for second round, etc., all of which send-email
> knows how to do.

The idea that `git send-email` does all of the suggestions really should
be reflected in the documentation.

> Mention send-email at least once to gently nudge the user to (learn
> to) use it.

If the tool is good, do not tippy toe around the subject. Write plain text
e-mail is a strange enough experience today, the documentation should
plainly state that "git send-email" is likely the easiest solution to sending
a patch or series of patches.

Suggesting: Cody A Taylor <cody.taylor@maternityneighborhood.com>
---
 Documentation/SubmittingPatches | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index ef0eeb40cd22..702f1ace08ae 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -136,6 +136,14 @@ that is fine, but please mark it as such.

 (4) Sending your patches.

+The "git format-patch" and "git send-email" commands are
+complemtary to one another. They are optimized to make the work
+flow of sending patches much easier. Primarily, using these
+commands avoids the need to re-learn your existing e-mail client
+that is optimized for "multipart/*" mime type e-mails. Using
+these tools you will midigate the simple problems that cause poorly
+formatted e-mails.
+
 People on the Git mailing list need to be able to read and
 comment on the changes you are submitting.  It is important for
 a developer to be able to "quote" your changes, using standard
--
v2.3.2
