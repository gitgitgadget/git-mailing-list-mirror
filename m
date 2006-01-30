From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: [PATCH] cvsexportcommit: add some examples to the documentation
Date: 29 Jan 2006 22:30:57 -0800
Message-ID: <86oe1ui5we.fsf@blue.stonehenge.com>
References: <1138602541556-git-send-email-martin@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 30 07:31:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3SZ3-0002u4-Ck
	for gcvg-git@gmane.org; Mon, 30 Jan 2006 07:31:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbWA3Ga7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jan 2006 01:30:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbWA3Ga7
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jan 2006 01:30:59 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:65204 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1751254AbWA3Ga6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2006 01:30:58 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 4282D8E67F;
	Sun, 29 Jan 2006 22:30:58 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 13631-01-17; Sun, 29 Jan 2006 22:30:57 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id CB5AD8EBD9; Sun, 29 Jan 2006 22:30:57 -0800 (PST)
To: Martin Langhoff <martin@catalyst.net.nz>
x-mayan-date: Long count = 12.19.13.0.2; tzolkin = 8 Ik; haab = 0 Pax
In-Reply-To: <1138602541556-git-send-email-martin@catalyst.net.nz>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15263>

>>>>> "Martin" == Martin Langhoff <martin@catalyst.net.nz> writes:

Martin> +$ git-cherry cvshead myhead | sed 's/^+ //p' | xargs -l1 git-cvsexportcommit -c -p -v

But you forgot the -n. :)


-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
