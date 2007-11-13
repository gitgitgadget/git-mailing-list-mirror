From: Dan Zwell <dzwell@gmail.com>
Subject: Re: Subject: [PATCH 2/3] Let git-add--interactive read colors from
 .gitconfig
Date: Tue, 13 Nov 2007 02:25:07 -0600
Message-ID: <47395F63.8040306@zwell.net>
References: <47112491.8070309@gmail.com>	<20071015034338.GA4844@coredump.intra.peff.net>	<20071016194709.3c1cb3a8@danzwell.com>	<20071017015152.GN13801@spearce.org>	<20071022164048.71a3dceb@danzwell.com>	<20071023042702.GB28312@coredump.intra.peff.net>	<20071023035221.66ea537f@danzwell.com>	<20071102224100.71665182@paradox.zwell.net>	<20071104045735.GA12359@segfault.peff.net>	<7v640ivagv.fsf@gitster.siamese.dyndns.org>	<20071104054305.GA13929@sigill.intra.peff.net>	<20071110202351.7b4544aa@paradox.zwell.net>	<7vve89f6qy.fsf@gitster.siamese.dyndns.org>	<47390050.1020907@zwell.net>	<7v4pfq27tx.fsf@gitster.siamese.dyndns.org>	<47391211.5000606@zwell.net> <7v4pfqwqln.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Dan Zwell <dzwell@gmail.com>, Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Wincent Colaiuta <win@wincent.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan del Strother <maillist@steelskies.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 09:26:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Irr6E-0005mO-Hr
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 09:26:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbXKMI0G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 03:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbXKMI0F
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 03:26:05 -0500
Received: from py-out-1112.google.com ([64.233.166.183]:6854 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751183AbXKMI0E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 03:26:04 -0500
Received: by py-out-1112.google.com with SMTP id u77so1825746pyb
        for <git@vger.kernel.org>; Tue, 13 Nov 2007 00:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        bh=ysgi9y4fZB/2QGRonZxADJVtBzjgIiRkhMClUtvX5Og=;
        b=iWsQ+z1vxZ6gQmZQZ3DY08m7JrLuwxOoiJxyR7l1CkWdKkYdR4KJLTeRi9Ck2xaswvVdtA8mhGhE15zlrpMcC6QLpCukJshk1Yxj0hGSlvO1xg06pUvRfsZzFAetGzXyuAbxM1ld0qWOaE1Q5GVR2PnSELYwIjXzu5OG+FodQ9w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=pIctHRZE+VVxDgix4K9cnP/VUvRqKxCmeZCKP0G6wcqVuypkKFBho+rLruv2pMHAlt95rSjX/iOqrQnJo41Gq381Ailh6gx+Fm3On6hRT0pF2alz6sK71rDiEx8pQqGDdHA+8ZWS0zsUJ3wB6FBcLEquWr4HKJV3jJ0JsEI01+U=
Received: by 10.35.30.8 with SMTP id h8mr7157869pyj.1194942363314;
        Tue, 13 Nov 2007 00:26:03 -0800 (PST)
Received: from ?143.44.70.185? ( [143.44.70.185])
        by mx.google.com with ESMTPS id w38sm12105967pyg.2007.11.13.00.26.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 13 Nov 2007 00:26:02 -0800 (PST)
User-Agent: Thunderbird 2.0.0.6 (X11/20071031)
In-Reply-To: <7v4pfqwqln.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64768>

Junio C Hamano wrote:
> But the point is, that you are not ignoring invalid color names
> but instead giving back a random match aren't you?

No, if there's no match, the token is ignored. False matches are 
possible in some cases (the bogus config option "colored" would match 
"red", for example), so I will follow your suggestion with the hash, 
after all. I'll send out the next revised patches in a day or two--I've 
made most of the changes you and Jeff suggested, but I need to double check.

Dan
