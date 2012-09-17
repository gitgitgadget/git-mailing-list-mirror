From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: How do I run tests under Valgrind?
Date: Mon, 17 Sep 2012 22:31:07 +0530
Message-ID: <CALkWK0m_9OsAfG_pF3hUDW+EKCyZCn9NiDKKEW6AEOMmAw=yuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 17 19:01:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDehV-0004Kv-T1
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 19:01:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755306Ab2IQRB3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 13:01:29 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:36893 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752584Ab2IQRB3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 13:01:29 -0400
Received: by qcro28 with SMTP id o28so4647582qcr.19
        for <git@vger.kernel.org>; Mon, 17 Sep 2012 10:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=jUCQogUiDgBM/vPclPlRbhlTD5EcNkqhBpI0dg+z3KA=;
        b=Hb2gDgo9wtw3pdkRFrbGW+aCBGeT9cIrHi5rl/LXTJ4z0E+9nupanUmUyxJdwveBpJ
         RR8TLupW++nJiOK6SZzn6tGkgfJA6+Opnj3uSWcINan1V+EYpV+kTocsjDChSp7k51tF
         LbD2+e9sTSwhkNSGVKvQVz1qa4fYJk/lr/fkICF3Hl7SXnrNXmkdYJH6zqp9WJNqCy75
         egdoe/y8FRr8PeQTGFS8L+JLSew7TUfNYnaMjb0B7krVoN2OiFs7U17ARelgdzfkDskb
         LVZjIVMx9NHdPJObepBMP0NZGQV7JhPOPD03+FrjaZOBERdGdQLCs0+XZeLM7RrakLYn
         qiVg==
Received: by 10.224.222.143 with SMTP id ig15mr28872765qab.25.1347901288117;
 Mon, 17 Sep 2012 10:01:28 -0700 (PDT)
Received: by 10.49.84.105 with HTTP; Mon, 17 Sep 2012 10:01:07 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205710>

Hi,

I tried running `make valgind` inside t/ and got:

    bug in test framework: multiple prerequisite tags do not work reliably

which means that even the basic tests don't pass.  Am I doing something wrong?

Ram
