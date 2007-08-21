From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: [PATCH] Document the -p option for git-show.
Date: Tue, 21 Aug 2007 15:09:48 +0200
Organization: eudaptics software gmbh
Message-ID: <46CAE41C.4614FDF4@eudaptics.com>
References: <46C97D26.9090102@brefemail.com> <20070821124949.GH768@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 21 15:09:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INTTl-0001Y6-Iv
	for gcvg-git@gmane.org; Tue, 21 Aug 2007 15:09:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753479AbXHUNJB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Aug 2007 09:09:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755318AbXHUNJB
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Aug 2007 09:09:01 -0400
Received: from main.gmane.org ([80.91.229.2]:55323 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751641AbXHUNJA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2007 09:09:00 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1INTTd-0005ZW-20
	for git@vger.kernel.org; Tue, 21 Aug 2007 15:08:57 +0200
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 21 Aug 2007 15:08:57 +0200
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 21 Aug 2007 15:08:57 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56294>

Miklos Vajna wrote:
> +-p::
> +       For commits, show the change the commit introduces in a patch form.

This is already documented by referencing git-diff-tree a few lines
above:

	The command takes options applicable to the git-diff-tree[1]
	command to control how the changes the commit introduces are
	shown.

The man page of git-diff-tree talks about -p, and a lot more options.

Side note: -p is the default for git-show (of commits). Nevertheless, it
makes sense to specify it in combination with other options:

	git show -p --stat

will show both the patch and the statistics.

-- Hannes
