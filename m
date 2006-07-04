From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Teach rev-parse the ... syntax.
Date: Tue, 4 Jul 2006 12:50:50 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607041247200.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <873bdhbv4x.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1148973799-356820123-1152010250=:29667"
Cc: Git Mailing List <git@vger.kernel.org>,
	"Junio C. Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Jul 04 12:51:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxiUa-0007K4-87
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 12:50:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191AbWGDKux (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Jul 2006 06:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932203AbWGDKux
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Jul 2006 06:50:53 -0400
Received: from mail.gmx.de ([213.165.64.21]:22688 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932191AbWGDKuw (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Jul 2006 06:50:52 -0400
Received: (qmail invoked by alias); 04 Jul 2006 10:50:51 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp028) with SMTP; 04 Jul 2006 12:50:51 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
In-Reply-To: <873bdhbv4x.fsf@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23280>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1148973799-356820123-1152010250=:29667
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Tue, 4 Jul 2006, Santi Béjar wrote:

> +				  struct commit_list *exclude = get_merge_bases(a, b,1);

You never free_commit_list() exclude.

Side thought: we do not really support multiple ranges, do we? E.g.

	git-rev-list HEAD~10..HEAD~8 HEAD^..

would not yield the intended result, right? (And same goes for ... ranges) 
Maybe we should at least warn about that.

Ciao,
Dscho
---1148973799-356820123-1152010250=:29667--
