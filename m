From: "Philip Oakley" <philipoakley@iee.org>
Subject: Confused by git am error message.
Date: Tue, 18 Sep 2012 22:51:39 +0100
Organization: OPDS
Message-ID: <747F66C694C844EAA56F4BB62C405F78@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: "Git List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 18 23:51:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TE5h4-00045y-V8
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 23:50:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755763Ab2IRVuu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 17:50:50 -0400
Received: from out1.ip01ir2.opaltelecom.net ([62.24.128.237]:64878 "EHLO
	out1.ip01ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755741Ab2IRVuq (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Sep 2012 17:50:46 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AqsMAIfrWFBZ8rU+/2dsb2JhbABFi0ivbwQBAoEEgQmCGxQBAS4eAQEcEAIIAgEkOQEEGgYHHRsCAQIDAYdzmH6GUJsEjQ4EF4QCYAOIIYVEmB+CZw
X-IronPort-AV: E=Sophos;i="4.80,445,1344207600"; 
   d="scan'208";a="404112716"
Received: from host-89-242-181-62.as13285.net (HELO PhilipOakley) ([89.242.181.62])
  by out1.ip01ir2.opaltelecom.net with SMTP; 18 Sep 2012 22:50:44 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205879>

[a user confusion report]
I was updating my patch series manually aand made a mistake, so the 
series didn't apply properly. However the error message confused me.

    ...
    Applying: Doc clean: add See Also links
    fatal: corrupt patch at line 17
    Patch failed at 0008 Doc clean: add See Also links
    When you have resolved this problem run "git am --resolved".
    ...

In my case I resolved the _patch_ error, and then expected that doing 
the 'git am --resolved' would try to re-apply the patch and continue 
happily - I had checked that the status was clean - but it didn't.

    Philip@PHILIPOAKLEY /c/msysgit179/git (nextDoc|AM)
    $ git am --resolved
    Applying: Doc clean: add See Also links
    No changes - did you forget to use 'git add'?
    If there is nothing left to stage, chances are that something else
    already introduced the same changes; you might want to skip this 
patch.

I'm not quite sure what the 'right' answer should be, maybe a --reapply 
option, or slightly different words in the message to highlight that the 
user is to make their worktree/index look like the patch _had_ applied, 
or something else?

Philip
