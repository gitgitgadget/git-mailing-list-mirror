From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH 1/2] commit.c - provide commit-type to the hooks/pre-commit
 script
Date: Mon, 07 Jun 2010 22:55:27 -0400
Message-ID: <4C0DB11F.90904@gmail.com>
References: <1275759590-16342-1-git-send-email-mlevedahl@gmail.com> <20100606221037.GE6993@coredump.intra.peff.net> <4C0C912D.9080404@viscovery.net> <20100607063817.GA23361@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 08 04:56:37 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLozU-0006VI-TS
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 04:56:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752012Ab0FHCzf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jun 2010 22:55:35 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:54701 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750897Ab0FHCze (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jun 2010 22:55:34 -0400
Received: by vws17 with SMTP id 17so850538vws.19
        for <git@vger.kernel.org>; Mon, 07 Jun 2010 19:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=ywkYpWmWsssrV/h1pXxOEC2XVlNyGJ631ks8w4iHiV8=;
        b=Q9EKNU63bKTLRfZX+W3+20JDE3hxfceaE/znU8DJ0ahHBqUFtGQBR28x7+NUeWAj4w
         OjRzgHySXRX/xgsyDVaC2bzq7UaN65q5IqdL1SVT6lsJzmmKcCtDDNj/K8i1gmeeDyV3
         q1Bm/mdOuELXVxqvqftbgTJ+Mt7jEJsc9TU2g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=q68G7AeuE2Cfcv2kozko/C4JtYzKDadCQMirQxsCi4yGKkv3c6RxmlDFFNALkBY8hu
         ZBBdg86GiHMVwxC0JQ4SkAHvPrZbz6aCDr/byT9UVownFicYvwtE541akRdG6cSbPZmk
         yoHoWps1pUI3Vs5pc2Gnn6b/tpIISW28cVcaA=
Received: by 10.224.78.157 with SMTP id l29mr101757qak.214.1275965729142;
        Mon, 07 Jun 2010 19:55:29 -0700 (PDT)
Received: from mark-laptop.lan (pool-71-191-167-79.washdc.fios.verizon.net [71.191.167.79])
        by mx.google.com with ESMTPS id 2sm8037422qwi.29.2010.06.07.19.55.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 07 Jun 2010 19:55:28 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.9) Gecko/20100430 Fedora/3.0.4-2.fc12 Thunderbird/3.0.4
In-Reply-To: <20100607063817.GA23361@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148639>

On 06/07/2010 02:38 AM, Jeff King wrote:
> Actually, I meant to provide the hook with the literal words "HEAD~1"
> and "HEAD", not the sha1. So they are effectively magic words, but they
> also happen to be useful for directly feeding to git commands.
>
> It also extends naturally to indicating a merge commit ("HEAD" or
> "HEAD~1" followed by some other ref). I don't know if that is useful or
> not, but it seems like the same realm of information as whether or not
> we are amending.
>
> -Peff
>
>    
I agree with this, though I have no itch regarding all of the commit 
parents for a merge commit so I'll leave that for another to scratch. 
So, I'm sending a new series to use HEAD~1 and HEAD rather than amend 
and normal.

Mark
