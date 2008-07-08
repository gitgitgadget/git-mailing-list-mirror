From: "Josef 'Jeff' Sipek" <jeffpc@josefsipek.net>
Subject: Re: [PATCH 2/2] Make guilt work even after git-sh-setup is moved
	out of the user's path
Date: Mon, 7 Jul 2008 21:14:13 -0400
Message-ID: <20080708011413.GC1880@josefsipek.net>
References: <1215475392-26221-1-git-send-email-tytso@mit.edu> <1215475392-26221-2-git-send-email-tytso@mit.edu> <1215475392-26221-3-git-send-email-tytso@mit.edu> <20080708003256.GB1880@josefsipek.net> <7vwsjxxkfd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Theodore Ts'o" <tytso@MIT.EDU>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 08 03:16:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KG1oE-0004nN-VY
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 03:15:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755043AbYGHBO7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 21:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755044AbYGHBO7
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 21:14:59 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:37856 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755032AbYGHBO6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 21:14:58 -0400
Received: from josefsipek.net (baal.fsl.cs.sunysb.edu [130.245.126.78])
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.8) with ESMTP id m681EBbT020227;
	Mon, 7 Jul 2008 21:14:11 -0400
Received: by josefsipek.net (Postfix, from userid 1000)
	id 160AF1C00D88; Mon,  7 Jul 2008 21:14:13 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vwsjxxkfd.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87679>

On Mon, Jul 07, 2008 at 05:56:54PM -0700, Junio C Hamano wrote:
> "Josef 'Jeff' Sipek" <jeffpc@josefsipek.net> writes:
...
> > jeffpc@freyr:~$ git --version
> > git version 1.5.6.2.247.g923712
> > jeffpc@freyr:~$ git --exec-path
> > /home/jeffpc/git-bin/bin
> 
> Hmm, it is yours that look wrong.
 
Ok.

> With 1.6.0 preview (aka 'master'):
> 
> $ git --version
> git version 1.5.6.2.255.gbed62

A fresh clone (from master.kernel.org over ssh) gets me:

$ git describe
v1.5.6.2-247-g9237122
$ git --version
git version 1.5.6.GIT
$ git --exec-path
/home/jeffpc/git-bin/bin

You seem to have a different HEAD for the master branch than I do.

Josef 'Jeff' Sipek.

-- 
Don't drink and derive. Alcohol and algebra don't mix.
