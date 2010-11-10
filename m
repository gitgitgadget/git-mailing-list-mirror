From: Yann Dirson <dirson@bertin.fr>
Subject: Re: [RFC] Using gitrevisions :/search style with other operators
Date: Wed, 10 Nov 2010 08:46:09 +0100
Organization: Bertin Technologies
Message-ID: <20101110084609.78f532a5@chalon.bertin.fr>
References: <20101109083023.783fad9b@chalon.bertin.fr>
 <13A8F1B3-39B0-4D11-8763-9C458F75487D@sb.org>
 <20101109102428.5ba8dc13@chalon.bertin.fr>
 <7vlj52jakh.fsf@alter.siamese.dyndns.org>
 <050F42EE-34FE-499F-B632-471597EB4881@sb.org>
 <20101110083209.6a1252ef@chalon.bertin.fr>
 <23523534-F7A7-4D61-A899-8B3B28566EA7@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git list <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Wed Nov 10 08:56:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PG5Y5-0004GT-8E
	for gcvg-git-2@lo.gmane.org; Wed, 10 Nov 2010 08:56:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753074Ab0KJH4s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Nov 2010 02:56:48 -0500
Received: from blois.bertin.fr ([195.68.26.9]:36519 "EHLO blois.bertin.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752572Ab0KJH4s (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Nov 2010 02:56:48 -0500
Received: from blois.bertin.fr (localhost [127.0.0.1])
	by postfix.imss70 (Postfix) with ESMTP id D82B954316
	for <git@vger.kernel.org>; Wed, 10 Nov 2010 08:56:46 +0100 (CET)
Received: from YPORT1 (yport1.bertin.fr [192.168.1.13])
	by blois.bertin.fr (Postfix) with ESMTP id B499454310
	for <git@vger.kernel.org>; Wed, 10 Nov 2010 08:56:46 +0100 (CET)
Received: from chalon.bertin.fr ([172.16.1.1]) by yport1.innovation.bertin.fr
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPPA id <0LBN003PCSQMZM70@yport1.innovation.bertin.fr> for
 git@vger.kernel.org; Wed, 10 Nov 2010 08:56:46 +0100 (CET)
In-reply-to: <23523534-F7A7-4D61-A899-8B3B28566EA7@sb.org>
X-Mailer: Claws Mail 3.7.6 (GTK+ 2.20.1; i486-pc-linux-gnu)
X-TM-AS-Product-Ver: IMSS-7.0.0.8200-6.0.0.1038-17756.005
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161137>

On Tue, 09 Nov 2010 23:46:59 -0800
Kevin Ballard <kevin@sb.org> wrote:

> On Nov 9, 2010, at 11:32 PM, Yann Dirson wrote:
> 
> >> Another thing to consider - the current :/foo syntax searches for
> >> the newest commit reachable from any ref. Using the ^{} syntax will
> >> require specifying a ref first. I'm not sure this is a problem
> >> though, as I'm not really sure why :/foo searches from all refs to
> >> begin with.
> > 
> > The syntax could be extended so that ^{whatever} starts looking at
> > current commit (ie. HEAD), somewhat like @{whatever} looks at
> > reflog for current branch.
> 
> :/foo doesn't start from the current commit - it searches all refs.
> However, making ^{} search all refs if not given one doesn't make
> sense for any operator except :/foo, so I don't think it's worth doing

Yes, that's why I suggested to make it search from HEAD, not from all
refs.

-- 
Yann Dirson - Bertin Technologies
