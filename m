From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH 0/2] completion: git-help: add missing option and params
Date: Thu, 24 Mar 2016 19:27:12 +0100
Message-ID: <1458844034-12855-1-git-send-email-ralf.thielow@gmail.com>
Cc: Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 24 19:27:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aj9yg-0001wF-2p
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 19:27:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751548AbcCXS1V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 14:27:21 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32942 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751108AbcCXS1U (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 14:27:20 -0400
Received: by mail-wm0-f67.google.com with SMTP id u125so14746865wmg.0
        for <git@vger.kernel.org>; Thu, 24 Mar 2016 11:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=gdi+lcZWlPt5Of69XJ4guPqbFb9TN/r78rI+VtTY9Fc=;
        b=aakvltuWLF9Wd3zb7Q/ArErKBwsrpToBy01gktT3uH0AmKQ8ZxxYFRw9rKnf9Wcb03
         TfKYtfyvo2K1/y8HufaRDVBsCBnn/I1kaMFSd+diA1OgwnMkS6SAKuqN530fwtEiDE8v
         6vS/qxRprerX3VybfZ7gI9LaaH5WYu+UBJgBzRqShdOeqqJhpP6/nvc/p+q9OytkKB9M
         Hrp+7F6206Qe0nBtwSQOiVZns7OqufJT6lxcnounihxF0C85raiRQRjPRs7vFq4/8ltw
         698otCYx//PeMtOqLr+Quh5fBrUIb1+lKlrLxTcUdtJCrnYsxcRxoRztz0sozl154hPS
         VGbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gdi+lcZWlPt5Of69XJ4guPqbFb9TN/r78rI+VtTY9Fc=;
        b=HOlIMmxEYcTlR4cFQoZRmL5rmATjo4ixG6W2UWHaWpxXJyFOXjgI5rckNNzG7Y9FGJ
         8+rm9nQz477rvvfeCdHOjmN5vn1yqvYwxOYz6bCiIzxzuV+RmfXnwH+N68K6E67Ee07v
         rNNrFyyvB38+RKbKV6vmaCx+WUACO/C3Ck4W2fAeOgpSDLxsqr1LEhTUIh+Nl3saJ7JG
         unpNLaa734hHYYqPJzyHXZ3LKgUNUr1S/mQmowpMjmepdgzCwNhlcfxnY4jVMpWEOsNl
         udDqdVU4E6DIaHy7q4RwMzOpVJSAZnOfW7s5MnMBU/UuswbDMYhRg8CDwh5QxC2hfkN6
         GBow==
X-Gm-Message-State: AD7BkJIbG0Na/a/seoz/TprIYh0PgKClWAFDThPCNnmfknAI3UAtEJTbLBJBJA5iRr6RVA==
X-Received: by 10.194.120.229 with SMTP id lf5mr12391600wjb.151.1458844038402;
        Thu, 24 Mar 2016 11:27:18 -0700 (PDT)
Received: from localhost (cable-82-119-18-125.cust.telecolumbus.net. [82.119.18.125])
        by smtp.gmail.com with ESMTPSA id l135sm8934354wmb.13.2016.03.24.11.27.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 24 Mar 2016 11:27:17 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.rc4.7.g35d7ca9.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289781>

The bash completion is missing the option '--guides' for 'git-help'
and some params you see there.  Add them both.

Ralf Thielow (2):
  completion: add option '--guides' to 'git help'
  completion: add 'revisions' and 'everyday' to 'git help'

 contrib/completion/git-completion.bash | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.8.0.rc4.7.g35d7ca9.dirty
