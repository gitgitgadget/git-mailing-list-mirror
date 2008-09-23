From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] diff funcname_pattern: Allow HTML header tags without
 attributes
Date: Tue, 23 Sep 2008 04:05:04 +0200
Message-ID: <200809230405.04471.johan@herland.net>
References: <b-t750rmbNQ3RJMPXbQJmYFebFR6SfB9QBkJdDzbG7GGT_3aZBkCfw@cipher.nrlssc.navy.mil>
 <200809230249.23298.johan@herland.net>
 <7v7i93ws64.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Brandon Casey <casey@nrlssc.navy.mil>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 23 04:06:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhxIc-0007Rv-D5
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 04:06:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753996AbYIWCFi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2008 22:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753993AbYIWCFi
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Sep 2008 22:05:38 -0400
Received: from smtp.getmail.no ([84.208.20.33]:59775 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753968AbYIWCFh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Sep 2008 22:05:37 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0K7M00803LT1AH00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Tue, 23 Sep 2008 04:05:25 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K7M00HHGLSGU150@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Tue, 23 Sep 2008 04:05:04 +0200 (CEST)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K7M009T9LSGYOE0@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Tue, 23 Sep 2008 04:05:04 +0200 (CEST)
In-reply-to: <7v7i93ws64.fsf@gitster.siamese.dyndns.org>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96520>

On Tuesday 23 September 2008, Junio C Hamano wrote:
> Johan Herland <johan@herland.net> writes:
> > After looking over this once more, I think the HTML regexp should be
> > changed as follows. This fixes a buglet that was part of my original
> > HTML pattern, and although this patch textually depends on Brandon's
> > work, it is conceptually independent of his refactorization.
> > ...
> > -	{ "html", "^[ \t]*(<[Hh][1-6][ \t].*>.*)$", REG_EXTENDED },
> > +	{ "html", "^[ \t]*(<[Hh][1-6]([ \t].*)?>.*)$", REG_EXTENDED },
>
> I do not think these two particularly would make much difference.  Why
> isn't it simply...
>
> 	"<[Hh][1-6].*"
>
> without even any capture or anchor?
>
> It would falsely hit oddball cases like <h1foo> which is not <h1>, but
> anybody who uses such a nonstandard thing deserves it, imnvho ;-).

Ok. I agree. Go ahead.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
