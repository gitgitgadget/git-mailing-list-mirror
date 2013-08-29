From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/3] reset: refactor into --stage and --work
Date: Thu, 29 Aug 2013 13:19:54 -0500
Message-ID: <1377800397-5434-1-git-send-email-felipe.contreras@gmail.com>
References: <20130829180129.GA4880@nysa>
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 29 20:24:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF6tn-0007kH-Nm
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 20:24:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756696Ab3H2SYr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 14:24:47 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:38029 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756693Ab3H2SYp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 14:24:45 -0400
Received: by mail-ob0-f178.google.com with SMTP id ef5so866496obb.23
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 11:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QwXIVGVPN52qgrX55RLykwL+hpC4YaiPA7cKwYc9uUw=;
        b=NbSLu6m9q2WUqKzfCtoAFrD+ciLFqv9TrVNxzuuwg6KQCzDj0+zsHvYhtsteU1iSCO
         pfuxA2LLQ0BTc1JAiAXByQjXUvnAq/Xa98RGkhWgeHHmvYRREmQpS1aVUtwVNEDUO2me
         UDNgS5l77DafRZ7A8a+ngDnVLu/tW7m2XeoxXxkFyNZ+PPn/lm3eSJLRC3GgbeB1+f3D
         6CI3+NIfHbx0xJtRnqZ2Tk3c0XUDcxP/2BDWXhH6nN1BGVZzMu1k7KVfmXMsaSh9QIeB
         xXOOYrzSXbjikmmciZE5Un6AJHQwQZopiX69ql2kQm90xY1Iputnr+JtYXW3kJUSuBOv
         D3IA==
X-Received: by 10.60.43.169 with SMTP id x9mr1158756oel.88.1377800685303;
        Thu, 29 Aug 2013 11:24:45 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id qi5sm32713749obb.6.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 29 Aug 2013 11:24:44 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <20130829180129.GA4880@nysa>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233320>

Hi,

This patch series is not really necessary for the whole --stage series, but it
makes sense while we are at it.

Felipe Contreras (3):
  reset: add --stage and --work options
  reset: allow --keep with --stage
  completion: update 'git reset' new stage options

 Documentation/git-reset.txt            |  8 ++++++++
 builtin/reset.c                        | 27 +++++++++++++++++++++++++++
 contrib/completion/git-completion.bash |  3 ++-
 3 files changed, 37 insertions(+), 1 deletion(-)

-- 
1.8.4-fc
