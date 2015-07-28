From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Log messages beginning # and git rebase -i
Date: Tue, 28 Jul 2015 17:25:49 +0200
Message-ID: <vpqsi88qp6q.fsf@anie.imag.fr>
References: <loom.20150727T133256-715@post.gmane.org>
	<CAPig+cRT6=YCHz+phfE+84y27ey-6ScjPxP2cHiVqumJmR6mOw@mail.gmail.com>
	<loom.20150728T115023-269@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Ed Avis <eda@waniasset.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 17:26:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZK6lT-0005ef-Pe
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 17:26:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752032AbbG1PZz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 11:25:55 -0400
Received: from mx2.imag.fr ([129.88.30.17]:49328 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751124AbbG1PZy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 11:25:54 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t6SFPl6j027537
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 28 Jul 2015 17:25:48 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t6SFPnr1001832;
	Tue, 28 Jul 2015 17:25:50 +0200
In-Reply-To: <loom.20150728T115023-269@post.gmane.org> (Ed Avis's message of
	"Tue, 28 Jul 2015 09:51:40 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 28 Jul 2015 17:25:48 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t6SFPl6j027537
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1438701950.44687@sWyv8uMUMAxg1wV07ci9Vw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274776>

Ed Avis <eda@waniasset.com> writes:

> Eric Sunshine <sunshine <at> sunshineco.com> writes:
>
>>>the editing for the
>>>combined log message treats lines beginning with # as comments.  This means
>>>that if you are not careful the commit message can get lost on rebasing.
>>>
>>>I suggest that git rebase should add an extra space at the start
>
>>'git rebase --interactive' respects the core.commentChar configuration
>>variable, which you can set to some value other than '#'.
>
> I was thinking of the default configuration.  But you are right, this applies
> to whatever the comment character is - so if commentChar is set to * for
> example, then log lines beginning with * should get an extra space prepended
> in git rebase --interactive so that they don't get lost.

Actually, is there any reason why we do not allow a simple escaping like

\# this is a line starting with #
\\ this is a line starting with \
# this is a comment

?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
