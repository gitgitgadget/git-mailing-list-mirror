From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: using gitconfig to get shell access
Date: Sat, 6 Feb 2010 17:33:04 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrnhmr9uh.qqv.sitaramc@sitaramc.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 06 18:33:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdoXH-0001zI-Os
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 18:33:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133Ab0BFRd3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Feb 2010 12:33:29 -0500
Received: from lo.gmane.org ([80.91.229.12]:40452 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755591Ab0BFRd3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Feb 2010 12:33:29 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NdoX7-0001rR-Jo
	for git@vger.kernel.org; Sat, 06 Feb 2010 18:33:25 +0100
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 06 Feb 2010 18:33:25 +0100
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 06 Feb 2010 18:33:25 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139177>

Hello all,

If I have a bare repo that is accessed only remotely, but I
allow arbitrary 'git config' keys to be set on it by the
remote user (somehow), can any of them be used to make git
run arbitrary commands on the server?

For example, 'hooks.showrev', is a "shell command used to
format each revision in the email".

Of course that's only in contrib, but are there any like
that in the main git config settings?  I took a look through
man git-config and offhand I couldn't find any, but if
someone knows more definitively I'd appreciate hearing about
it.

Thanks,

Sitaram
