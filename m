From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Show html help with git-help --html
Date: Sun, 03 Jun 2007 15:04:13 -0700
Message-ID: <7vr6osn19e.fsf@assigned-by-dhcp.cox.net>
References: <20070602015341.GA26520@localhost.myhome.westell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 04 00:04:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuyBS-0004j3-RY
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 00:04:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751030AbXFCWEQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 3 Jun 2007 18:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095AbXFCWEQ
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jun 2007 18:04:16 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:61279 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751030AbXFCWEQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Jun 2007 18:04:16 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070603220415.LSF7825.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Sun, 3 Jun 2007 18:04:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 7A4E1X00X1kojtg0000000; Sun, 03 Jun 2007 18:04:15 -0400
In-Reply-To: <20070602015341.GA26520@localhost.myhome.westell.com>
 (=?utf-8?B?Tmd1eeG7hW4JVGjDoWkgTmfhu41j?= Duy's message of "Fri, 1 Jun 2007
 21:53:41 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49040>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> This patch was inspired by ClearCase command 'ct man' which
> opens an html help file on Windows. I at first attempted to
> implement it for MinGW port only but found it so useful that I
> wanted to have it even in Linux.
>
> A new option '--help' is added to git. When git-help is called
> with --help, it will try to open html files located at
> $(sharedir)/html using xdg-open. HTML files are not installed
> by default so users have to install them manually or have their
> distributors to do that.

Do you mean a new option '--html'?
