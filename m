From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Reproducible crash in git merge
Date: Sun, 27 Mar 2011 10:23:13 -0700 (PDT)
Message-ID: <m3pqpcv5ph.fsf@localhost.localdomain>
References: <AANLkTimxHn_fwMKh9cbp9i5LkShUi=HK44nv2KJ7ENaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Gilman <davidgilman1@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 27 19:23:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3tga-0007dO-Eg
	for gcvg-git-2@lo.gmane.org; Sun, 27 Mar 2011 19:23:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754088Ab1C0RXQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Mar 2011 13:23:16 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:49614 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754043Ab1C0RXQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Mar 2011 13:23:16 -0400
Received: by wwk4 with SMTP id 4so1051734wwk.1
        for <git@vger.kernel.org>; Sun, 27 Mar 2011 10:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type;
        bh=uRokWyXMX53hAMnpNNkrJTfatNEAx3J8VkXFKxo+Mnw=;
        b=Q/sECpCJb1nCBaIzhTElWGs7/bnyABhoql5R7YthiVktB3C84fct4BSTY2XoAAFjUj
         7XdpXb0wowOCrcvE0+MDz5GgKz896abhGNavwOo0R5Ao3OD1P/jfOLG99a81ycWX27QA
         jp8MN/r0MekU3kChnGqSiM/wKmSlQK692WR6Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=UaDN2p+atXpZTwR6Hzn6x+S3OvpCJh4KdRhYaL82hDQjP7tYp17GUdrfCSM6tiRKVE
         X8QPVRPO28aWcTdtAibb4vgNleL0uiMDCxgXpUTnVpUjpirbCrYHiw+D2fQ2hWpGRBXN
         JmpM9H86X0fPluP8hxtxcASr6dm938cE83s6c=
Received: by 10.216.62.137 with SMTP id y9mr1812933wec.107.1301246594963;
        Sun, 27 Mar 2011 10:23:14 -0700 (PDT)
Received: from localhost.localdomain (abvn125.neoplus.adsl.tpnet.pl [83.8.211.125])
        by mx.google.com with ESMTPS id a50sm1171935wer.18.2011.03.27.10.23.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 27 Mar 2011 10:23:13 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p2RHMkgp021169;
	Sun, 27 Mar 2011 19:22:56 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p2RHMYQC021166;
	Sun, 27 Mar 2011 19:22:34 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <AANLkTimxHn_fwMKh9cbp9i5LkShUi=HK44nv2KJ7ENaQ@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170085>

David Gilman <davidgilman1@gmail.com> writes:

> I can get git merge to crash during a git pull.  I'm using git
> 1.7.3.2.  The repo (afaict) is fine and had worked previously.

"git fsck --all" doesn't show any _errors_, doesn't it?

> Unfortunately I can't share the repo itself because of its contents.

Does anyone remember the script that can be used to anonymize contents
of repository that cannot be made public for debugging purposes?

Unfortunately I didn't save this email (on git mailing list), nor do
I remember enough from email to find it on one of git mailing list
archives...  

It would be good if it made it into 'contrib/' area, isn't it?
-- 
Jakub Narebski
Poland
ShadeHawk on #git
