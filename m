From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: Re: gitk: can't reload commits with new key binding
Date: Mon,  1 Oct 2012 11:26:30 -0400
Message-ID: <1349105191-31681-1-git-send-email-andrew.kw.w@gmail.com>
References: <20120930101932.GA15672@goldbirke>
Cc: szeder@ira.uka.de, paulus@samba.org,
	Andrew Wong <andrew.kw.w@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 01 17:27:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIhtc-0000GR-Q8
	for gcvg-git-2@plane.gmane.org; Mon, 01 Oct 2012 17:27:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751700Ab2JAP0u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2012 11:26:50 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:33650 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751548Ab2JAP0t (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2012 11:26:49 -0400
Received: by ieak13 with SMTP id k13so12379814iea.19
        for <git@vger.kernel.org>; Mon, 01 Oct 2012 08:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=cip6794tQlgWGUnzy10zarJ1shBszo2e+rIa7lN0yFw=;
        b=Cog8TZOsbU8K9qCPpIYg+Oq7l4oW6JJNakkz38/yTya6c6Z2K95HeLlLuctU8t8jEg
         DSM+21KIJRs+0eEcbFPp0YuRxKY8kbjqUls2AgjgAO5/HIoOMRUnxpIAxK5wt6gRgV1b
         TmU5mBGuKEQJBpqxl2Efos99j4fXSQvqpXIeRYwTcMblZD50m65wPNV1995s0R5gLIwn
         qdSDMh/a45d8jNgFSP6C1ie+mI8/2cwv7WCKEj0JQ5np9nD5pjruIu937LAXGiNZTOlr
         Fpt2uohjkP2yyXdGzCeBWT1hT4a+CWPr1wGyRYAU+NjrcNC1dj+OZhOPpf1M+aZneHnv
         HKjw==
Received: by 10.50.178.33 with SMTP id cv1mr708156igc.72.1349105208880;
        Mon, 01 Oct 2012 08:26:48 -0700 (PDT)
Received: from nigel.sohovfx.com ([66.207.196.114])
        by mx.google.com with ESMTPS id ch4sm6726712igb.2.2012.10.01.08.26.47
        (version=SSLv3 cipher=OTHER);
        Mon, 01 Oct 2012 08:26:48 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.1.382.gb0576a6
In-Reply-To: <20120930101932.GA15672@goldbirke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206737>

Sorry, my previous "git send-email" screwed up. Resending the email again.

I was running into the same issue too. It turns out that on some machines
Shift-F5 is mapped to Shift-XF86_Switch_VT_5. My patch includes a workaround.
The same workaround was used for Shift-F4.

Andrew Wong (1):
  gitk: Add workaround for system where Shift-F5 mapped to
    Shift-XF86_Switch_VT_5

 gitk-git/gitk | 1 +
 1 file changed, 1 insertion(+)

-- 
1.7.12.1.382.gb0576a6
