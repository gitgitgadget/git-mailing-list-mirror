From: =?ISO-8859-1?Q?Tor_Arne_Vestb=F8?= <torarnv@gmail.com>
Subject: Re: [JGIT PATCH] Fix AbstractTreeIterator path comparion betwen 'a'
 and 'a/b'
Date: Tue, 03 Feb 2009 17:36:04 +0100
Message-ID: <49887274.8040601@gmail.com>
References: <1233605617-14513-1-git-send-email-torarnv@gmail.com> <20090203161539.GV26880@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Feb 03 17:37:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUOHG-0008M2-Rl
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 17:37:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752102AbZBCQgL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 11:36:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752068AbZBCQgJ
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 11:36:09 -0500
Received: from ey-out-2122.google.com ([74.125.78.24]:17963 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751986AbZBCQgI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 11:36:08 -0500
Received: by ey-out-2122.google.com with SMTP id 25so495937eya.37
        for <git@vger.kernel.org>; Tue, 03 Feb 2009 08:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=BtaK5nrX6/cWfjoJzl7t3nLmoB6YlEHRM/AJSgUvvaY=;
        b=HQRPvnlmizizBjuIeO57JNzauc60IpIAG9PjI/6IuNrHWpcqaZ4r/VAe5YGA+vqpz0
         hNnHJxyD28wHHLyB+XRepZ+usXFlD1+MTXg33MUPx9rJqbtAh4DYkMmQwlEcBvAZ26XQ
         3p4lWCy1468BF1qUbtTmDKYhhsguBMtZLhlgo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=mb5UconQuzRi8BJwaATFkja+Ng/GmJQif6ozwC/iIISGUQHKrUuq0Ogp99pLdciKb7
         tDUjolTKAQG2gEI8LvZ0qb6a1ptXPhJpye16PWY7eKYi3Gn2zpezSIKwRg5o3Hez74W4
         NFXhUFZZzOYlJVRkBV/ae54kBPI6fYpXHUE1I=
Received: by 10.102.228.10 with SMTP id a10mr1716344muh.26.1233678966115;
        Tue, 03 Feb 2009 08:36:06 -0800 (PST)
Received: from ?192.168.1.226? (212251244070.customer.cdi.no [212.251.244.70])
        by mx.google.com with ESMTPS id n10sm317410mue.39.2009.02.03.08.36.05
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 03 Feb 2009 08:36:05 -0800 (PST)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <20090203161539.GV26880@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108209>

Shawn O. Pearce wrote:
> Aside from this test not running, Eclipse says the tests pass.  But
> Maven tells another story: Tests run: 773, Failures: 3, Errors: 0

Strange :/

Nevertheless, there shouldn't be any failures, I see all three of them
when running in Eclipse, so I messed up, sorry for that. Will fix ASAP.

Tor Arne
