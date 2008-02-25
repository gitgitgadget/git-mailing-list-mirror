From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: don't save the geometry to rc file on exit
Date: Mon, 25 Feb 2008 23:09:00 +1100
Message-ID: <18370.45020.940192.10482@cargo.ozlabs.ibm.com>
References: <47AAA254.2020008@thorn.ws>
	<20080207063020.GP24004@spearce.org>
	<200802071056.19370.robin.rosenberg.lists@dewire.com>
	<20080207101051.19459.qmail@fcb20609bc7c07.315fe32.mid.smarden.org>
	<20080223113759.12854.qmail@6a8737aa4695b2.315fe32.mid.smarden.org>
	<18368.41742.689290.877767@cargo.ozlabs.ibm.com>
	<20080225080739.GA13610@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Gerrit Pape <pape@smarden.org>, git@vger.kernel.org,
	Mark Levedahl <mlevedahl@gmail.com>
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Mon Feb 25 13:09:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTc9S-0001tZ-5C
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 13:09:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754088AbYBYMJI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 07:09:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754054AbYBYMJI
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 07:09:08 -0500
Received: from ozlabs.org ([203.10.76.45]:38633 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753941AbYBYMJH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 07:09:07 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id E4A7EDDE0A; Mon, 25 Feb 2008 23:09:05 +1100 (EST)
In-Reply-To: <20080225080739.GA13610@piper.oerlikon.madduck.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75023>

martin f krafft writes:

> May I suggest that such a patch actually disables writing of the
> config file, so that we won't get conflicts every time you sync
> config files via home-in-git?

Then various other bits of config won't be persistent, such as font
settings.  So I don't think that's a good idea.

It would be possible to make the config file be per-repository rather
than global, I guess, if that is something people want.  I personally
would find it annoying to have to change the font separately in each
repository, but tastes differ, I guess.

Paul.
