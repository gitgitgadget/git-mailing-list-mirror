From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH] remote add: disallow --master and --mirror with non-bare
   repositories
Date: Tue, 22 Apr 2008 20:45:35 +0200
Message-ID: <480E324F.8050808@gnu.org>
References: <1208857733.4695.37.camel@marge.simson.net> <20080422103458.GA14751@sigio.intra.peff.net> <1208861703.18689.2.camel@marge.simson.net> <20080422111113.GB11238@sigill.intra.peff.net> <20080422124118.GA3098@mithlond.arda.local> <alpine.DEB.1.00.0804221354180.4460@eeepc-johanness> <7vd4ohzvda.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0804221823010.4460@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Teemu Likonen <tlikonen@iki.fi>, Jeff King <peff@peff.net>,
	Mike Galbraith <efault@gmx.de>, git <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Apr 22 20:46:57 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoNVd-00089U-3h
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 20:46:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755480AbYDVSpl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 14:45:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754366AbYDVSpk
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 14:45:40 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:43505 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753867AbYDVSpk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 14:45:40 -0400
Received: by nf-out-0910.google.com with SMTP id g13so854108nfb.21
        for <git@vger.kernel.org>; Tue, 22 Apr 2008 11:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        bh=vwXpjfHW0w47eSYiFHXeAKA4lE9lhr6S0tX/tDosdK8=;
        b=UkythEwzzkRf//GhU8dFGf//ictm1ijHk+BYW17tsdiHCQu/zelIGnyYC5+zg5Z+c+kRlsrrDd4RS66est+kFBJiLbThZHtdvU6aL9aw3SK0LX4d6ZvmrtwKpNSIlA/GgZa7czkHEQAHxmT+dd7wOUOkHtX9mF3uDsGYt3zB1zc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        b=oC13jOKQctWGdnj4T0zoo2QCDRGC3Ig8G2Pis9jL1jSDepNv33amJzv5LA1zp96Rw9q6aJnTn1Fqy/jClkbFt91tG8KF1SDmUhTEgdVp0Njspyuo02IoivoK0015Rq3RRf70gWAYcz2DYTslLPygasn1x+KtQafRhoYo8q5uMiE=
Received: by 10.86.94.11 with SMTP id r11mr1173609fgb.1.1208889936330;
        Tue, 22 Apr 2008 11:45:36 -0700 (PDT)
Received: from scientist-2.lan ( [213.140.22.65])
        by mx.google.com with ESMTPS id e20sm5404263fga.1.2008.04.22.11.45.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 22 Apr 2008 11:45:35 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.12 (Macintosh/20080213)
In-Reply-To: <alpine.DEB.1.00.0804221823010.4460@eeepc-johanness>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80156>

Johannes Schindelin wrote:
> In most cases, --master or --mirror in a non-bare repository is an
> error.  In those cases where it is not, the user is most likely editing
> the config herself anyway.

Ah, so I think we're speaking about two different features... sorry for 
the noise.

Paolo
