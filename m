From: Marat Radchenko <marat@slonopotamus.org>
Subject: Re: What's the difference between =?utf-8?b?YGdpdA==?= show branch:file =?utf-8?b?fA==?= diff -u - =?utf-8?b?ZmlsZWA=?= vs =?utf-8?b?YGdpdA==?= diff branch =?utf-8?b?ZmlsZWA/?=
Date: Tue, 23 Aug 2011 18:21:48 +0000 (UTC)
Message-ID: <loom.20110823T201645-980@post.gmane.org>
References: <loom.20110823T091132-107@post.gmane.org> <4E537AF0.9070604@drmicha.warpmail.net> <1314096731.15017.2.camel@n900.home.ru> <4E53C89A.9000604@drmicha.warpmail.net> <7vk4a4rqvb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 23 20:22:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qvvbz-0002kO-RL
	for gcvg-git-2@lo.gmane.org; Tue, 23 Aug 2011 20:22:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753460Ab1HWSWD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Aug 2011 14:22:03 -0400
Received: from lo.gmane.org ([80.91.229.12]:60546 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751997Ab1HWSWB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Aug 2011 14:22:01 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Qvvbr-0002h2-DJ
	for git@vger.kernel.org; Tue, 23 Aug 2011 20:21:59 +0200
Received: from core-gate-01-v50-x3.possvyaz.ru ([core-gate-01-v50-x3.possvyaz.ru])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 23 Aug 2011 20:21:59 +0200
Received: from marat by core-gate-01-v50-x3.possvyaz.ru with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 23 Aug 2011 20:21:59 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 176.57.72.68 (Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/13.0.782.107 Safari/535.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179957>

Junio C Hamano <gitster <at> pobox.com> writes:
> Not necessarily, especially when pathspec is given like the original post,
> i.e. "git diff $tree_ish -- $path". We would need to open tree objects
> that lead to the leaf of the $path and a blob, but other objects won't be
> needed.
And git show branch:path already has that code.
