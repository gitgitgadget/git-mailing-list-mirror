From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 0/5] Improve remote helper documentation
Date: Sun, 18 Apr 2010 06:20:50 +0530
Message-ID: <1271551834-sup-481@kytes>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Gabriel Filion <lelutin@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 18 02:53:10 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3Il3-00038R-N8
	for gcvg-git-2@lo.gmane.org; Sun, 18 Apr 2010 02:53:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755674Ab0DRAxE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Apr 2010 20:53:04 -0400
Received: from mail-yw0-f194.google.com ([209.85.211.194]:34456 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754393Ab0DRAxB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Apr 2010 20:53:01 -0400
Received: by ywh32 with SMTP id 32so2036587ywh.33
        for <git@vger.kernel.org>; Sat, 17 Apr 2010 17:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:content-type:cc:subject:from
         :to:date:message-id:user-agent:content-transfer-encoding;
        bh=JbBseWnmirG/QMDSojzXejKkkvv+OVQZ2JfnN/0ubAc=;
        b=T8nOd2fvmofdAXZS++lw1FzWpa0+hCSRfJ33L05bhK7dF8CEm8ISVK2pNwzaJ9RMHh
         n76Ub+vkYLuyvmonrzPBq3B8qvok5OiBo3l8UvK07DNl2KKcv1+I4n0Zo9UpwdJDQjOg
         8VZVySFyMjTxN5BAENWFAznBAMVZ66s939F6c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=content-type:cc:subject:from:to:date:message-id:user-agent
         :content-transfer-encoding;
        b=U1IBqCo4DlgPgUyp7dENa59SmUMBy5mmQuhG8iUGmFeE06HZfhETnAf1Gc+YM/DXTJ
         L5c/5ZrY9bBXMNryN9RDOBAQOFmpIjSTK66DMPWmZ9nKdGCcOyU/xmLHdIeH7iJe57vN
         2tRMNIjw0iPDZJm8RVnWk6zZlzng15vxkPdJo=
Received: by 10.150.118.3 with SMTP id q3mr4024390ybc.211.1271551981099;
        Sat, 17 Apr 2010 17:53:01 -0700 (PDT)
Received: from localhost ([203.110.240.41])
        by mx.google.com with ESMTPS id 21sm3328583iwn.11.2010.04.17.17.52.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 17 Apr 2010 17:52:59 -0700 (PDT)
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145194>

These patches have already been sent on the mailing list. They've been
discussed extensively, and have been through several revisions. The
first three patches are already in `pu`, but are stalled because they
haven't been ack'ed. The purpose of this resend is get everything neatly
organized so they can be ack'ed by remote helper experts and merged into
`master`.

Everything is based on the topic branch `rr/remote-helper-doc`.

Ramkumar Ramachandra (5):
  Documentation/remote-helpers: Rewrite description
  Documentation/urls: Rewrite to accomodate <transport>::<address>
  Documentation/remote-helpers: Add invocation section
  Fixup: Second argument may be any arbitrary string
  Documentation/remote-helpers: Fix typos and improve language

 Documentation/git-remote-helpers.txt |  117 ++++++++++++++++++++++++----------
 Documentation/urls.txt               |   58 ++++++++++-------
 2 files changed, 115 insertions(+), 60 deletions(-)
