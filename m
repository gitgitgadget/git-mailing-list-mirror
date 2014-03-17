From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: push fail
Date: Mon, 17 Mar 2014 14:36:04 +0100
Message-ID: <vpq38ih7xrv.fsf@anie.imag.fr>
References: <CAH_OBie+KrSjtqLinbv8sJAOCu26j8xVzBQJHdHTB44V07GsXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: shawn wilson <ag4ve.us@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 17 14:36:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPXiC-0002Nx-L3
	for gcvg-git-2@plane.gmane.org; Mon, 17 Mar 2014 14:36:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933046AbaCQNgJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2014 09:36:09 -0400
Received: from mx2.imag.fr ([129.88.30.17]:49713 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932816AbaCQNgH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2014 09:36:07 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s2HDa3EK008391
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 17 Mar 2014 14:36:03 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s2HDa4Ut030571;
	Mon, 17 Mar 2014 14:36:04 +0100
In-Reply-To: <CAH_OBie+KrSjtqLinbv8sJAOCu26j8xVzBQJHdHTB44V07GsXg@mail.gmail.com>
	(shawn wilson's message of "Mon, 17 Mar 2014 09:06:56 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 17 Mar 2014 14:36:03 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s2HDa3EK008391
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1395668164.55316@2YrR10TRdhV2jUV0EAtgvg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244251>

shawn wilson <ag4ve.us@gmail.com> writes:

> How do I get more info here (and hopefully resolve this)?
>
>  % git push
> To ssh://server/foo/repo.git
>  ! [rejected]        test -> test (non-fast-forward)
> error: failed to push some refs to 'ssh://server/foo/repo.git'

You probably have a configuration that disables advices (look in
~/.gitconfig for an [advice] section. If you're a beginner, you probably
shouldn't deactivate these advices).

Git normally says something like this:

To /tmp/git
 ! [rejected]        branch3 -> branch3 (non-fast-forward)
error: failed to push some refs to '/tmp/git'
hint: Updates were rejected because the tip of your current branch is behind
hint: its remote counterpart. Merge the remote changes (e.g. 'git pull')
hint: before pushing again.
hint: See the 'Note about fast-forwards' in 'git push --help' for details.

The latest version says this which you may find clearer:

To /tmp/git
 ! [rejected]        branch3 -> branch3 (fetch first)
error: failed to push some refs to '/tmp/git'
hint: Updates were rejected because the remote contains work that you do
hint: not have locally. This is usually caused by another repository pushing
hint: to the same ref. You may want to first integrate the remote changes
hint: (e.g., 'git pull ...') before pushing again.
hint: See the 'Note about fast-forwards' in 'git push --help' for details.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
