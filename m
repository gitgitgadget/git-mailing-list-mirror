From: Peter van der Does <peter@avirtualhome.com>
Subject: Re: [completion] Request: Include remote heads as push targets
Date: Sun, 24 Oct 2010 12:28:30 -0400
Message-ID: <20101024122830.791ce80e@montecarlo.grandprix.int>
References: <4CC05E4B.1010106@xiplink.com>
	<4CC06439.8040003@xiplink.com>
	<20101021191045.GC11759@burratino>
	<20101021210842.6545a661@montecarlo.grandprix.int>
	<20101023130434.GA29386@neumann>
	<20101023200739.28b6eb1e@montecarlo.grandprix.int>
	<20101024112325.GB29386@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	Kevin Ballard <kevin@sb.org>,
	Mathias Lafeldt <misfire@debugon.org>
To: SZEDER =?ISO-8859-1?B?R+Fib3I=?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sun Oct 24 18:29:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PA3RM-0000OB-7y
	for gcvg-git-2@lo.gmane.org; Sun, 24 Oct 2010 18:29:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757501Ab0JXQ2o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Oct 2010 12:28:44 -0400
Received: from morn.lunarbreeze.com ([216.227.218.220]:53416 "EHLO
	morn.lunarbreeze.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754272Ab0JXQ2n convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Oct 2010 12:28:43 -0400
Received: from c-69-248-103-68.hsd1.nj.comcast.net ([69.248.103.68] helo=monza.grandprix.int)
	by morn.lunarbreeze.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <peter@avirtualhome.com>)
	id 1PA3Qw-0002By-91; Sun, 24 Oct 2010 09:28:34 -0700
Received: from montecarlo.grandprix.int (montecarlo.grandprix.int [192.168.1.102])
	by monza.grandprix.int (Postfix) with ESMTPA id 4399C101F82;
	Sun, 24 Oct 2010 12:28:31 -0400 (EDT)
In-Reply-To: <20101024112325.GB29386@neumann>
X-Mailer: Claws Mail 3.7.6 (GTK+ 2.20.1; i486-pc-linux-gnu)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - morn.lunarbreeze.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - avirtualhome.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159884>

On Sun, 24 Oct 2010 13:23:26 +0200
SZEDER G=E1bor <szeder@ira.uka.de> wrote:


> Checking for the function first, and declaring it if it doesn't exist=
s
> could be a viewable alternative, but not with _get_cword().  The
> _get_cword() implementation you are adding below is outdated.  It is
> from bash-completion 1.1, changed quite a bit after that, and in the
> end became deprecated in 1.2 in favor of _get_comp_words_by_ref().
>=20
>=20

Ok, I just used the bash_completion version installed with Ubuntu Lucid=
=2E
I think we should use the 1.2 version.

--=20
Peter van der Does

GPG key: E77E8E98

IRC: Ganseki on irc.freenode.net
Twitter: @petervanderdoes

WordPress Plugin Developer
Blog: http://blog.avirtualhome.com
=46orums: http://forums.avirtualhome.com
Twitter: @avhsoftware
