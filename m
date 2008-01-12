From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH] Teach remote machinery about remotes.default config variable
Date: Sat, 12 Jan 2008 12:29:43 -0500
Message-ID: <4788F907.1050306@gmail.com>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com> <1200022189-2400-2-git-send-email-mlevedahl@gmail.com> <7v1w8o4ws0.fsf@gitster.siamese.dyndns.org> <30e4a070801111252s4e17b9c4m62adeb9032963e66@mail.gmail.com> <7v63xzzszp.fsf@gitster.siamese.dyndns.org> <478855B5.9070600@gmail.com> <alpine.LSU.1.00.0801121748290.8333@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jan 12 18:30:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDkBW-0008Jl-Vf
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 18:30:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754731AbYALR3t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2008 12:29:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754722AbYALR3t
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 12:29:49 -0500
Received: from rv-out-0910.google.com ([209.85.198.188]:1949 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754714AbYALR3s (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2008 12:29:48 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1274606rvb.1
        for <git@vger.kernel.org>; Sat, 12 Jan 2008 09:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=YlntK9oYFW3d2l4moxeiohuSrq9W8HuLgb6FL01T0dY=;
        b=fU2sknG0tWxdV/a7iT49eNMAlI5TWGCSKEfHGarZQwjGce9mlWK555F5Xnp+XxK66QzDIWCIncjyW75Q/WqKaIcYj7PbBpun7amJQ0jhktoUhql9XJMoPYR94nH/9rwiTNUrgyAQ9I5Pttgzr5QanOMus8RkpFDnBF6deWBB1S0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=H4GGMKW3GWA6JL98iXwUAXGD59oqGxytOb0Fs+SO1bIiAueRveEBO3JUailfQXB2cZNTYGGmICV0p2TTW8j5gb9GQq1zXd//tNj+Ij1byt/jTcJio7m8anEmWYhVUtXLSxdGLL+wxDZGxN9zTmLM6SYmbHUFkMKKn8b7kWSF+tw=
Received: by 10.141.42.10 with SMTP id u10mr2773752rvj.256.1200158986415;
        Sat, 12 Jan 2008 09:29:46 -0800 (PST)
Received: from ?192.168.1.117? ( [71.163.17.196])
        by mx.google.com with ESMTPS id 14sm7550814wrl.27.2008.01.12.09.29.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 12 Jan 2008 09:29:45 -0800 (PST)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <alpine.LSU.1.00.0801121748290.8333@wbgn129.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70334>

Johannes Schindelin wrote:
>
> No, that was not _at all_ my argument.
>
> I said that hiding it under a different name _that you have to look up, 
> too_ does _not_ make things easier.
>
>   
Granted, *IF* we had to look it up, but we don't. In fact, we use the 
convention
    servername.foo.bar
has nickname
    servername

So, we need to know the server name we are using, and that server name 
is the nickname. So, no confusion and no extra lookup step. (Our server 
names are unique without the domain suffixes, so this works well for us).

Mark
