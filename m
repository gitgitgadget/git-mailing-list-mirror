From: Andrew Sayers <andrew-git@pileofstuff.org>
Subject: Re: What's the best way to make my company migrate to Git?
Date: Sat, 05 Jun 2010 22:27:28 +0100
Message-ID: <4C0AC140.6090808@pileofstuff.org>
References: <AANLkTikwpjtJnR856CHr_O3856JoMrFBgOQGODXNBbeI@mail.gmail.com>	<4BF7B751.7050704@pileofstuff.org>	<4BFB7F7F.5090407@drmicha.warpmail.net>	<4C041656.7000008@pileofstuff.org> <AANLkTinO_Z-1myhT-0TBIjELiEd4H-NnESs-AjTIpEf9@mail.gmail.com> <4C06050C.2040505@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Daniele Segato <daniele.bilug@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sat Jun 05 23:27:43 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OL0u6-0006Dq-Ds
	for gcvg-git-2@lo.gmane.org; Sat, 05 Jun 2010 23:27:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932955Ab0FEV1i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jun 2010 17:27:38 -0400
Received: from mtaout03-winn.ispmail.ntl.com ([81.103.221.49]:26795 "EHLO
	mtaout03-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932884Ab0FEV1h (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Jun 2010 17:27:37 -0400
Received: from aamtaout02-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout03-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20100605212731.HCBO3075.mtaout03-winn.ispmail.ntl.com@aamtaout02-winn.ispmail.ntl.com>;
          Sat, 5 Jun 2010 22:27:31 +0100
Received: from [192.168.1.5] (really [80.6.134.127])
          by aamtaout02-winn.ispmail.ntl.com
          (InterMail vG.2.02.00.01 201-2161-120-102-20060912) with ESMTP
          id <20100605212731.LZRS1586.aamtaout02-winn.ispmail.ntl.com@[192.168.1.5]>;
          Sat, 5 Jun 2010 22:27:31 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100423 Thunderbird/3.0.4
In-Reply-To: <4C06050C.2040505@drmicha.warpmail.net>
X-Cloudmark-Analysis: v=1.1 cv=ZtHxNT4mZm3rCuM0SmWmgWxeBwJsziC8EqOrwwVkrhA= c=1 sm=0 a=BxPs6DqL8UcA:10 a=UBIxAjGgU1YA:10 a=IkcTkHD0fZMA:10 a=Ou2gZ_vjsnL7LMxDcwoA:9 a=YFCn1RaoeE7mzwKe_1MA:7 a=1OVMJ_M5Xh-S1KRy9vcnS8PkS-YA:4 a=QEXdDO2ut3YA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148499>

On 02/06/10 08:15, Michael J Gruber wrote:
> 
> Andrew's main thrust is how to migrate a team, not how to migrate a code
> base, and even less about the technical differences between svn and git.
> And that makes it especially valuable.

I'm glad you like it, and I've now finished version 2.  I think I've
covered most of the points raised in this thread without getting too far
into technical issues that I agree belong on a different page.

As well as a few typographic upgrades, I've added some text to the "Git
as an SVN client" section - warnings for the issues that Daniele
mentioned, and explaining git issues to SVN users.  I remember now the
mental anguish I went through trying to explain what a local index is,
so I thought I'd save other people the bother :)

As promised, I've also added a "traps for the unwary" section, although
I'm quite tempted to make it a page on its own.  The intended audience
and writing style is necessarily quite different, and it awkwardly bulks
up the table of contents.  I'll probably leave it there unless it gets
any bigger or people think splitting it out is a particularly good idea.

One issue I haven't addressed is unpushed commits.  I want to write
something like "consider setting GIT_PS1_SHOWUNPUSHED to remind people
when they have committed but not yet pushed", so I'm going to see if I
can add support to git-completion.bash for such an option.

	- Andrew
