From: Abhijit Menon-Sen <ams@toroid.org>
Subject: Re: [PATCH] t/t91XX-svn: start removing use of "git-" from these
	tests
Date: Tue, 9 Sep 2008 07:53:43 +0530
Message-ID: <20080909022343.GB19190@toroid.org>
References: <20080908190205.6117@nanako3.lavabit.com> <20080908101631.GA6948@toroid.org> <20080908102759.GC13085@hand.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Sep 09 04:24:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcsuV-0006qF-Dy
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 04:24:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752154AbYIICXr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 22:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751966AbYIICXr
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 22:23:47 -0400
Received: from fugue.toroid.org ([85.10.196.113]:43042 "EHLO fugue.toroid.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751956AbYIICXp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 22:23:45 -0400
Received: from penne.toroid.org (penne-vpn [10.8.0.6])
	by fugue.toroid.org (Postfix) with ESMTP id 3577E5582AF;
	Tue,  9 Sep 2008 04:23:44 +0200 (CEST)
Received: by penne.toroid.org (Postfix, from userid 1000)
	id 44D72388403; Tue,  9 Sep 2008 07:53:43 +0530 (IST)
Content-Disposition: inline
In-Reply-To: <20080908102759.GC13085@hand.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95332>

At 2008-09-08 03:27:59 -0700, normalperson@yhbt.net wrote:
>
> They'll show up as false positives when grepping for "git-"

Fine, you're the maintainer, but for the record, I think this change is
dreadful. Changing all "git-svn blah" commands to "git svn blah" is one
thing, but obfuscating tests on the off-chance that someone might grep
for "git-" seems entirely wrong.

-- ams
