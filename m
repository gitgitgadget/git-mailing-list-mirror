From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH 0/2 v2] Document update for 'git-blame' '-M' and '-C' option
Date: Sat, 10 Apr 2010 18:15:28 +0800
Message-ID: <1270894530-6486-1-git-send-email-struggleyb.nku@gmail.com>
Cc: gitster@pobox.com, trast@student.ethz.ch
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 10 12:16:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0XjM-0001PU-OP
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 12:16:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751476Ab0DJKPm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 06:15:42 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:48933 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248Ab0DJKPl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 06:15:41 -0400
Received: by vws18 with SMTP id 18so416067vws.19
        for <git@vger.kernel.org>; Sat, 10 Apr 2010 03:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=AJU8Mx24lajMprxW/5tEdg9fdbhHsvL3CDqj8J1SwxA=;
        b=s8pkGhNFbn0EWSQv/Gwv3FcarHO40kmqM5bE9lYBlS1PwWSu+PU0UITanbPBaa5BWK
         8s23fiJfqDHxgh9I58PQttOZQESSwr6YaE2KioKjn4ibzo4vu8buzxlIecY8+h8IAhb2
         6sK5COH0FLC9/sWdm+UnE9jnVP0K8GgmtDiZk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=bGCUgpUsdgTq7CXyJA6e9jQTxXXEhFH/HeXfjK5MipYW4cCg/tFrWcHUqG+FlWmdnL
         M6DtWaY5lJ6puU647OcTaAhuFx2QYf+iA2E1ihe75kPzd3FLLm7qR/CEFVjqcWbc5RGn
         M/UxMYkhAm/7hbd5U+WMPkZiMY73Lp32q+2Xk=
Received: by 10.220.126.197 with SMTP id d5mr697447vcs.121.1270894540518;
        Sat, 10 Apr 2010 03:15:40 -0700 (PDT)
Received: from localhost.localdomain ([117.15.72.219])
        by mx.google.com with ESMTPS id 25sm46893343vws.1.2010.04.10.03.15.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 10 Apr 2010 03:15:39 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.2.273.gc2413.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144537>

The second version of the patches.

Bo Yang (2):
  Add a basic idea section for git-blame.
  Change the description of '-M' and '-C' option.

 Documentation/blame-options.txt |   46 +++++++++++++++++++++++---------------
 Documentation/git-blame.txt     |   35 ++++++++++++++++++++++++++++-
 2 files changed, 62 insertions(+), 19 deletions(-)
