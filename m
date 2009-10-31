From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [PATCH] Don't create the $GIT_DIR/branches directory on init
Date: Sat, 31 Oct 2009 19:02:47 +0100
Message-ID: <200910311902.48317.robin.rosenberg@dewire.com>
References: <1256923228-18949-1-git-send-email-robin.rosenberg@dewire.com> <200910311011.31189.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	spearce@spearce.org, sasa.zivkov@sap.com
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Oct 31 19:03:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N4IHz-0006pv-Uj
	for gcvg-git-2@lo.gmane.org; Sat, 31 Oct 2009 19:03:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932792AbZJaSCt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 Oct 2009 14:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932781AbZJaSCs
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Oct 2009 14:02:48 -0400
Received: from mail.dewire.com ([83.140.172.130]:26579 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932755AbZJaSCs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 31 Oct 2009 14:02:48 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 84458146A83F;
	Sat, 31 Oct 2009 19:02:49 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3hQwFW5gOt9x; Sat, 31 Oct 2009 19:02:49 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id E6588146A83D;
	Sat, 31 Oct 2009 19:02:48 +0100 (CET)
User-Agent: KMail/1.11.4 (Linux/2.6.28-11-generic; KDE/4.2.4; i686; ; )
In-Reply-To: <200910311011.31189.trast@student.ethz.ch>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131846>

l=F6rdag 31 oktober 2009 10:11:29 skrev  Thomas Rast:
> Robin Rosenberg wrote:
> > Git itself does not even look at this directory.
>
> This contradicts the git-fetch manpage though: from urls-remotes.txt,
> it includes
>
>   The name of one of the following can be used instead
>   of a URL as `<repository>` argument:
>
>   * a remote in the git configuration file: `$GIT_DIR/config`,
>   * a file in the `$GIT_DIR/remotes` directory, or
>   * a file in the `$GIT_DIR/branches` directory.
>
> (and a longer explanation of what they need to look like).
>
> So which one is wrong?

I, and a few other people, it seems. Seems the purpose of these
files is a bit different. Git does look in these directories (both)
when fetch is run. Seems remotes is not created by init though.

-- robin
