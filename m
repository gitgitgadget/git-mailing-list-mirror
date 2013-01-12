From: Chris Rorvick <chris@rorvick.com>
Subject: [PATCH v2 0/3] fixup remaining cvsimport tests
Date: Sat, 12 Jan 2013 00:21:40 -0600
Message-ID: <1357971703-28513-1-git-send-email-chris@rorvick.com>
Cc: "Eric S. Raymond" <esr@thyrsus.com>,
	Junio C Hamano <gitster@pobox.com>,
	Chris Rorvick <chris@rorvick.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 12 07:23:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtuVT-0004F2-UN
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jan 2013 07:23:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752026Ab3ALGXL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2013 01:23:11 -0500
Received: from mail-ie0-f179.google.com ([209.85.223.179]:48077 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751604Ab3ALGXL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2013 01:23:11 -0500
Received: by mail-ie0-f179.google.com with SMTP id k14so3204848iea.38
        for <git@vger.kernel.org>; Fri, 11 Jan 2013 22:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=0DXMcDSfpuJSc9ZRENR9PWWhDIgxnsI2SmMsP7axsVw=;
        b=RXEEwwInJXBkbKlbDDTdDrJX3PCtXFSvpOtCd7BE8gdWTv7QJdQqih9F9etXebnimV
         wmqKqRvFRqkdQBF6kHMSBFpB96HxrWGyAnMX3tDW0GZBUyb3ayc+YQQ9Y+Zk+VE0H8N1
         wVVIzJMLiv+PcZFiQqLTIQkH/+MF+kAVBZEOx4EiJWHfOCDwOh85uOLP22PEU5uTp+fN
         F4fRdG4IHMAhvymmUedFfb0CTMgEW+LXJdpz6pd8DpyNzysZLxAly+KsraFhQQW0jlwG
         e2L78iUiB7sX6cMQc5KcSNjEMmchLHWlPH0wC6zEmF/tMJXa183gMI3Uf1E2SCn5xBWP
         AlFg==
X-Received: by 10.50.10.232 with SMTP id l8mr1270979igb.105.1357971790304;
        Fri, 11 Jan 2013 22:23:10 -0800 (PST)
Received: from marlin.localdomain (adsl-70-131-98-170.dsl.emhril.sbcglobal.net. [70.131.98.170])
        by mx.google.com with ESMTPS id ww6sm1426280igb.2.2013.01.11.22.23.07
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 11 Jan 2013 22:23:09 -0800 (PST)
X-Mailer: git-send-email 1.8.1.rc3.335.g88a67d6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213268>

Reroll w/ sign-off.

Chris Rorvick (3):
  t/lib-cvs.sh: allow cvsps version 3.x.
  t9600: fixup for new cvsimport
  t9604: fixup for new cvsimport

 t/lib-cvs.sh                    |  2 +-
 t/t9600-cvsimport.sh            | 10 ++++------
 t/t9604-cvsimport-timestamps.sh |  5 ++---
 3 files changed, 7 insertions(+), 10 deletions(-)

-- 
1.8.1.rc3.335.g88a67d6
