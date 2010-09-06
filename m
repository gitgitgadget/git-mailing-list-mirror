From: Sylvain Rabot <sylvain@abstraction.fr>
Subject: Re: git diff - howto exclude dir from diff?
Date: Mon, 06 Sep 2010 15:25:37 +0200
Message-ID: <1283779537.23955.5.camel@isis.agematis.loc>
References: <AANLkTikUadS+tj3ARdRqo=PSBVhTsJaUxaJv+=4hMf4s@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 06 15:26:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Osbht-0000rM-7o
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 15:25:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754586Ab0IFNZw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Sep 2010 09:25:52 -0400
Received: from lo.gmane.org ([80.91.229.12]:54643 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752737Ab0IFNZv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Sep 2010 09:25:51 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Osbhi-0000hp-Do
	for git@vger.kernel.org; Mon, 06 Sep 2010 15:25:46 +0200
Received: from 82.138.94.34 ([82.138.94.34])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 15:25:46 +0200
Received: from sylvain by 82.138.94.34 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 15:25:46 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 82.138.94.34
In-Reply-To: <AANLkTikUadS+tj3ARdRqo=PSBVhTsJaUxaJv+=4hMf4s@mail.gmail.com>
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155570>

On Mon, 2010-09-06 at 13:13 +0200, Jan III Sobieski wrote:
> Hi,
> 
> I wonder if it's possible to exclude a dir from the diff. I want to
> get some diffstats from Linux tree
> 

It's not possible to exclude with git diff/grep, but you can do
somtehing like that :

find . -type f ! -path "./drivers/staging/*" | xargs git diff
v2.6.35..v2.6.36-rc3 --stat

> git diff v2.6.35..v2.6.36-rc3 --stat
> 
> but without drivers/staging/ dir. Is it possible?
> 
> Regards,
> Jan
> 
