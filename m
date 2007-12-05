From: =?ISO-8859-1?Q?V=E4in=F6_J=E4rvel=E4?= <v@pp.inet.fi>
Subject: Re: How to jump between two repositories ...
Date: Wed, 05 Dec 2007 09:32:20 +0200
Message-ID: <198078A1-E2FC-4EA3-B353-0956E121F76C@pp.inet.fi>
References: <C6AF7922-B2F7-42EB-B5DD-25353BC0AF2A@gmail.com>
 <3DD4D3BA-67B3-4AFC-AD24-799384D54408@pp.inet.fi>
 <33CB0252-20C7-4AF2-AEB3-2EAC20ED830B@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: g2 <gerald.gutierrez@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 05 08:33:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Izokx-0007kS-Hd
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 08:33:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751611AbXLEHc7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Dec 2007 02:32:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751615AbXLEHc6
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 02:32:58 -0500
Received: from astana.suomi.net ([82.128.152.18]:42148 "EHLO astana.suomi.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751565AbXLEHc6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Dec 2007 02:32:58 -0500
Received: from taku.suomi.net ([82.128.154.66])
 by astana.suomi.net (Sun Java System Messaging Server 6.2-3.04 (built Jul 15
 2005)) with ESMTP id <0JSK003TNFIQRJ20@astana.suomi.net> for
 git@vger.kernel.org; Wed, 05 Dec 2007 09:30:26 +0200 (EET)
Received: from spam5.suomi.net (spam5.suomi.net [212.50.131.165])
 by mailstore.suomi.net
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JSK0080BFMW5U30@mailstore.suomi.net> for git@vger.kernel.org;
 Wed, 05 Dec 2007 09:32:56 +0200 (EET)
Received: from Kaalimaa.fudeco.com (unknown [213.139.166.27])
	by spam5.suomi.net (Postfix) with ESMTP id CCC4F2FE6E; Wed,
 05 Dec 2007 07:32:20 +0000 (UTC)
In-reply-to: <33CB0252-20C7-4AF2-AEB3-2EAC20ED830B@gmail.com>
X-Mailer: Apple Mail (2.915)
X-OPOY-MailScanner-Watermark: 1197444741.35355@eurKeT5Yx3Q3ZJFZ72eFlA
X-OPOY-MailScanner-Information: Please contact OPOY for more information
X-OPOY-MailScanner: Found to be clean
X-OPOY-MailScanner-SpamCheck: not spam, SpamAssassin (not cached, score=0.1,
	required 5, RDNS_NONE 0.10)
X-OPOY-MailScanner-From: v@pp.inet.fi
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67118>

On Dec 5, 2007, at 08:44, g2 wrote:

> What I am gathering from this is that I can use git in two ways: 1) =20
> as "just another svn" bare git repository, or 2) only pull and don't =
=20
> push, because push causes confusion. I'd be happy to only ever use =20
> pull, but I have one machine behind a firewall and can't pull. I can =
=20
> push to a bare git repository like the svn model, but then I would =20
> just use svn. What's the value of "push" then?

I guess the value over svn, is in the excellent tools that Git =20
provides (such as rebase, bisect and merging). And that you can =20
develop offline and still retain the individual commits.

And you could use Steven Grimms solution, but I guess with that, you =20
need to be careful to not leave your servers working tree on any of =20
your laptop/ branch if you might push to one.

--
V=E4in=F6
