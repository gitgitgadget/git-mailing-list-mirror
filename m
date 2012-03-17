From: =?EUC-KR?B?wMzAwMHY?= <semtlenori@gmail.com>
Subject: How to reorder all commits include the initial commit
Date: Sat, 17 Mar 2012 22:15:56 +0900
Message-ID: <CAFT+Tg_DmqxiK1qw1YvNZtY07ZaZ89+JWohdWw2fm8f=6hAwiQ@mail.gmail.com>
Reply-To: semtlenori@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 17 14:16:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8tUJ-0004D3-8C
	for gcvg-git-2@plane.gmane.org; Sat, 17 Mar 2012 14:16:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753597Ab2CQNP6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Mar 2012 09:15:58 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:40794 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751900Ab2CQNP5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Mar 2012 09:15:57 -0400
Received: by iagz16 with SMTP id z16so6837607iag.19
        for <git@vger.kernel.org>; Sat, 17 Mar 2012 06:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=hxYhJkFt4tEwioDgdgYZxSlUvSdGi93x1dgfPzfGSQo=;
        b=qS6b+wGLuSlzGM16kRZjPEIdbqiL3y31J0OoCiRZIEHvs4pbmulo+VGT3VSgV+sOM6
         FDq1G92mG1KiRAQlDfADM2uP9Pp+jM6MRfyJ1JOFXlIRJuvnVnTV0XOxFG6J7NEOQnU6
         jvJ/oLq9O0Tuuu1EOLKcHtQzAMZ60AYKTChVqUlksuQtGgN7tWBIidpdZTpQlWzNaCqm
         sLTdvWskg0NOtHW5ZVT+bF0PLDb4BFUD14X3f4JPQcnf+9Jo32zLF1cBTO1eyiN+jdPq
         KjjrJ2saMYKI3xSr1xEvVrJhK87G9Kwapw2hY59PRStuXiFn2Zvk09ETAsX4c1SrH8kA
         o3RQ==
Received: by 10.182.5.169 with SMTP id t9mr562398obt.1.1331990156971; Sat, 17
 Mar 2012 06:15:56 -0700 (PDT)
Received: by 10.182.53.98 with HTTP; Sat, 17 Mar 2012 06:15:56 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193322>

Sometimes, I need to reorder all commits, which include the initial
commit, in my branch.
So I tried it using git-rebase as follows, but it failed with the fatal=
 error.

(supposing the initial commit is=A0793ea88)
$=A0git rebase -i 793ea88^
fatal: Needed a single revision
invalid upstream=A0793ea88^

How can I do that?
