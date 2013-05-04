From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/2] remote-bzr: couple of fixes
Date: Fri,  3 May 2013 19:22:35 -0500
Message-ID: <1367626957-13858-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 04 02:24:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYQGs-0000j4-Ho
	for gcvg-git-2@plane.gmane.org; Sat, 04 May 2013 02:24:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762658Ab3EDAX5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 May 2013 20:23:57 -0400
Received: from mail-ye0-f182.google.com ([209.85.213.182]:58758 "EHLO
	mail-ye0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755599Ab3EDAX4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 May 2013 20:23:56 -0400
Received: by mail-ye0-f182.google.com with SMTP id m15so382699yen.13
        for <git@vger.kernel.org>; Fri, 03 May 2013 17:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=UUaUKnT9FWbtGhz99YLNnpiOahW85zP6UR5SQ0SjB5I=;
        b=qvspFyMiLWKv7BApGSGgXUnROy8hs7gzKKv+xZmhRuOjQ/snrlPXs8wdL9lFQ4QnOX
         w5wfO8zsioaPt9vG4QntvndpD9RySi+YzuQ+YbmmLy7vpeHT4lPtTLN5yvPtCXehziZr
         QadKtPnEVybtXmPXC9knBlDOQ+kJEn+IY3SVPk3jzo7FjT7l3VrG8c1MLeM6eCc2ec6v
         JWXTZi8a1V76F3F/FknX6wFA5BL1wFXIfzhN3H0brfdAp8CWmVdtqVrxDQaOSwddhAkD
         kpJfMCR3yV/Mjkw5HAPsgygfcNg3kXPcsCCmXSHIqMpjL4Tyb/57LcQIYkD/QL9HP6Jm
         Un0Q==
X-Received: by 10.236.125.230 with SMTP id z66mr10853948yhh.174.1367627036175;
        Fri, 03 May 2013 17:23:56 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id g24sm24939325yhm.0.2013.05.03.17.23.54
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 03 May 2013 17:23:55 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc0.401.g45bba44
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223341>

Hi,

A few fixes to be applied on top of the massive changes already queued. Nothing major.

Felipe Contreras (2):
  remote-bzr: convert all unicode keys to str
  remote-bzr: avoid bad refs

 contrib/remote-helpers/git-remote-bzr | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

-- 
1.8.3.rc0.401.g45bba44
