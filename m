From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: What's cooking in git.git (Sep 2013, #01; Tue, 3)
Date: Wed, 04 Sep 2013 13:50:56 +0200
Message-ID: <vpq7gew6c0v.fsf@anie.imag.fr>
References: <xmqqppspo6i7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 04 13:51:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHBc4-0006pb-Mj
	for gcvg-git-2@plane.gmane.org; Wed, 04 Sep 2013 13:51:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762564Ab3IDLvE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Sep 2013 07:51:04 -0400
Received: from mx2.imag.fr ([129.88.30.17]:34570 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757455Ab3IDLvC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Sep 2013 07:51:02 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r84BosVi005138
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 4 Sep 2013 13:50:54 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1VHBbs-0005ZL-CI; Wed, 04 Sep 2013 13:50:56 +0200
In-Reply-To: <xmqqppspo6i7.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 03 Sep 2013 16:00:32 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 04 Sep 2013 13:50:55 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r84BosVi005138
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1378900256.15478@YeNFrvhDa8Z5Od1q8ry+AQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233831>

Junio C Hamano <gitster@pobox.com> writes:

> * mm/status-without-comment-char (2013-08-29) 5 commits
>  - status: introduce status.displayCommentChar to disable display of #
>  - SQUASH: do not fprintf() random strings
>  - get rid of "git submodule summary --for-status"
>  - wt-status: use argv_array API
>  - builtin/stripspace.c: fix broken indentation
>
>  Allow "git status" to omit the prefix to make its output a comment
>  in a commit log editor, which is not necessary for human
>  consumption.

I'm waiting for the situation of "git submodule --for-status" to be
settled to send a reroll. Don't merge this for now, and let
bc/submodule-status-ignored converge.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
