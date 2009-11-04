From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 0/4] Cygwin MSVC patches
Date: Wed, 04 Nov 2009 19:03:23 +0000
Message-ID: <4AF1CFFB.30506@ramsay1.demon.co.uk>
References: <4AE7410D.3030109@ramsay1.demon.co.uk> <4AE7EB06.10305@viscovery.net> <4AE8C3FD.2020300@ramsay1.demon.co.uk> <4AEFD6F9.5000305@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>, mstormo@gmail.com
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Nov 04 21:22:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5mN5-0008Cl-3J
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 21:22:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbZKDUWM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 15:22:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932296AbZKDUWL
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 15:22:11 -0500
Received: from anchor-post-2.mail.demon.net ([195.173.77.133]:58968 "EHLO
	anchor-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932267AbZKDUWL (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Nov 2009 15:22:11 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1N5mMv-0001Au-ki; Wed, 04 Nov 2009 20:22:16 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <4AEFD6F9.5000305@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132141>

Johannes Sixt wrote:
> Just to check I understand correctly: you are running "make MSVC=1" on
> cygwin, and then you are using the resulting binaries with the POSIX tools
> from cygwin.

Yes.

    $ uname -a
    CYGWIN_NT-5.1 toshiba 1.5.22(0.156/4/2) 2006-11-13 17:01 i686 Cygwin
    $ pwd
    /home/ramsay/git
    $ make clean
    [...output snipped...]
    $ make MSVC=1
    [...975 lines of output snipped; built OK...]
    $ ./git --version
    git version 1.6.5.4.g57e8c.MSVC
    $

See original [PATCH 0/4] email for more...

ATB,
Ramsay Jones
