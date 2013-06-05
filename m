From: Orgad Shaneh <orgads@gmail.com>
Subject: git rev-parse --show-toplevel doesn't work inside git-dir
Date: Wed, 5 Jun 2013 10:34:11 +0300
Message-ID: <CAGHpTB+AOrQfEGRxQ6qwFMFO0eKBMq19e3fUruNedm81o5rJfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 05 09:34:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uk8Ea-00076D-UD
	for gcvg-git-2@plane.gmane.org; Wed, 05 Jun 2013 09:34:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752072Ab3FEHeN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jun 2013 03:34:13 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:56713 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751723Ab3FEHeM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jun 2013 03:34:12 -0400
Received: by mail-ob0-f176.google.com with SMTP id v19so1980534obq.7
        for <git@vger.kernel.org>; Wed, 05 Jun 2013 00:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=wfXq6Kder77zb0VMGN7Jg5mr8K6iNNcJNXkhp1MMZek=;
        b=X/3rzoPf5WKAYtyI/YkpaQOYQj3/BCoK7YGqIAFLFFoDLOsO4D7qPh8PRjuVgiTB27
         WdY/5Fa3Dj10ou4mgWkFObUy5GSHKQdWp4W83T3uqAP0Z1emEBQqsYEec7kVvwwFPnfB
         uvht3Ghi5MkmttxP6dhIM+cXoWmSujNVoPThfqCB1g7rKufVYYoxc8op+e3OrlbT94mq
         grdwek8ssRoCmT5K/0fq3ASRdFR0RrD5hevxNH2792/9Di6HdcDrd1mMbKUqljd8EXwa
         INbh2lZ1WXfWF5VvNCVkok643trx+XA7KXzXxw3ZgJl5YjDQNAdCZ67AfGKWYIDqCzt6
         kWgA==
X-Received: by 10.60.42.237 with SMTP id r13mr14585299oel.61.1370417651855;
 Wed, 05 Jun 2013 00:34:11 -0700 (PDT)
Received: by 10.182.79.34 with HTTP; Wed, 5 Jun 2013 00:34:11 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226440>

Running "git rev-parse --show-toplevel" doesn't print anything when it
is run inside .git dir (on all levels)

- Orgad
