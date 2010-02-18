From: Jon Seymour <jon.seymour@gmail.com>
Subject: RFD: best way to automatically rewrite a git DAG as a linear history?
Date: Thu, 18 Feb 2010 13:35:07 +1100
Message-ID: <2cfc40321002171835j107d2cdcr5f7667d769bf391e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 18 03:40:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhwJi-0004F3-WC
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 03:40:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932737Ab0BRCke (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2010 21:40:34 -0500
Received: from mail-px0-f204.google.com ([209.85.216.204]:47756 "EHLO
	mail-px0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932723Ab0BRCkW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2010 21:40:22 -0500
X-Greylist: delayed 315 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Feb 2010 21:40:22 EST
Received: by pxi42 with SMTP id 42so1684619pxi.5
        for <git@vger.kernel.org>; Wed, 17 Feb 2010 18:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=MOSzozVmE4bP0ziq5TdmuwrMKRdPuSz6o3swoWBwiUE=;
        b=cjYxbvT8VTh3u5dkIVtnIHj381L8rsXjFRsdCKR76MJfCHxeQzmCWVXuhVzS9jYJgt
         YjjoHkiqg4mUhmbGng2fFrP+VW4c1I9KPHdDfRnqzFBHWA4LIKD2Sb1o1fuU7F6TtTai
         UiTBa5yGXiOvqiIHmOcvvlXzzpmKgmrgzscJg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=fTXlHmdUqZwhpwy3NWIfwu8XUr3TimN4eZ0wR/AAdVV/YOoYRmNstS3365WJocpr31
         g5fElNAcqkwxYBJMGbWhKg7IekOmCif4LW78W6i7MoBFGioC1Z3SXYgGQ/uJMzFOn7Ne
         phccV9VWh2SAXtt9pd5sw+qeeYJlXSlejNUzI=
Received: by 10.115.133.4 with SMTP id k4mr6045932wan.4.1266460507502; Wed, 17 
	Feb 2010 18:35:07 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140290>

Does the git toolset currently support rewriting a restricted git DAG
as a linear history in a completely automated way?

I understand that git rebase --root will attempt to rebase a DAG, but
as far as I can tell any conflicts that occur during the rebase
require a manual intervention to correct. My goal is a completely
automated rewrite.

I guess some might be sceptical that a sane automated rewrite is
impossible, but I am insane enough to think it might actually be
possible.

I have prototype that implements an algorithm that does this [ for a
restricted class of DAG of interest to me ], so I can't be completely
insane, but if other people have already knocked the corners of this
particular wheel, I'd be interested to learn of their efforts.

Regards.

jon
