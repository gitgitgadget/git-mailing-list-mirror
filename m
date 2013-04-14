From: Ilya Basin <basinilya@gmail.com>
Subject: cvsps: bad usage: invalid argument --norc
Date: Sun, 14 Apr 2013 12:18:34 +0400
Message-ID: <323381594.20130414121834@gmail.com>
Reply-To: Ilya Basin <basinilya@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: esr@thyrsus.com
X-From: git-owner@vger.kernel.org Sun Apr 14 10:20:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URIAY-0004Vk-If
	for gcvg-git-2@plane.gmane.org; Sun, 14 Apr 2013 10:20:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303Ab3DNIUI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 04:20:08 -0400
Received: from mail-la0-f44.google.com ([209.85.215.44]:36860 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750886Ab3DNIUG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Apr 2013 04:20:06 -0400
Received: by mail-la0-f44.google.com with SMTP id fr10so3596349lab.17
        for <git@vger.kernel.org>; Sun, 14 Apr 2013 01:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:x-mailer:reply-to:x-priority:message-id:to:cc
         :subject:mime-version:content-type:content-transfer-encoding;
        bh=3ScFLP4YY/P3GgYqnXO4FljAsuaAidBMoS6olbuL20Y=;
        b=qe51QByeb4Plycd7EoRRnf7L5c7joft+Sgf7lvWwP4gp3mtgGqg6JGfmQA840JPfho
         0zmTeGC0WakZf1rVvKslCcaloT0F54toH6O8tBiXLlNXhF40co3qJc37EOBTIk7I9hPX
         cgmR5OOgrTMUx7V4rdw/v/PrhDdL7hBRSEOb5zHMXh49MKZ5r6lzBlfZ+0uKEtGZWyE+
         99ixET8ILQQd4XnDN/L7FMHcVTi0Cb+yWvLrp7iVCRvpTcgYKY7NmtCzPpbA7M9mb26L
         TaO1ySfOpRmyIhIKmsdCzCbJAF5M8VAfEJvTD626vyCTtxJQNrPCprYT3tIjLHnKGGX4
         m/Xg==
X-Received: by 10.152.18.164 with SMTP id x4mr5208870lad.38.1365927604948;
        Sun, 14 Apr 2013 01:20:04 -0700 (PDT)
Received: from [192.168.0.78] (92-100-235-194.dynamic.avangarddsl.ru. [92.100.235.194])
        by mx.google.com with ESMTPS id or9sm5914511lbb.8.2013.04.14.01.20.03
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 14 Apr 2013 01:20:03 -0700 (PDT)
X-Mailer: Voyager (v3.99.4) Professional
X-Priority: 3 (Normal)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221086>

Hi esr.
In cvsps 3.10 the flag --norc was removed. It broke 'git cvsimport'.
Please give the option back and write something in the man page like:
    This option has no effect; it is present for compatibility
