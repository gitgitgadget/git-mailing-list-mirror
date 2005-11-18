From: Ismail Donmez <ismail@uludag.org.tr>
Subject: Re: Rss produced by git is not valid xml?
Date: Fri, 18 Nov 2005 22:45:00 +0200
Organization: =?utf-8?q?T=C3=9CB=C4=B0TAK/UEKAE?=
Message-ID: <200511182245.01713.ismail@uludag.org.tr>
References: <200511181833.40048.ismail@uludag.org.tr> <200511182208.24248.ismail@uludag.org.tr> <Pine.LNX.4.64.0511181220350.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Nov 18 21:45:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by deer.gmane.org with esmtp (Exim 3.35 #1 (Debian))
	id 1EdD79-00073L-00
	for <gcvg-git@gmane.org>; Fri, 18 Nov 2005 21:45:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161196AbVKRUpk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 15:45:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161198AbVKRUpk
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 15:45:40 -0500
Received: from ns2.uludag.org.tr ([193.140.100.220]:23986 "EHLO uludag.org.tr")
	by vger.kernel.org with ESMTP id S1161196AbVKRUpj (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Nov 2005 15:45:39 -0500
Received: from dsl.dynamic8599158195.ttnet.net.tr (unknown [85.99.158.195])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by uludag.org.tr (Postfix) with ESMTP id 19689AB485
	for <git@vger.kernel.org>; Fri, 18 Nov 2005 22:45:33 +0200 (EET)
To: git@vger.kernel.org
User-Agent: KMail/1.9
In-Reply-To: <Pine.LNX.4.64.0511181220350.13959@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12259>

On Friday 18 November 2005 22:22, you wrote:
> On Fri, 18 Nov 2005, Ismail Donmez wrote:
> > > And git guys, please start to think again about your insane options,
> > > that cause more harm than anything good.
> >
> > Can git maintainer(s) comment on this please?
>
> It's easy to say "just do the right thing", and ignore reality.
>
> git commit logs have always been "8-bit data". It's actually gitweb that
> is buggy if it claims it is UTF-8 without checking or converting it to
> such.
>
> I agree that UTF-8 is a good idea, but that's a totally different
> argument.

Maybe you could officially require all commit messages to be UTF-8 then the 
problem would be just solved for future commits at least. Until then it 
should be workarounded in gitweb I guess.

Regards
ismail
