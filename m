From: "Jens Lehmann" <Jens.Lehmann@web.de>
Subject: Re: Restart submodule update --recursive
Date: Sat, 30 Oct 2010 09:17:55 +0200 (CEST)
Message-ID: <212962199.646095.1288423075790.JavaMail.fmail@mwmweb046>
References: <loom.20101028T090353-376@post.gmane.org>
 <20101028181515.GB14212@burratino>
 <loom.20101029T085153-262@post.gmane.org>
 <20101029091202.GA26442@burratino>, <4CCAB20A.1000408@prevac.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Jonathan Nieder" <jrnieder@gmail.com>
To: "Lukasz Palczewski" <l.palczewski@prevac.pl>
X-From: git-owner@vger.kernel.org Sat Oct 30 09:18:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PC5hT-00008t-6j
	for gcvg-git-2@lo.gmane.org; Sat, 30 Oct 2010 09:18:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751886Ab0J3HR6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Oct 2010 03:17:58 -0400
Received: from fmmailgate04.web.de ([217.72.192.242]:43588 "EHLO
	fmmailgate04.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751686Ab0J3HR5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Oct 2010 03:17:57 -0400
Received: from mwmweb046  ( [172.20.18.55])
	by fmmailgate04.web.de (Postfix) with ESMTP id C28B56AD38FF;
	Sat, 30 Oct 2010 09:17:55 +0200 (CEST)
Received: from [99.39.1.209]  by  mwmweb046  with HTTP; Sat Oct
 30 09:17:55 CEST 2010
In-Reply-To: <4CCAB20A.1000408@prevac.pl>
X-UI-Message-Type: mail
X-UI-ATTACHMENT-ID-POSTFIX: 4cd23798-0e1c-41ed-a023-108f2440110e
X-Priority: 3
Importance: normal
Sensitivity: Normal
X-Provags-ID: V01U2FsdGVkX1+aIerGKlxuGRT7uESoL0ezpGrSmGn9F8cBI0YuXd25E0ZkSja1dLHR
 4xX17LxUTEOKIhZeB9FW2VbIj0A85mDizJc43vKaXtY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160390>

>Let me know if this change will be in next version of git.

Sorry I'm coming late into this thread,but I'm still traveling.

Lukasz, maybe you could wait until I finish the recursive checkout I am
currently working on? Because then there will be no need to run
"git submodule update" anymore, but "git checkout" will update
submodules recursively too. And it will only fail if the checkout would
overwrite your local modifications, not just because the submodule is
modified in some way, and in this case it won't start at all instead of stopping
somewhere in between (you can test that new behavior by checking
out the branch "enhance_git_for_submodules" of my github repo:
http://github.com/jlehmann/git-submod-enhancements ).

Would that solve your problem?
