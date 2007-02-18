From: Bruno Haible <bruno@clisp.org>
Subject: Re: piped to a pager (was: how to speed up "git log"?)
Date: Sun, 18 Feb 2007 01:09:26 +0100
Message-ID: <200702180109.26412.bruno@clisp.org>
References: <200702111252.28393.bruno@clisp.org> <200702172019.20536.bruno@clisp.org> <Pine.LNX.4.63.0702180019040.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 18 01:02:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIZVN-0003Q3-2c
	for gcvg-git@gmane.org; Sun, 18 Feb 2007 01:02:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965416AbXBRACB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Feb 2007 19:02:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965415AbXBRACB
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 19:02:01 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:40973 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965414AbXBRACA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Feb 2007 19:02:00 -0500
Received: from linuix.haible.de (cable-139-176.iesy.net [81.210.139.176])
	by post.webmailer.de (mrclete mo49) (RZmta 4.7) with ESMTP id J049b7j1HKDeRp 
	; Sun, 18 Feb 2007 01:01:58 +0100 (MET)
User-Agent: KMail/1.5.4
In-Reply-To: <Pine.LNX.4.63.0702180019040.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
X-RZG-AUTH: gMysVb8JT2gB+rFDu0PuvnPihAP8oFdePhw95HsN8T+WAEY4JDL5tImGAQ==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40031>

Johannes Schindelin wrote:
> you can blame the person calling git log and waiting until it 
> finishes. See the list archives for reasons why.
... and earlier:
> Usually the output of git-log -- even with pathname 
> filtering -- starts almost instantaneous, and is piped to your pager.

The pager ('less') in a console is not a good solution for everone:
  - People used to GUI editors (kate, nedit, ...) miss a scroll bar for
    navigation. You can't use kate or nedit as a pager.
  - PAGER="vi -" also reads all input before it displays anything.
  - PAGER="xless" likewise.
  - In Emacs shell-mode, with PAGER="", you see the output as it is produced,
    but it's disturbing to work in a buffer which is growing, where the scrollbar
    continues to change its position.

It's OK for many people, but not for everyone.

Bruno
