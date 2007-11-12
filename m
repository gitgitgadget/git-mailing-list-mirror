From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH] status&commit: Teach them to show commits of modified submodules.
Date: Mon, 12 Nov 2007 13:38:03 +0800
Message-ID: <46dff0320711112138j6d1e64a1qc9ea449e2bdab384@mail.gmail.com>
References: <1194722863-14741-1-git-send-email-pkufranky@gmail.com>
	 <7vabpliz13.fsf@gitster.siamese.dyndns.org>
	 <46dff0320711102218h259199e3g2b4a4d3b73202cdb@mail.gmail.com>
	 <7vhcjscyhu.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 06:38:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrS0I-0006vo-3T
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 06:38:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751472AbXKLFiH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 00:38:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbXKLFiG
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 00:38:06 -0500
Received: from py-out-1112.google.com ([64.233.166.177]:13739 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751472AbXKLFiE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 00:38:04 -0500
Received: by py-out-1112.google.com with SMTP id u77so1008153pyb
        for <git@vger.kernel.org>; Sun, 11 Nov 2007 21:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=H42DmEP8fFnocTZCxTSM24aXhV4usgqybiAMUqwSabw=;
        b=LGGDC/TG5ewryXG4Ji6PgDhfhrEmA9mSi4J1TYsJjFqfzfOrtlLz2fVZZhJNtlSM5ZqRQBIwgAR53tUrpAKlTZptRUXP6XeSoxAoBxI42JuQfZrV5GYNnfhwMx/QPYjb6tP4MZvfHW5a3fyuE4+Tu0xJuJj40YClCt21s0tLj/E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dHellW95ILW96g8jXfsYjebBqDVjWZ7dUOAgwMWkJNtAfzJnr1959Cc0zy52qQ76EF1TNF3KxH/wmMOryDaeCCm++tGMy9AzlE5g88szB23I7WOku4EwQh1iMp/NVJdAaLvPnMWGonBazc55+QrvOWSXTCG7TU9olr/rHwr6N+8=
Received: by 10.35.36.13 with SMTP id o13mr5666522pyj.1194845883343;
        Sun, 11 Nov 2007 21:38:03 -0800 (PST)
Received: by 10.35.108.1 with HTTP; Sun, 11 Nov 2007 21:38:03 -0800 (PST)
In-Reply-To: <7vhcjscyhu.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64561>

On Nov 12, 2007 4:34 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> If "superprojects is not so super", why are you using submodule
> to bind these, instead of using a single project that tracks
> developments of such closely tied parts?
>
For small modules crossing over mutiple projects, the submodule way
may be more suitable. And such submodule (such as common config files,
common templates) may be binded tightly with superproject

>



-- 
Ping Yin
