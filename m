From: =?utf-8?b?TWljaGHFgg==?= Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: Re: [PATCH] Fix 'No newline...' annotation in rewrite diffs.
Date: Fri, 3 Aug 2012 07:49:47 +0000 (UTC)
Message-ID: <loom.20120803T094115-721@post.gmane.org>
References: <85f291cec03411c61ddf8808e53621ae@imap.force9.net> <20120802213346.GA575@sigill.intra.peff.net> <7vipd1c66f.fsf@alter.siamese.dyndns.org> <20120802221404.GA1682@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 03 09:50:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SxCeG-0007Y0-E9
	for gcvg-git-2@plane.gmane.org; Fri, 03 Aug 2012 09:50:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752867Ab2HCHuL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Aug 2012 03:50:11 -0400
Received: from plane.gmane.org ([80.91.229.3]:57925 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752631Ab2HCHuJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2012 03:50:09 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1SxCe2-0007Qf-9W
	for git@vger.kernel.org; Fri, 03 Aug 2012 09:50:02 +0200
Received: from pc10.ivo.park.gdynia.pl ([153.19.128.10])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 03 Aug 2012 09:50:02 +0200
Received: from michal.kiedrowicz by pc10.ivo.park.gdynia.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 03 Aug 2012 09:50:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 153.19.128.10 (Mozilla/5.0 (X11; Linux x86_64; rv:10.0.1) Gecko/20100101 Firefox/10.0.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202817>

Jeff King <peff <at> peff.net> writes:

> -		for i in $(seq 1 $GIT_PERF_REPEAT_COUNT); do
> +		for i in $("$PERL_PATH" -le "print for 1..$GIT_PERF_REPEAT_COUNT"); do


Maybe you could introduce "test_seq" instead.
