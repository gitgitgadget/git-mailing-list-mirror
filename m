From: Francesco Pretto <ceztkoml@gmail.com>
Subject: Re: [PATCH] Implement selectable group ownership in git-init
Date: Mon, 05 Nov 2007 23:27:42 +0100
Message-ID: <472F98DE.2010406@gmail.com>
References: <472CC676.3000603@gmail.com> <7vabpvx8uu.fsf@gitster.siamese.dyndns.org> <8EF5148D-C1F0-4329-A221-82D0B7E9932C@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Mon Nov 05 23:28:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpAQL-0006Qf-Fb
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 23:28:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754087AbXKEW1r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 17:27:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752045AbXKEW1r
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 17:27:47 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:14927 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753110AbXKEW1q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 17:27:46 -0500
Received: by ug-out-1314.google.com with SMTP id z38so999791ugc
        for <git@vger.kernel.org>; Mon, 05 Nov 2007 14:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=7L+E5SMVUwClNz6lH7vU5HFm1dqDAlNaOGNt4FCY4uk=;
        b=sVI+kcJ7b2fcjtLFTGO+OatXWA+VLcr3k3pUZwJzFVt2c2hfyICkpolpj7EAGD4f/+/NJthf0ShqnHiMUy/GhWxiYu7/GRb3pmTDFJrGIcVdFpDWgC3m3qr0xjhdDTkZmefIRl9tjYWozTrn2Zj6kF8954yyFEpvYAmyhfdCUHw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=oOpfWkU1r4IuAA0k5H2icqynqEPHGfUNxxBVPddd2wmBUJQhc/RuOYHlEZX/OQSfXuDxryIvHqNcrHthfbcTb4BddJtbXuzn0C+dSlu80GuJK+LjOyvujgcYJf9DNNOWpamFppY82KrYoUf+3XoyAIi8FmEJCSaVSBHn9/xdj2c=
Received: by 10.67.27.15 with SMTP id e15mr250162ugj.1194301665377;
        Mon, 05 Nov 2007 14:27:45 -0800 (PST)
Received: from ?192.168.1.14? ( [87.0.185.143])
        by mx.google.com with ESMTPS id u7sm5742710uge.2007.11.05.14.27.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 05 Nov 2007 14:27:44 -0800 (PST)
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
In-Reply-To: <8EF5148D-C1F0-4329-A221-82D0B7E9932C@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63573>

Wincent Colaiuta ha scritto:
> I think this proposal adds unnecessary clutter to the codebase for
> something that can easily be achieved (and *should*) using chown, chgrp,
> or "sudo -u" etc.
> 

While still not convinced about that "unnecessary", i had to admit the risk
of breaking something with my addition was too high. What about a compromise?
I have improved the documentation about shared repositories. A patch coming
shortly.

Francesco
