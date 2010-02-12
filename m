From: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
Subject: Re: [PATCH 2/4] git-mailsplit: add `mailsplit.keepcr`
	configuration variable.
Date: Fri, 12 Feb 2010 23:04:25 +0100
Message-ID: <20100212220425.GE32018@pille.home>
References: <1265923579-24900-1-git-send-email-stefan.hahn@s-hahn.de> <1265923579-24900-3-git-send-email-stefan.hahn@s-hahn.de> <7vhbpnqrxr.fsf@alter.siamese.dyndns.org> <20100212210336.GB32018@pille.home> <7vr5oqnmzr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 12 23:06:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ng3cq-0002Gt-9d
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 23:04:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755498Ab0BLWEa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2010 17:04:30 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:61379 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754176Ab0BLWE3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2010 17:04:29 -0500
Received: from pille.home (port-92-203-117-198.dynamic.qsc.de [92.203.117.198])
	by mrelayeu.kundenserver.de (node=mreu0) with ESMTP (Nemesis)
	id 0LpzzH-1O9srt2w35-00f2hJ; Fri, 12 Feb 2010 23:04:27 +0100
Received: from pille.home (localhost [127.0.0.1])
	by pille.home (8.14.3/8.14.3/Debian-5) with ESMTP id o1CM4Pdf014840;
	Fri, 12 Feb 2010 23:04:25 +0100
Received: (from hs@localhost)
	by pille.home (8.14.3/8.14.3/Submit) id o1CM4Pc0014839;
	Fri, 12 Feb 2010 23:04:25 +0100
X-Authentication-Warning: pille.home: hs set sender to stefan.hahn@s-hahn.de using -f
Content-Disposition: inline
In-Reply-To: <7vr5oqnmzr.fsf@alter.siamese.dyndns.org>
X-Mailer: Mutt 1.5.18 http://www.mutt.org/
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Provags-ID: V01U2FsdGVkX1/0SqBHJvsrRtfbe+NSr9KkDcss6FX6dpv3iYp
 KTovJ6oV7dTUeR2UZ1LxXpNSvbr4hHbjDzzIU90Zy5Kgjc0xcm
 0m8J+9FD36QL8PG3bENNg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139755>

Also sprach Junio C Hamano am Fri, 12 Feb 2010 at 13:49:12 -0800:
> Regardless of where the configuration goes between am and mailsplit, you
> need to think about the interaction between rebase and am.  You might set
> the configuration for am---should that automatically and always kick in
> when you run rebase?  Do we need some way to override it per invocation
> when running rebase?

I did not have had any problem with git-rebase in mixed line ending
environment. If used via git-rebase, git-mailsplit should called
with --keep-cr set, independent from configuration for this.

Stefan

-- 
Stefan-W. Hahn                          It is easy to make things.
/ mailto:stefan.hahn@s-hahn.de /        It is hard to make things simple.			

Please note that according to the German law on data retention,
information on every electronic information exchange with me is
retained for a period of six months.
Bundesgesetzblatt:
http://www.bgblportal.de/BGBL/bgbl1f/bgbl107s3198.pdf
