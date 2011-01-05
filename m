From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH 08/31] rebase: align variable names
Date: Tue, 4 Jan 2011 21:25:46 -0500 (EST)
Message-ID: <alpine.DEB.1.10.1101042112190.6201@debian>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com> <1293528648-21873-9-git-send-email-martin.von.zweigbergk@gmail.com> <201101042012.25580.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Jan 05 03:27:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaJ5y-0006xy-2h
	for gcvg-git-2@lo.gmane.org; Wed, 05 Jan 2011 03:27:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141Ab1AECZw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jan 2011 21:25:52 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:50642 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750801Ab1AECZv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jan 2011 21:25:51 -0500
Received: by qwa26 with SMTP id 26so15207002qwa.19
        for <git@vger.kernel.org>; Tue, 04 Jan 2011 18:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:x-x-sender:to:cc
         :subject:in-reply-to:message-id:references:user-agent:mime-version
         :content-type;
        bh=eUkZkAxDj9c/b+ElsTcXn/6cNuStYo+By+Y1zViw93I=;
        b=tT+xYCZdtTJaSUvBPiKm4l2i5mFeyX8+bgXjNV+YkQH21w39ewGEjvlj//psuTxQeC
         2uKF+/FajTo2YBHwb6NzU4tJT1lLLmDzxsVjuaiGRX6Udao7ysVvUXqpxcxmMl2u+eA1
         TF17TSLxy/wjByS291Sjv2VClhVVtBheo/D2w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        b=cv9cvlP4lTsF7gQOETOWdd8PcGJshxETQq4iIm+Wv4Ti4vldBNhFKIRr6Qd3nvVnR7
         KU798e91WV8svs7jv+l7PkvXvxyg8BpEOT0+TwaEnSVAxVc7xsjE9tZzBnxv1fOtIuAK
         9FDn460NjhLQWJPgo4UPX32x1VLdd3hiLLTUI=
Received: by 10.224.60.207 with SMTP id q15mr18690604qah.218.1294194350238;
        Tue, 04 Jan 2011 18:25:50 -0800 (PST)
Received: from [192.168.1.101] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id h20sm13236596qck.36.2011.01.04.18.25.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 04 Jan 2011 18:25:48 -0800 (PST)
X-X-Sender: martin@debian
In-Reply-To: <201101042012.25580.trast@student.ethz.ch>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164541>

On Tue, 4 Jan 2011, Thomas Rast wrote:

> Martin von Zweigbergk wrote:
> > Use the same names for variables that git-rebase--interactive.sh will
> > soon inherit from git-rebase.sh.
> 
> AFAICS this is partly about spelling the variables in lowercase
> instead of all-caps.
> 
> Wouldn't it be nicer to simply downcase *all* variables, so that the
> end result has a consistent coding style?

Yes, it would :-). I was just being conservative by trying not to
touch code that I didn't have to touch. I'll rename the remaining
variables in the next iteration.

Thanks,
Martin
