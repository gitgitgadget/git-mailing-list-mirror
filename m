From: dturner@twopensource.com
Subject: (unknown)
Date: Mon, 11 May 2015 13:56:26 -0400
Message-ID: <1431366989-7405-1-git-send-email-dturner@twopensource.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 11 19:57:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yrrwt-0004Sx-1X
	for gcvg-git-2@plane.gmane.org; Mon, 11 May 2015 19:57:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753603AbbEKR4x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2015 13:56:53 -0400
Received: from mail-qg0-f50.google.com ([209.85.192.50]:32850 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753572AbbEKR4t (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2015 13:56:49 -0400
Received: by qgdy78 with SMTP id y78so71933175qgd.0
        for <git@vger.kernel.org>; Mon, 11 May 2015 10:56:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=APuWZZ5iD9ctjqNnUaTkRZR1d8mMMMTFu8RYl0vHmDg=;
        b=ftbL9yBDot+1U6FTEtQnASUgoAEYv+lyQcrzM65h/g4Jf4rfJOykWe8hOK0yu3a2ZK
         ECgwqPdpXQY1WWlEabbwRw6UlbE7RqCiu6PaF+cE58f6u28D0o8M3wn0IZijK81J+B+Q
         JQoCzbY49pr9nUM+UzdPGgJavFi5Adkk7DFrew+1r/TFd1v2t1QXQvbIDs97QojmxGLg
         PhFYfx11sCNYTodSzFDwFPnFGN8BUfF1E6WWVY12J3SyyY9uTe6ZDEFCPvqBbhFsOsvo
         F4N1WFwa1SKkPoiohOfc52jZPs2d78J9uyEPlXmXXxiErfQVS+1Ul7y5aUsLPd9ORiI5
         z4Bg==
X-Gm-Message-State: ALoCoQlC0LIJmwyB7HVFgUYJb3JOLWsWIinBlrQ/WerTAKk3Wcrr1cpbH0A49/kSWbtdQXZKIjjk
X-Received: by 10.140.108.74 with SMTP id i68mr14767201qgf.73.1431367008936;
        Mon, 11 May 2015 10:56:48 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by mx.google.com with ESMTPSA id 20sm11093161qhf.14.2015.05.11.10.56.46
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 11 May 2015 10:56:47 -0700 (PDT)
Subject: 
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268805>

This version includes style fixups suggested by Junio Hamano.  As
suggested, I moved the addition of the new object_context field to the
patch where it is used.

In addition, I moved a few variables into smaller scopes.

I also (hopefully) fixed the tests on Windows thanks to some
suggestions from Johannes Sixt
