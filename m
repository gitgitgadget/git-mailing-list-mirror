From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: [PATCH] cvsexportcommit: add some examples to the documentation
Date: 29 Jan 2006 22:25:56 -0800
Message-ID: <86slr6i64r.fsf@blue.stonehenge.com>
References: <11386015522537-git-send-email-martin@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 30 07:26:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3SUS-0002MD-8G
	for gcvg-git@gmane.org; Mon, 30 Jan 2006 07:26:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbWA3G0D (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jan 2006 01:26:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbWA3G0C
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jan 2006 01:26:02 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:55466 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1751254AbWA3G0B (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2006 01:26:01 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id C50168E49B;
	Sun, 29 Jan 2006 22:25:56 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 13631-01-7; Sun, 29 Jan 2006 22:25:56 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 5518D8E4B8; Sun, 29 Jan 2006 22:25:56 -0800 (PST)
To: Martin Langhoff <martin@catalyst.net.nz>
x-mayan-date: Long count = 12.19.13.0.2; tzolkin = 8 Ik; haab = 0 Pax
In-Reply-To: <11386015522537-git-send-email-martin@catalyst.net.nz>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15261>

>>>>> "Martin" == Martin Langhoff <martin@catalyst.net.nz> writes:

Martin> +$ git-cherry cvshead myhead | grep '^+' | sed 's/^+ //' | xargs -l1 git-cvsexportcommit -c -p -v

My idiom for that grep/sed would be:

  ... | sed -n 's/^+ //p' | ...

Then the grep is not needed, because you're printing only the ones
that you've also modified in a useful way.

Yes, I did a heckuva lot more shell programming long before Perl existed. :)

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
