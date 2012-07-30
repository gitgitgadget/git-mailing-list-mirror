From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: inconsistent logs when displayed on screen / piped to a file
Date: Mon, 30 Jul 2012 15:50:17 +0200
Message-ID: <1343656217.3970.5.camel@centaur.cmartin.tk>
References: <CALBOmsYh5AgpRQe28yUcChqemQ7HFMHahesGj_MPwQXDF-EM=Q@mail.gmail.com>
	 <50168E93.2090202@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Mojca Miklavec <mojca.miklavec.lists@gmail.com>,
	git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Jul 30 15:50:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvqMC-0007Sb-Vv
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 15:50:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754306Ab2G3Nt4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jul 2012 09:49:56 -0400
Received: from hessy.cmartin.tk ([78.47.67.53]:36119 "EHLO hessy.dwim.me"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754243Ab2G3Ntz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2012 09:49:55 -0400
Received: from [192.168.1.5] (p57A1FFA4.dip.t-dialin.net [87.161.255.164])
	by hessy.dwim.me (Postfix) with ESMTPSA id 53FE780037;
	Mon, 30 Jul 2012 15:49:54 +0200 (CEST)
In-Reply-To: <50168E93.2090202@drmicha.warpmail.net>
X-Mailer: Evolution 3.4.3-1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202543>

On Mon, 2012-07-30 at 15:39 +0200, Michael J Gruber wrote:
> a) probes your terminal for the number of columns and uses all available
> space.
> 
> b) goes to a file and has no connected terminal, thus uses a default
> column number. You can change that number using
> 
> COLUMNS=YourNumber git log YourArgs > YourFile

You can also pass a width to --stat. See the git log manpage for details
about which widths you can override.

   cmn
