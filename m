From: David Turner <dturner@twopensource.com>
Subject: [PATCH v8 0/3] git cat-file --follow-symlinks
Date: Wed, 13 May 2015 14:21:28 -0400
Message-ID: <1431541291-21675-1-git-send-email-dturner@twitter.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 13 20:21:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsbHr-0000T8-2y
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 20:21:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752956AbbEMSVi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 14:21:38 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35571 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752391AbbEMSVh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2015 14:21:37 -0400
Received: by pabtp1 with SMTP id tp1so58289727pab.2
        for <git@vger.kernel.org>; Wed, 13 May 2015 11:21:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=DQV8Z5aXD8yE9xAJLRuolZoncl5CWJ8SP0Mnoi8TcSo=;
        b=FYrSZoDM3tpvnI0NPeqOZIETERahsxZtXoP7jMjilGODZmB9eIHrtjIV26NBYeenSc
         8vIr3LAC6rQwoJUDaOcrBC24vRWALEtayKm4ffQWSqNpIUSWxjJSwTkQiqyKUMxiQ6EW
         RoYqOodK3MCVJRqEuPgMhXspXV0QN6BRSC+7KspDBKoCVkxmtAUHIY5A2nrYQ6TFFo7l
         +noFR4bVac29NinsVfIcKHCYojHsYUUWp5O4EBuFeU0VOw+Oqb6lp/IAQ3pwETNP+2/r
         3GYKkPouFdDk42+7jXajsAiJ1AFuQrdzDPb/jHupTrCq3WTTreC3Z0A5AikX29fHIy/4
         KWVQ==
X-Gm-Message-State: ALoCoQl0MjiiJibTpWDK5fRTNLeMubdrGq/dl3ryX4h4rproEAaHUPvI3k1EDzZWxSSsKtLTto8X
X-Received: by 10.70.52.103 with SMTP id s7mr298329pdo.117.1431541296790;
        Wed, 13 May 2015 11:21:36 -0700 (PDT)
Received: from ubuntu.twitter.corp ([8.25.196.26])
        by mx.google.com with ESMTPSA id td3sm20107318pab.46.2015.05.13.11.21.34
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 May 2015 11:21:36 -0700 (PDT)
X-Google-Original-From: David Turner <dturner@twitter.com>
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268995>

This version includes the following:
(a) fix leak in tree-walk.c, thanks to Jeff King
(b) asciidoc now correctly indented when rendered as HTML and when
rendered as a man page.
(c) type casting is now correct
(d) Added a default to switch statement to shut up stupid compilers.
