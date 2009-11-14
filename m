From: Victor Engmark <victor.engmark@gmail.com>
Subject: git svn fetch loses data
Date: Sat, 14 Nov 2009 18:07:32 +0100
Message-ID: <7d4f41f50911140907n285d72dcp7bbe802900f8bae5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 14 18:07:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9M69-0004Z8-2x
	for gcvg-git-2@lo.gmane.org; Sat, 14 Nov 2009 18:07:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755255AbZKNRH2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Nov 2009 12:07:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755211AbZKNRH2
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Nov 2009 12:07:28 -0500
Received: from mail-fx0-f221.google.com ([209.85.220.221]:54441 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755086AbZKNRH2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Nov 2009 12:07:28 -0500
Received: by fxm21 with SMTP id 21so1471353fxm.21
        for <git@vger.kernel.org>; Sat, 14 Nov 2009 09:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=GqBWwDHk3/KqFIxswUPtjNdIyAQaOrbPob12qEVvu7Y=;
        b=AsCrglkXJ4oYoQ0TCwwSRpXc4EE1iAs21DDL91eGCjFUd7sWW2VaD+uUGXZXutddQd
         PKaUxdTchoRHgWJb23Bd21gTpxSisNzmIEto0UW1I96gfpQBj6uOfu38UtfzBPGknaR0
         D+Hs5LkRGkNViJo2iwclZqcQCt5yYRWqfEFac=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=AAKvolXjfwjYYLKP4uVuKZSC2VReqQlWpotVh0GZD2lP/SRiQWJBC1CBF3+z3mpC+K
         CYbuJLXN7I/dn8sqcYULKTleTGMut9vRrOlrjK/okSl9oswQzE7bnehC1ovUvtHiiY95
         zKSNP7AX0wQxJhi89luXiAIqJ8hV1w/fkB+r4=
Received: by 10.216.91.73 with SMTP id g51mr381647wef.68.1258218452443; Sat, 
	14 Nov 2009 09:07:32 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132875>

Hi all,

I've been trying to move from Subversion to Git for a couple days now,
and I can't get git svn to get all my data. The progress so far is
explained at <http://l0b0.wordpress.com/2009/11/14/n-way-git-synchronization-with-extra-cheese/>.
git svn fetch doesn't report any errors, and goes through the entire
repository as regular as anything, but at the end about half of the
root directories are missing. Even the file modified by the last
commit is not there at all. Any ideas why this is?

-- 
Victor Engmark
