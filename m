From: Chris B <chris.blaszczynski@gmail.com>
Subject: Git for Windows and line endings
Date: Thu, 18 Oct 2012 18:13:07 -0400
Message-ID: <CADKp0pyy=Nnv29LyhzAOX4B5wJNYnZ0h5d7zxNRyZxV2OGUSjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org, msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Fri Oct 19 00:13:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOyLT-0000TY-Ta
	for gcvg-git-2@plane.gmane.org; Fri, 19 Oct 2012 00:13:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755319Ab2JRWN3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2012 18:13:29 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:44799 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754725Ab2JRWN2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2012 18:13:28 -0400
Received: by mail-we0-f174.google.com with SMTP id t9so5302965wey.19
        for <git@vger.kernel.org>; Thu, 18 Oct 2012 15:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=fIZMPsRZw5UGOOrWoggG1ueAKRH43EeoJsJu/E87ur0=;
        b=ojzGeue+56gV0a0QX9U679fQd82dEg9uH1gKlDm8kZJwbM2duDQB5b0G55e1VaOHzG
         joe7tcjjhylvoTC4nGuB0RGYxBOLpBvKrtHkXsQjSQTANW0Nth4e9uatpyJL4Qu6Jim2
         Y3KNpzqzCs8lWgfCUOakCrdMaF6vT7IuY0B9Qembtl0AMcxLEzI/R++XZpmYDV7FMUOz
         TsR1Xue5TjoK60s+Stx5zms6hrFeJSd17kqnG9Tco6jNG+ss/cZoAbOTuUBB8SMH8K7h
         39RhwiLQHtCsDjc+f8Bcb+EGZiBg7bD1gGhmvrLaj5REkmViOOZChxrI19QPi80KZML0
         LvHw==
Received: by 10.180.8.134 with SMTP id r6mr14222601wia.18.1350598407466; Thu,
 18 Oct 2012 15:13:27 -0700 (PDT)
Received: by 10.194.16.169 with HTTP; Thu, 18 Oct 2012 15:13:07 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208025>

Hi.. it is such a crime to have that default option of MSysGit mess
around with the line endings.

Caused us a lot of trouble.

There is no thought to the fact that it's possible the Git users are
not using Git the exact way the authors thought it would be used.
We have both Windows and Linux systems that have parts of their files
stored in Git repositories. And in addition to that, some Linux and
Windows Git clients. If everyone leaves the line endings alone,
everything works out just fine!

But messing with the line endings broke some things in production.
