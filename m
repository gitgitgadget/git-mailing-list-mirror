From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: MinGW binary installer available
Date: Wed, 07 Feb 2007 22:10:13 +0100
Message-ID: <45CA4035.4090803@xs4all.nl>
References: <45C9E470.7030609@xs4all.nl> <Pine.LNX.4.63.0702071552470.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45C9EB54.3040406@xs4all.nl>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Jan Nieuwenhuizen <janneke@gnu.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 07 22:10:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEu3a-0007Gn-FT
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 22:10:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422757AbXBGVKP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 16:10:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422761AbXBGVKP
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 16:10:15 -0500
Received: from main.gmane.org ([80.91.229.2]:52692 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422757AbXBGVKN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 16:10:13 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HEu3N-0003iO-Ha
	for git@vger.kernel.org; Wed, 07 Feb 2007 22:10:09 +0100
Received: from muurbloem.xs4all.nl ([213.84.26.127])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 07 Feb 2007 22:10:09 +0100
Received: from hanwen by muurbloem.xs4all.nl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 07 Feb 2007 22:10:09 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: muurbloem.xs4all.nl
User-Agent: Thunderbird 1.5.0.9 (X11/20070130)
In-Reply-To: <45C9EB54.3040406@xs4all.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38969>

Han-Wen Nienhuys escreveu:
 
> Indeed: for now, this is intended for people clueful enough to install
> bash and perl on their own.  Adding bash itself should be easy, but

That was spoken with hybris.  Bash uses a regular gnu autoconf build
procedure, so making it build is much less of a pain to than massaging eg.
Python. However, it is a unix shell, and as such it does fork() all
the time. Hence, it is necessary to use Cygwin (or its derivative MSYS)
for running Bash.

A good reason to get rid of bash scripts.

-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
