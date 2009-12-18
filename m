From: Eugene Sajine <euguess@gmail.com>
Subject: git remote set-head not working?
Date: Fri, 18 Dec 2009 11:25:54 -0500
Message-ID: <76c5b8580912180825t17bfc90eq20dfc05cafa8c02e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 18 17:26:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLfeU-0004DQ-N0
	for gcvg-git-2@lo.gmane.org; Fri, 18 Dec 2009 17:26:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbZLRQZ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Dec 2009 11:25:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932159AbZLRQZ4
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Dec 2009 11:25:56 -0500
Received: from mail-iw0-f197.google.com ([209.85.223.197]:38587 "EHLO
	mail-iw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932156AbZLRQZz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Dec 2009 11:25:55 -0500
Received: by iwn35 with SMTP id 35so2194057iwn.4
        for <git@vger.kernel.org>; Fri, 18 Dec 2009 08:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=R8pf0fCwyrSxmNrWeCI4psOH6Wfa/LwMtWqkXI+J8oQ=;
        b=CMZ878CvwaugvgiJ2CMxT6+CPBmK8kMQR4MIk53qnWyCDka7XtpFmX1Eu+g/tBvsQT
         ImN/nr+h+0lijECyGJ38p6kByuKG6qEHG917RLIMSMWIA6BiJ/Y+57sYXmN5yTdx47vR
         9mIaloRMdnzowuO5s6l4a2r6Rpo0wAbqRbnWw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=J+DzyNnbmqmf9NPd9+6UT/jf0hlirEmOENYClkK3N6AeEpDd/ZrMZsCR6ItCmegEiz
         9M50MX/KnlrJ5hEhRrloXy9HGuicdlh9mbHBncphrKh1DYLzzWMrns7SJOmjGM9aH3Uw
         ekbH4yIJeTvv3ntcD/fAJfXOa+Cw7g+QaFLE0=
Received: by 10.231.61.195 with SMTP id u3mr335413ibh.12.1261153554206; Fri, 
	18 Dec 2009 08:25:54 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135417>

Hi,

i have a repo cloned from the server with two branches master and qa.

$git remote show origin

tells me that the HEAD branch is master.

When i try to execute

$ git remote set-head origin qa

It prints nothing and "git remote show origin" still prints that HEAD
branch is master.

Could you, please, advise if I am i missing something.

I'm working on Linux with git-1.6.4.4

Thanks,
Eugene
