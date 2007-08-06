From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Add support for an info version of the user manual
Date: Mon, 06 Aug 2007 19:44:39 +0200
Organization: At home
Message-ID: <f985v4$b14$1@sea.gmane.org>
References: <86ir7tc5xk.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 07 00:06:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIAid-00038N-Rg
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 00:06:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764746AbXHFWF5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Aug 2007 18:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765538AbXHFWFy
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 18:05:54 -0400
Received: from main.gmane.org ([80.91.229.2]:49005 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764746AbXHFWFq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 18:05:46 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IIAhm-0006xC-W4
	for git@vger.kernel.org; Tue, 07 Aug 2007 00:05:39 +0200
Received: from host-89-229-8-65.torun.mm.pl ([89.229.8.65])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 07 Aug 2007 00:05:38 +0200
Received: from jnareb by host-89-229-8-65.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 07 Aug 2007 00:05:38 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-8-65.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55176>

[Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org]

David Kastrup wrote:

> These patches use docbook2x in order to create an info version of the
> git user manual.
[...]
> ---
>  Documentation/Makefile |   28 ++++++++++++++++++++++++++++
>  Makefile               |    6 ++++++
>  2 files changed, 34 insertions(+), 0 deletions(-)
[...]

First, a note on patch: please use $(AWK) instead of 'awk', just in case.

It would be nice to add a paragraph about build requirements for info
version of Git User's Manual in the INSTALL file.

In the future we would probably want configure.ac to support --with-info or
something like that to install documentation in info format (it does
support --infodir), perhaps with awk autodetection and docbook2x
autodetection.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
