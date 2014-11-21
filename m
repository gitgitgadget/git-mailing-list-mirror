From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 0/3] mergetool/difftool cleanup
Date: Thu, 20 Nov 2014 17:20:26 -0800
Message-ID: <1416532829-68662-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 21 02:20:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xrcu0-0006Aj-9O
	for gcvg-git-2@plane.gmane.org; Fri, 21 Nov 2014 02:20:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757364AbaKUBUn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2014 20:20:43 -0500
Received: from mail-pa0-f45.google.com ([209.85.220.45]:60739 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757360AbaKUBUm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2014 20:20:42 -0500
Received: by mail-pa0-f45.google.com with SMTP id lj1so3718210pab.32
        for <git@vger.kernel.org>; Thu, 20 Nov 2014 17:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=vN6SOX1xxSHWRy4PoNA/x3whWdEszfsvls1u4wu8Mv0=;
        b=bQ55tcyBPtBKb2jVR+C+oml838tsNmH2OdmB49NNhOs2Cof8gdae5vOLbMzVjVlcuH
         oSBfKEQbhqVzfuU3hz7UNreKg6OeQQ5Bq7IegJEEW8q7XDuoUh4+XL7Qt7mo/eRPH2Le
         NWh3de6Hs86n4lNCj6aoK3fcwpMyXPjnW5hrVTDk6HR8kRMKcot+4bU8Ui6eV+2jcXj8
         CSlxOeWE4GvpEOtUpoxQhmeHH6KNNCm8LMGUQHeW6A/JmHH4C6oH/FoT3oGQQ46wGNng
         6L0RIy+rmfHVBEkcNm3zh9nbrM487tyXk0adymlup2RZRu1Fvoo026mx68+4/Foep5o8
         C+xg==
X-Received: by 10.70.34.206 with SMTP id b14mr2451970pdj.10.1416532842271;
        Thu, 20 Nov 2014 17:20:42 -0800 (PST)
Received: from lustrous.local.com (wdas-1.disneyanimation.com. [198.187.190.1])
        by mx.google.com with ESMTPSA id w5sm3151439pds.25.2014.11.20.17.20.34
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 20 Nov 2014 17:20:41 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc2.26.g3e3388f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a cleanup series to remove the use of the $status
global variable in mergetool/difftool.

This should wait until after the current RC series is
over but figured I'd send it out.

David Aguilar (3):
  mergetool--lib: remove use of $status global
  difftool--helper: add explicit exit statement
  mergetool: simplify conditionals

 git-difftool--helper.sh |  2 ++
 git-mergetool--lib.sh   | 20 +++++---------------
 git-mergetool.sh        | 16 +++++-----------
 3 files changed, 12 insertions(+), 26 deletions(-)

-- 
2.2.0.rc2.26.g3e3388f
