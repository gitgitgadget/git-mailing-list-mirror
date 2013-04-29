From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 0/5] [RESEND] Minor additions to git-completion.bash
Date: Mon, 29 Apr 2013 18:19:36 +0530
Message-ID: <1367239781-5232-1-git-send-email-artagnon@gmail.com>
Cc: Felipe Contreras <felipe.contreras@mail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 29 14:48:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWnVB-00025p-7U
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 14:48:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757328Ab3D2MsL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 08:48:11 -0400
Received: from mail-pb0-f50.google.com ([209.85.160.50]:43216 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757295Ab3D2MsL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 08:48:11 -0400
Received: by mail-pb0-f50.google.com with SMTP id um15so1933911pbc.23
        for <git@vger.kernel.org>; Mon, 29 Apr 2013 05:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=CUn1+FrysRBTKX2LsrjrSUzFnpwUxh2clv6psIbU3EY=;
        b=ZMGIZxzf392yam34wAFqShhtu143SS1qeFuWSJk5vIciACoQ+tqhg32FXedqQX42AZ
         hHazTQTI6JM/82hRzvT2cpYzpfSQFkV8raNZ5hjIfOeSC0MBaySlJttfiXG6Duiuo015
         TyQzXXMmLuCIZCQ6cd1r1hu7drCZHR5yCburpzR24cJ2BNJShgwvF6gLMGRCtA2eh/Y/
         csJ4BxlHVYu4Dud2wIbzd5CEDZAEXcOsA7STLhpqiP5G2d/HF2d+K+w4UW8hpLpb6vWB
         1GTkDoTd3l44h0c/ytiRvI4J1AwbtoX0uyrgURwrC9/eT8VpvDMX8ohxejN6iRExmKd+
         qrNA==
X-Received: by 10.66.134.48 with SMTP id ph16mr36842423pab.168.1367239690437;
        Mon, 29 Apr 2013 05:48:10 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id wi6sm23963106pbc.22.2013.04.29.05.48.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 29 Apr 2013 05:48:09 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.616.ga1e5536.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222785>

Junio C Hamano wrote:
> I do not have the original series, so a resend with Felipe's Acked-by
> after your original Sign-off would be nice.

Felipe Contreras wrote:
> I only gave them a quick look.

This is an unmodified resend of [1] rebased onto the latest `master`.
I have not added Felipe's Acked-by.  Please do the needful.

Thanks.

[1]: http://article.gmane.org/gmane.comp.version-control.git/221947

Ramkumar Ramachandra (5):
  git-completion.bash: lexical sorting for diff.statGraphWidth
  git-completion.bash: add diff.submodule to config list
  git-completion.bash: complete branch.*.rebase as boolean
  git-completion.bash: add branch.*.pushremote to config list
  git-completion.bash: add remote.pushdefault to config list

 contrib/completion/git-completion.bash | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

-- 
1.8.2.1.616.ga1e5536.dirty
