From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH 2/2] MinGW: Add missing file mode bit defines
Date: Wed, 30 Dec 2009 01:51:01 +0100
Message-ID: <bdca99240912291651j6d67040et5151096416ab4bd6@mail.gmail.com>
References: <hhblfa$di8$2@ger.gmane.org> <4B3A702C.5040408@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Dec 30 01:51:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPmmO-0001RK-62
	for gcvg-git-2@lo.gmane.org; Wed, 30 Dec 2009 01:51:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbZL3AvI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2009 19:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbZL3AvH
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Dec 2009 19:51:07 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:25105 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751225AbZL3AvD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2009 19:51:03 -0500
Received: by fg-out-1718.google.com with SMTP id 22so4710220fge.1
        for <git@vger.kernel.org>; Tue, 29 Dec 2009 16:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=KMdWQtwOcvSiedtcuK8JzOrceou/9ekSEFTv8n4kKUE=;
        b=M2L4kis/PFoaOBC5dNSH5qzQa7hGJcBNdWU+Wp1+mASAFg+54v2xRARzFsOHGbRPaR
         hS+2MtgKSqj7VeYSzJHaY74ff3iU4kL1kr+Mp07XdH6pn3OG30doi9RKzC4A9GuX6bC3
         EB8R/0y79vOh99UybH1kad9kqwaJwLNMbmZNs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=ZhfJOsjBcYnGd7i68AzDURFIE9nu2dId4Q/DqJry8bTQoDpEEZaBGVMmoRXkotgYdm
         6yfPM/8AYutb3qddjG9s8+JSayvIHq/90eaDLMQxOYG2kbA4sH5ImPq9thq28Y5ZOLE4
         UVZA1k77+FToQ2DXdYsulmYxoNJzAt2bPTnm4=
Received: by 10.87.42.37 with SMTP id u37mr4734339fgj.68.1262134262012; Tue, 
	29 Dec 2009 16:51:02 -0800 (PST)
In-Reply-To: <4B3A702C.5040408@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135845>

>> MinGW: Add missing file mode bit defines
>
> Why this? What's the problem with the status quo?

Same here as for the "Use pid_t more consequently" patch, hd2u
required one of the missing defines to compile for msysGit.

-- 
Sebastian Schuberth
