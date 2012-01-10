From: Albert Astals Cid <aacid@kde.org>
Subject: [BUG] git archive broken in 1.7.8.1
Date: Tue, 10 Jan 2012 22:18:41 +0100
Message-ID: <5142795.2dTmMhVRTP@xps>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 10 22:18:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rkj5n-0006oN-Kb
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 22:18:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756842Ab2AJVSr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jan 2012 16:18:47 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:63485 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752676Ab2AJVSq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2012 16:18:46 -0500
Received: by eekc41 with SMTP id c41so8096eek.19
        for <git@vger.kernel.org>; Tue, 10 Jan 2012 13:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version
         :content-transfer-encoding:content-type;
        bh=aNRg1dr1S6UMFD8xlRyDmK/xsVDhRvIUqdzB/qfDr9Y=;
        b=P4vVKY9mtPCwvTVQu8idyI+GH7yuH/mJ2a7UW3UhiJWX8NYtnwmdSyChyd7mK6ymeQ
         NzGRpVyyR3mztS9la5eiPm7gvl8z82YkMEeDbJDPLZGrdzlu3bR/Hg7avBmEGJsv5HZl
         LF78LJ7qBMHMbw/BoBIPkL2Mlc3iL6an26ijw=
Received: by 10.14.2.79 with SMTP id 55mr5995009eee.20.1326230323560;
        Tue, 10 Jan 2012 13:18:43 -0800 (PST)
Received: from xps.localnet (business-89-133-214-66.business.broadband.hu. [89.133.214.66])
        by mx.google.com with ESMTPS id t59sm309039052eeh.10.2012.01.10.13.18.41
        (version=SSLv3 cipher=OTHER);
        Tue, 10 Jan 2012 13:18:42 -0800 (PST)
User-Agent: KMail/4.7.3 (Linux/3.0.0-15-generic; KDE/4.7.3; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188292>

CC me on answers since i'm not subscribed to the list

Hi, one of our [KDE] anongit servers was updated to 1.7.8.1 and not the syntax

git archive --remote=git://anongit.kde.org/repo.git HEAD:path

does not seem to return a valid tar archive anymore when it did work 
previously. In fact the man page of my version has that syntax in one of the 
examples.

Is that a regression or should have never it worked and the current behaviour 
is the correct one?

Albert
