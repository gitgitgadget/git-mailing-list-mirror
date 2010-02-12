From: gmane2010@cfaerber.name (=?ISO-8859-1?Q?Claus_F=E4rber?=)
Subject: Re: Git under Windows should warn or fail on entities differning only in case
Date: 12 Feb 2010 19:19:00 +0100
Message-ID: <BIjfD8Ogt6D@mid.cfaerber.name>
References: <1265978433.7519.6.camel@chumley>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 12 21:20:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ng1zs-0000SH-TF
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 21:20:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756869Ab0BLUUJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2010 15:20:09 -0500
Received: from lo.gmane.org ([80.91.229.12]:48915 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751382Ab0BLUUI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2010 15:20:08 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Ng1zh-0000Hn-5K
	for git@vger.kernel.org; Fri, 12 Feb 2010 21:20:05 +0100
Received: from dslb-094-216-060-193.pools.arcor-ip.net ([94.216.60.193])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 12 Feb 2010 21:20:05 +0100
Received: from gmane2010 by dslb-094-216-060-193.pools.arcor-ip.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 12 Feb 2010 21:20:05 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: dslb-094-216-060-193.pools.arcor-ip.net
User-Agent: NewXP/2010-02-10.B88BD855 (Windows XP; x86)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139742>

David Hagood <david.hagood@gmail.com> schrieb/wrote:
> If you have 2 entities in a directory which have names differing only
> in case, e.g. "foo" and "FOO", under a REAL operating system with case
> sensitive file system semantics, this is no problem. However, under
> Windows and their wonderful "Case preserving but case insensitive"
> semantics, "FOO" and "foo" would be the same file,...

Mac OS X has the same problem.

Further, it does not preserve the Unicode normalisation form.

Claus
