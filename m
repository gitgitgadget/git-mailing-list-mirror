From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: gitk --follow doesn't show changes correctly
Date: Thu, 21 Jun 2012 15:09:17 +0200
Message-ID: <4FE31CFD.1000208@viscovery.net>
References: <CAPyqok3Nh7jzwDS31xnFQm1h9=ttxmqoYt_tsLLUqpmi_4NWcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Petr Onderka <gsvick@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 21 15:09:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Shh8Y-0005R2-2J
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jun 2012 15:09:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759584Ab2FUNJW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jun 2012 09:09:22 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:65295 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759556Ab2FUNJV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2012 09:09:21 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.76)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Shh8P-0001Qm-Pc; Thu, 21 Jun 2012 15:09:17 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 857DD1660F;
	Thu, 21 Jun 2012 15:09:17 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:13.0) Gecko/20120604 Thunderbird/13.0
In-Reply-To: <CAPyqok3Nh7jzwDS31xnFQm1h9=ttxmqoYt_tsLLUqpmi_4NWcQ@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200401>

Am 6/21/2012 14:56, schrieb Petr Onderka:
> if I try to see the history of a file across copies by "gitk --follow file",
> it seems it shows the correct revisions (although disconnected),
> but for revisions that modify the file under some older name,
> the diff of those changes is not shown.

--follow is a bolted-on feature. Do not expect it to work according to
your expectations ;)

> For example, I have a file f1, modify it in revision A,
> then copy it to f2 and modify it in revision B,
> and finally modify f2 in revision C.
> 
> If I execute "gitk --follow f2", I can see revisions A, B and C.
> But in revision B, the diff shown contains the whole of f2 (as a new file)
> and the diff for revision A is completely empty.
> 
> What I'd like to see in revision B is the diff between f2 and f1 at that point
> and in revision A the diff for f1.

Turn off "Limit diffs to listed paths" in gitk's settings. Perhaps this
shows the changes (among the changes of all other files per commit, of
course).

-- Hannes
