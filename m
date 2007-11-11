From: Dan Zwell <dzwell@gmail.com>
Subject: Re: [PATCH 0/3] Adding colors to git-add--interactive
Date: Sun, 11 Nov 2007 02:39:18 -0600
Message-ID: <4736BFB6.7050505@zwell.net>
References: <20071016194709.3c1cb3a8@danzwell.com>	<20071017015152.GN13801@spearce.org>	<20071022164048.71a3dceb@danzwell.com>	<20071023042702.GB28312@coredump.intra.peff.net>	<20071023035221.66ea537f@danzwell.com>	<20071102224100.71665182@paradox.zwell.net>	<20071104045735.GA12359@segfault.peff.net>	<7v640ivagv.fsf@gitster.siamese.dyndns.org>	<20071104054305.GA13929@sigill.intra.peff.net>	<20071110180109.34febc3f@paradox.zwell.net>	<20071111075446.GA26985@sigill.intra.peff.net> <7vzlxlgpgt.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, "Shawn O. Pearce" <spearce@spearce.org>,
	Wincent Colaiuta <win@wincent.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan del Strother <maillist@steelskies.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 09:40:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ir8Me-0005iK-LS
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 09:40:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752896AbXKKIkF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 03:40:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751735AbXKKIkE
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 03:40:04 -0500
Received: from py-out-1112.google.com ([64.233.166.182]:19779 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752471AbXKKIkD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 03:40:03 -0500
Received: by py-out-1112.google.com with SMTP id u77so575334pyb
        for <git@vger.kernel.org>; Sun, 11 Nov 2007 00:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        bh=buqUSPjm8WbkKQUXN9t9Iyh4epE+hwXh9A66CaqwDaA=;
        b=FW74KKP01V+tX/6oQPOC1XtaOYthej+8MZbanKIFa6i2KY77aKos8MXg5s7VynuGA3xmuWSf8R2n6kmz0VIldjDF6dTKTxtGm5NaEQxsR7V0SJ3GTExAq4OIdMMoaVHHEk6kmi9uKP2+j+gvilx+h/hKr8KtUJCrvU/kKNA8Ygk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=IbuS1HhEplBLcWd1XBrjUPNo+azvj41W6EF1mLlBF+bJJOT+zbGC7L4qQpU8WgIQXEi7Mfpwm+LmYBd5RdwPQGVqD2EgBONur9zEq85W1jOKN4yrOfMt64EuOpjvVn/c2zFuJSKAzslmbrT6yhVEUp2UZFKyeGFQioAIyAmz8c8=
Received: by 10.35.103.6 with SMTP id f6mr4475586pym.1194770402126;
        Sun, 11 Nov 2007 00:40:02 -0800 (PST)
Received: from ?143.44.70.185? ( [143.44.70.185])
        by mx.google.com with ESMTPS id n29sm7494955pyh.2007.11.11.00.40.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 11 Nov 2007 00:40:01 -0800 (PST)
User-Agent: Thunderbird 2.0.0.6 (X11/20071031)
In-Reply-To: <7vzlxlgpgt.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64432>

Junio C Hamano wrote:
> This hunk makes the "show diff" subcommand honor user's external
> diff viewer if specified, which is a good change.  But it does
> not belong to the "colored add -i" series.
> 
> I mildly suspect that this change might have been my fault, but
> I think it should be treated in an independent patch anyway.
> 

Yep, that change was part of Junio's hunk coloring patch that he sent in 
reply to my last set of patches. When I revise this, I'll drop that change.

Dan
