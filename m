From: Lynn Lin <lynn.xin.lin@gmail.com>
Subject: how to squash two commits into only one
Date: Tue, 29 Mar 2011 13:42:27 +0800
Message-ID: <AANLkTi=B37GABBc-YWfJN29Mh0kx4Tn8KenD5dJFo9j1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 29 07:42:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4RhJ-0004dY-MG
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 07:42:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752131Ab1C2Fm3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 01:42:29 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:49967 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752128Ab1C2Fm2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 01:42:28 -0400
Received: by qwk3 with SMTP id 3so2403373qwk.19
        for <git@vger.kernel.org>; Mon, 28 Mar 2011 22:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=/ShbcTGuDzSF9c7aYbwRG6V7Q72dyTIHccAtuS2Q3Xk=;
        b=H+9pt6H/exW1wsG0XjIeSlIcORJ5vT6S4RJQfz85e1a2Zs5Oglzp7RR7yJcV9iGHI7
         ZYpM7FZ/AyHXdJVyQO6U1Hq0XJooximq9Lb2Kzy8Vf299h1NDiEfSIHdDIiXeDe6Ber/
         l36wCKqqYT5zCfUU85iKBPFGtC3YmYW0Ya6R8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=cMFqAF9MIoMyHbI90DRdKD62kFr3xxPpeF5WAiqeE60VJVtOFzmyazSAw5+ut7FCVL
         aB57NihWaGyAz8OojeroV1HpsO5WSvVTsP/rael6URyLQdvCCUpPXtWLWATvTZfHmiJo
         c1MzgnuwPfkjsQuNrV1ToBJGd4vV0jW89cRTc=
Received: by 10.224.74.14 with SMTP id s14mr4236721qaj.191.1301377347511; Mon,
 28 Mar 2011 22:42:27 -0700 (PDT)
Received: by 10.229.185.2 with HTTP; Mon, 28 Mar 2011 22:42:27 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170223>

All,
   I have only have two commits in repo,then I want to squash these
two commit into one through git rebase -i .However it fails

$ git rebase -i HEAD^1
it only show up one commit so can't squash (can't squash without a
previous commit)


Any help on this?

Thanks
Lynn
