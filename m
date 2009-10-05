From: Johan Herland <johan@herland.net>
Subject: Re: [RFCv4 3/5] 2/2: Add Python support library for CVS remote helper
Date: Mon, 5 Oct 2009 17:35:40 +0200
Message-ID: <200910051735.41378.johan@herland.net>
References: <1250480161-21933-1-git-send-email-johan@herland.net> <200910051641.43136.johan@herland.net> <fabb9a1e0910050750q195bdafv5511915fe5d26c02@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	David Aguilar <davvid@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 05 17:42:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MuphT-00077K-RQ
	for gcvg-git-2@lo.gmane.org; Mon, 05 Oct 2009 17:42:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753615AbZJEPgb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2009 11:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752740AbZJEPga
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Oct 2009 11:36:30 -0400
Received: from sam.opera.com ([213.236.208.81]:52416 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752491AbZJEPga (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2009 11:36:30 -0400
Received: from pc107.coreteam.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id n95FZfUw031493
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 5 Oct 2009 15:35:46 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <fabb9a1e0910050750q195bdafv5511915fe5d26c02@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129569>

On Monday 05 October 2009, Sverre Rabbelier wrote:
> On Mon, Oct 5, 2009 at 16:41, Johan Herland <johan@herland.net> wrote:
> > - Are you planning to share directory structure only, or some of
> > the Python code as well? From the above structure it seems like you
> > want to make use of e.g. util.py and git.py. I'd be delighted if
> > the code is reusable by other remote helpers.
>
> Yes, the main reason I suggested this was because I want to reuse
> util.py and git.py :). Of course, it'd probably be cleaner to move
> the little CVS-specific code that is in git.py atm out of it.

Sure. Refactor away. :)

> > - Do you plan to put the remote helpers into this structure as
> > well, or keep them separate? (currently the cvs remote helper lives
> > separately in git-remote-cvs.py in the project root directory)
>
> I think it's good where it is right now, and I've also placed
> git-remote-hg.py in the root directory.

Ok.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
