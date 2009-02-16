From: "Tilo Schwarz" <tilo@tilo-schwarz.de>
Subject: Re: [ANNOUNCE] tig-0.14
Date: Mon, 16 Feb 2009 22:55:59 +0100
Message-ID: <op.upgsjljja8ed4e@dellschleppa>
References: <20090205204436.GA6072@diku.dk> <op.uo9di902a8ed4e@dellschleppa>
 <2c6b72b30902121424o5d4ac0d7u67a7afb3b861aa19@mail.gmail.com>
 <op.uo9hiqqqa8ed4e@dellschleppa>
 <2c6b72b30902151547q5bf183f2q1e846f261825671c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jonas Fonseca" <jonas.fonseca@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 16 22:58:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZBTc-0004DS-2z
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 22:58:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751006AbZBPV4H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 16:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbZBPV4F
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 16:56:05 -0500
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:10668 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752974AbZBPV4E (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 16:56:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1234821360; l=965;
	s=domk; d=tilo-schwarz.de;
	h=In-Reply-To:Content-Transfer-Encoding:References:MIME-Version:
	Content-Type:Cc:From:Subject:To:Date:X-RZG-CLASS-ID:X-RZG-AUTH:
	DomainKey-Signature;
	bh=o5GhPFSiSgmmb1WYDkIkhJJrJBhIiXyvHBBI/hAbSFI=;
	b=E6irCTpJAN5vxXa2vM22xvPGRm8ZJ9TJolhGW4XbUMbwmau2hDM445hsX9K8UKy6w1m
	ip1KVFXgKdrK+s09SBVSY/1+dxn+V4c6uX9Ynrek4XfrVnPE/ZsFn9zKYoYOHsUQVrENB
	FDa2STsd327CWisjbAoJVlufDipkpzUsZrk=
DomainKey-Signature: a=rsa-sha256; s=domk; d=tilo-schwarz.de; c=nofws; q=dns;
	h=X-RZG-AUTH:X-RZG-CLASS-ID:Date:To:Subject:From:Cc:Content-Type:
	MIME-Version:References:Content-Transfer-Encoding:In-Reply-To;
	b=TzjfuL2C/Cd8TyYWCDSYqMkDxrQMaqRahNjbnAPh5+MKnfN13U9RFY10+b6ZFNt3tmW
	y/OckQXfcPfKSiZSND2hCYIGUcuJ/i35egdjceLbNAHhftV7c38aCUs/4/qQiAC/uvu94
	CNoN3zlljd38LcuXdFO6+SYw3VmtWmUYJkI=
X-RZG-AUTH: :IW0NeWC8cvPlgn0IPTehqi9r6o/0DSXjJ1Me0yWdPTUrUVR0TMXac2ZAlsZ01c9KCKQ=
X-RZG-CLASS-ID: mo00
Received: from dellschleppa (p549CCCE0.dip.t-dialin.net [84.156.204.224])
	by post.strato.de (fruni mo11) (RZmta 18.18)
	with ESMTP id 000428l1GLKks2 ; Mon, 16 Feb 2009 22:55:59 +0100 (MET)
In-Reply-To: <2c6b72b30902151547q5bf183f2q1e846f261825671c@mail.gmail.com>
User-Agent: Opera Mail/9.63 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110253>

On Mon, 16 Feb 2009 00:47:05 +0100, Jonas Fonseca  
<jonas.fonseca@gmail.com> wrote:

> I have thought about it. The question is if a separate view is
> necessary or if the main view would do. For example, I sometimes use
> gitk when I need to rename branches or prepare for rebasing a
> patchset. One idea I would like to explore is to provide a compressed
> version of the main view, where "intermediate" commits are hidden,
> this way you could easily get a view of the relationship between
> branches.

After seeing

./gitk --simplify-by-decoration --all

for the first time today I think now I know better what you mean.  
Nevertheless, compared to a separate branch-view, there are two points:
- How to I select a branch, if there is more than one branch on one commit  
(and thus on one line)
- Would it still be possible to create nice and fast one (or two) key  
commands for the most used every-day branch commands.

Best regards,

     Tilo
