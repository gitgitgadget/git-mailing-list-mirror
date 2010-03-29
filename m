From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [RFC PATCH] Write new giturl(7) manpage
Date: Mon, 29 Mar 2010 18:55:23 +0300
Message-ID: <20100329155523.GA31829@LK-Perkele-V2.elisa-laajakaista.fi>
References: <f3271551003290759g154b149fl7877d9b83e1313e6@mail.gmail.com>
 <alpine.LNX.2.00.1003291140270.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Gabriel Filion <lelutin@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Mar 29 17:56:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwHJg-0004k7-2B
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 17:55:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754049Ab0C2Pzr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Mar 2010 11:55:47 -0400
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:41822 "EHLO
	emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752645Ab0C2Pzq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Mar 2010 11:55:46 -0400
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh03-2.mail.saunalahti.fi (Postfix) with SMTP id 30AFEEC198;
	Mon, 29 Mar 2010 18:55:45 +0300 (EEST)
Received: from emh04.mail.saunalahti.fi ([62.142.5.110])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A004A92DA77; Mon, 29 Mar 2010 18:55:45 +0300
Received: from LK-Perkele-V2 (a88-112-50-174.elisa-laajakaista.fi [88.112.50.174])
	by emh04.mail.saunalahti.fi (Postfix) with ESMTP id AEB7641BEF;
	Mon, 29 Mar 2010 18:55:35 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1003291140270.14365@iabervon.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143485>

On Mon, Mar 29, 2010 at 11:48:18AM -0400, Daniel Barkalow wrote:
> On Mon, 29 Mar 2010, Ramkumar Ramachandra wrote:
> 
> >  Why doesn't urls.txt document <transport>::<address> syntax? Should I
> >  fix this?
> 
> One useful way of answering questions like this is to find the commits 
> that added the <transport>::<address> syntax (probably easiest with git 
> blame), and at the commits that touched urls.txt (probably with git log), 
> and see if the reading the messages makes it obvious. I'd guess (without 
> actually looking myself) that it was just overlooked.

I think the following commit added that syntax:

commit 87422439d100f020cadb63b5da8495e5fbfb8fa3
Author: Johannes Schindelin <johannes.schindelin@gmx.de>
Date:   Wed Nov 18 02:42:26 2009 +0100

    Allow specifying the remote helper in the url
    
    The common case for remote helpers will be to import some repository
    which can be specified by a single URL.  Support this use case by
    allowing users to say:
    
        git clone hg::https://soc.googlecode.com/hg/ soc
    
    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
    Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

AFAICT, urls.txt hasn't been touched since this commit.

-Ilari
