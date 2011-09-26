From: neubyr <neubyr@gmail.com>
Subject: git apply/am whitespace errors
Date: Mon, 26 Sep 2011 14:03:06 -0500
Message-ID: <CALFxCvxxbsgZnhqK9nN7h=1ASJzfDJ7aVF+rM-8RUyKhpv8FzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 26 21:03:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8GSQ-0006a1-31
	for gcvg-git-2@lo.gmane.org; Mon, 26 Sep 2011 21:03:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752278Ab1IZTDI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Sep 2011 15:03:08 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:35030 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752078Ab1IZTDH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2011 15:03:07 -0400
Received: by wyg34 with SMTP id 34so6223494wyg.19
        for <git@vger.kernel.org>; Mon, 26 Sep 2011 12:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=AQ5PzWx8OBt8DVUO/BxmKVuOgEN2foM1B2D0KLef6IM=;
        b=IfWSgOsoXCErMXZ1oM6zwVbF7dIaff6UUTfHrSE5vZc/se8P5eV9Y0p8h8isQW7Ynv
         tfX7MGdSXtRihk45DsQdbA/f2L0N2HVgJcMlCHyamIqgeQGJ9MqDyibcSW5oeksouCA3
         UYx/6X1SWqYWm6/F88hRN+74cLqnYNTd+2N9w=
Received: by 10.227.28.30 with SMTP id k30mr7582669wbc.98.1317063786173; Mon,
 26 Sep 2011 12:03:06 -0700 (PDT)
Received: by 10.227.28.68 with HTTP; Mon, 26 Sep 2011 12:03:06 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182151>

I am getting  following error while applying a patch using git-apply.

{{{
/tmp/patches/ticket11/0002-Commit-for-ticket-11.patch:51: new blank line at EOF.
}}}

What does number '51' after colon ':' indicate? There aren't 51 lines
in that patch file. Also, I had used check and stat options before
applying match and it didn't indicate any warnings/errors.
I tried git am interactive and it gave following error:

{{{
Applying: Commit for [ticket:11]. Created a directory to download lens
files and added .include_in_git empty hidden file.
/tmp/galaxy/.git/rebase-apply/patch:10: new blank line at EOF.
+
warning: 1 line adds whitespace errors.
Commit Body is:
}}}

I am trying to add a directory with a hidden empty file. Any
elaboration on above warning/error messages will be really helpful.

--
thanks,
neuby.r
