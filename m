From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: git-svn dcommit always uses my own name
Date: Tue, 15 Apr 2008 17:25:17 -0400
Message-ID: <32541b130804151425o6cf7646co541fb7cc85115606@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "git list" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 15 23:26:17 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlsfK-0002uO-3x
	for gcvg-git-2@gmane.org; Tue, 15 Apr 2008 23:26:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932358AbYDOVZX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2008 17:25:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763214AbYDOVZW
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Apr 2008 17:25:22 -0400
Received: from fk-out-0910.google.com ([209.85.128.184]:63922 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756059AbYDOVZU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2008 17:25:20 -0400
Received: by fk-out-0910.google.com with SMTP id 19so2409561fkr.5
        for <git@vger.kernel.org>; Tue, 15 Apr 2008 14:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=+JKCY8N8r7TEQQLUYy7nsdYjFVbN1H6jBGeYEF1cwVc=;
        b=YAe78r4cdlj7UTDBpasofARbUdYHwRde1qdXvdtbHYlknHNzzKODHziS7BIlgudTbsABMpJyt4nMdkWhV0ADzV9QXGs0eywKIRloJZnKLgFx4ClWiNjB7UH2y4usjQR+YkFk1hIe2vzLaa/F/gShe+9bYrvRwAfVHlURvQitvXE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=UgJhEA39sH0nYD3XFyscxiApYSIbvB7QQaOlLLLyu06oP+nvHNgAwERtTpOrF9dcfy3Sod7DbvlksSffgiEyTpnkvKWKQ9X+avJvw9KcjWdvvJf/4ys21IseCV9Fch3cGf6EHu9QZTJCT8yIrso0etxVkbXLt8mkYXJVwhpA/uk=
Received: by 10.82.123.8 with SMTP id v8mr12366460buc.30.1208294717986;
        Tue, 15 Apr 2008 14:25:17 -0700 (PDT)
Received: by 10.82.166.12 with HTTP; Tue, 15 Apr 2008 14:25:17 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79633>

Hi all,

Here's the workflow I'm using:

- I check out the central svn repository into a shared git repo using git-svn

- Each team member clones the shared repo, works in it, etc.

- I integrate their changes using git-pull, merge, rebase, etc,
forming a linearized history suitable for git-svn

- I run git-svn dcommit.

However, when I do this, all the commits to svn end up having *my*
userid attached, rather than the userid of the git user.  If I do "git
log" before "git-svn dcommit", it shows all the right authors, but
this information is lost when I dcommit.

Is there a way to not lose this information?

Thanks,

Avery
