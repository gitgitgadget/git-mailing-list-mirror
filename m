From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH] Teach remote machinery about remotes.default config variable
Date: Sat, 12 Jan 2008 01:16:12 -0500
Message-ID: <47885B2C.8020809@gmail.com>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com>	<1200022189-2400-2-git-send-email-mlevedahl@gmail.com>	<7v1w8o4ws0.fsf@gitster.siamese.dyndns.org>	<30e4a070801111252s4e17b9c4m62adeb9032963e66@mail.gmail.com>	<7v63xzzszp.fsf@gitster.siamese.dyndns.org>	<478855B5.9070600@gmail.com> <7vbq7ry405.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 07:16:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDZfp-0006Vr-Mc
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 07:16:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751677AbYALGQQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2008 01:16:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751479AbYALGQQ
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 01:16:16 -0500
Received: from an-out-0708.google.com ([209.85.132.246]:30636 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751400AbYALGQP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2008 01:16:15 -0500
Received: by an-out-0708.google.com with SMTP id d31so299854and.103
        for <git@vger.kernel.org>; Fri, 11 Jan 2008 22:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=iQUEkYgau3P/HH9MbMzmDJ0Li2XEXsdXLED6Xq9V+zo=;
        b=N+FncKddLJm4LHWOfOqNI23+zDEwSRSvwvaYar3fS0kM+EFT4Km8gO4FUPbftXPPdk8c+br+3ttHpJJGXAgPJCSLlvPFyHJucFesatH5s4QXrBo0njuxZUCgrn4Xi9ZgvHg8xSUCJJ0R2RHF6Eq/a+rx+DNgS6K6Svf7/Bmp8RA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=GW/bVgThfKTd58r7nGetU/ML8hU13nExrRvrzmo3G72woCYp12Z27/WoLlqk5ReI2DENGg6HhWsE+8HdhJGiDsa9tNM1Pgp5jMocGF/mUxFSMCPqUADe89w0Vc3OkgwkwHYk0Aku0z//qIFGybAPUyBlXhxeeZIrLVlehUw/WGY=
Received: by 10.100.251.5 with SMTP id y5mr8623209anh.75.1200118574487;
        Fri, 11 Jan 2008 22:16:14 -0800 (PST)
Received: from ?192.168.1.117? ( [71.163.17.196])
        by mx.google.com with ESMTPS id i15sm6306002wxd.17.2008.01.11.22.16.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 11 Jan 2008 22:16:13 -0800 (PST)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <7vbq7ry405.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70276>

Junio C Hamano wrote:
> Mark Levedahl <mlevedahl@gmail.com> writes:
>
>
>   
> It's that simple.  Isn't it?
>
>   
Yes, until you hit submodules whose state you are managing from a super 
project. Then it gets hard because the machinery brings origin into play.

Mark
