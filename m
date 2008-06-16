From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: Guided merge with override
Date: Tue, 17 Jun 2008 00:21:39 +0200
Message-ID: <bd6139dc0806161521p3667a44ble8573be1569986a0@mail.gmail.com>
References: <93c3eada0806152116v2cef4035u272dc1a26005661a@mail.gmail.com>
	 <20080616092554.GB29404@genesis.frugalware.org>
	 <48563D6C.8060704@viscovery.net>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Miklos Vajna" <vmiklos@frugalware.org>,
	"Geoff Russell" <geoffrey.russell@gmail.com>, git@vger.kernel.org
To: "Johannes Sixt" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Jun 17 00:22:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8N69-0000x5-0Q
	for gcvg-git-2@gmane.org; Tue, 17 Jun 2008 00:22:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756976AbYFPWVl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2008 18:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756960AbYFPWVl
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 18:21:41 -0400
Received: from rv-out-0506.google.com ([209.85.198.239]:39581 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753659AbYFPWVk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2008 18:21:40 -0400
Received: by rv-out-0506.google.com with SMTP id k40so3875874rvb.1
        for <git@vger.kernel.org>; Mon, 16 Jun 2008 15:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=u0CLascffG1vKMIIhHohn8Dnl+/LPu7R0It1rBxv7y0=;
        b=GFLLLrJ95lbfrRSKwc08sFr6CyCLc5i76vdg+zcqnQ32hGSKoCSj/Z8RnEgcRa0mOk
         oRvupLHd7LhGVNPK9+ib3jpx1CYRCh6AS0/lddneh6/nMmHA2IsvWNXu8YMiDEc9oMMZ
         TAc0iVrADpCUCflPlrS/JBYhDUqlOUGqCLjPg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=Ltx4aj+9PzzRo2wVEBUkZd36BjTiQl6At11n0dkL7b2kiXN3B1+6PkqIdaBzyOu2J/
         /NiWkbSdCqeNEs5U/Qeipij1Y1jlL1FRkmMQhNPWoi1X1xhraeS6ayApRuVk6kWedz0B
         6BuAeIZ0PcJ5dqV8khInZVJxBsCB4kNH6xh6g=
Received: by 10.142.231.7 with SMTP id d7mr2584480wfh.264.1213654899706;
        Mon, 16 Jun 2008 15:21:39 -0700 (PDT)
Received: by 10.143.38.17 with HTTP; Mon, 16 Jun 2008 15:21:39 -0700 (PDT)
In-Reply-To: <48563D6C.8060704@viscovery.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85242>

On Mon, Jun 16, 2008 at 12:16 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> The solution depends on whether *all* files in B should be taken, or only
> those files in B where there's a merge conflict. I don't know an easy way
> to do the former, but the latter I'd do like this:
>
>        $ git diff --name-only | xargs git checkout B --

Wouldn't something similar work but do a 'git ls-files' and filter it
on files that have a merge conflict?

-- 
Cheers,

Sverre Rabbelier
