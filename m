From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: [PATCH 0/2] Unify the style of user messages
Date: Mon, 19 Mar 2012 18:51:41 +0100
Message-ID: <1332179503-2992-1-git-send-email-vfr@lyx.org>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 19 18:52:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9gkW-0004It-4g
	for gcvg-git-2@plane.gmane.org; Mon, 19 Mar 2012 18:52:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030364Ab2CSRv7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Mar 2012 13:51:59 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:64077 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965056Ab2CSRv6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2012 13:51:58 -0400
Received: by eaaq12 with SMTP id q12so2774990eaa.19
        for <git@vger.kernel.org>; Mon, 19 Mar 2012 10:51:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:x-gm-message-state;
        bh=aIDhln6YScGKsTSMszHg5AeWkW0VBbcgeyJw+gy9rk0=;
        b=jmppbyZyoR41UPgt/ZhtFyeyhei1FtRYMGa+jwk/jrLa0hDbf1p6RPADhpxAFKrpkZ
         ctVvmKZhzj1inotewiKbnzfO3f5FZTIasWvKAS3glYlc+RoBNy3EloezGSLVdtUggQIG
         +LAMniTahL+x2VznZsq+Bto2QAir99zNPusfKA9PyuhWVYqZkj+phTiHbT+GKVS+34DJ
         3Peb2rMZikuYZBG1bZ5RlBgOERlKNcxDYPg6HdTeJ7TeBxcKimANkTds97gJErb5Lo5v
         urbbASWcxNPwtLYmZlw9JF9L+C3sp5pbpgWg9icvDvHDKj+7LFHYIR+Wp9zJPg3Itlt+
         qRfw==
Received: by 10.213.22.143 with SMTP id n15mr394263ebb.84.1332179517072;
        Mon, 19 Mar 2012 10:51:57 -0700 (PDT)
Received: from localhost.localdomain (j175101.upc-j.chello.nl. [24.132.175.101])
        by mx.google.com with ESMTPS id m42sm21762289eef.0.2012.03.19.10.51.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 19 Mar 2012 10:51:56 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.4
X-Gm-Message-State: ALoCoQkFUNJiSndSLKAHx7n38LPreOUMAzv2KxZZc/oXoc8MeNqjmaTMvF9dhIhb7WiS8wMf0NVd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193444>




While working on the translations, I came accross these strings. There doesn't seem to be a rule on how these messages should be formatted (or there is, then I didn't look well enough).

To me it feels better to standardize the style, so I looked in the sourcecode for which style is used most and composed some guidelines to unify the messages:
    - messages start with a capital,
    - short messages do not end with a full stop,
    - paths, filenames, and commands are quoted by single quotes (if not separated by the normal text by a ':'),
    - 'could not' is used rather than 'cannot'. 

There could of course be much more changes, but I don't know whether these changes are appreciated. Also, the guidelines might be disputable. Maybe it is not the best timing because we are in rc phase and the people start to translate. On the other hand, we might better change it before all translations are finished.

The second patch makes a few string translatable. 

Vincent
