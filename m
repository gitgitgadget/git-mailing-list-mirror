From: "Justin P. Mattock" <justinmattock@gmail.com>
Subject: Re: help reverting a merge
Date: Mon, 30 Nov 2009 16:06:50 -0800
Message-ID: <4B145E1A.9040304@gmail.com>
References: <dd18b0c30911291524q7ea7e9c7v980340ddf7269519@mail.gmail.com> <20091130081315.GA587@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 01 01:07:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFGGg-00088d-NB
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 01:06:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754099AbZLAAGr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 19:06:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754082AbZLAAGr
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 19:06:47 -0500
Received: from mail-gx0-f212.google.com ([209.85.217.212]:61061 "EHLO
	mail-gx0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751347AbZLAAGr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2009 19:06:47 -0500
Received: by gxk4 with SMTP id 4so3177503gxk.8
        for <git@vger.kernel.org>; Mon, 30 Nov 2009 16:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=fWNBJMALczj6Y7HNa9Ftx7n4ztL61v9mXUCOiSlLaGE=;
        b=xJxFEkK/wV9BmSuAK7QOOMKBRu4PswjMWtzAeMN+zwQkIEhi6fDglz5/bCUz2qMBVp
         lYThmk4nPPis+Ps5d8q+aKSalSIUz5yBHAg6HQPmlWTLOu7FJ/AtVbakIGfkjPo/lf8u
         kivC98WJtne+qenoKuTgsbm85uB1RCFEgeqW4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=h1daT2RTtfmR3cf+ULwggpA0Xxgb5yLWHCbEzoOYtr5cJKBuz13+IUvPFYf2kyuxLw
         L3FuNq4VDreOqD7qWvaIH+TKEFxFeb6X2jojBuzka2QU/OsUDivruAC3iyAmAnCeAh6d
         9gnq7uh/ZFGhN52qAWMpM24gvEIr5Ct1ffMQA=
Received: by 10.91.148.11 with SMTP id a11mr7336177ago.14.1259626013069;
        Mon, 30 Nov 2009 16:06:53 -0800 (PST)
Received: from ?10.0.0.95? (cpe-76-173-26-187.socal.res.rr.com [76.173.26.187])
        by mx.google.com with ESMTPS id 15sm2283445yxh.22.2009.11.30.16.06.51
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 30 Nov 2009 16:06:51 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.4pre) Gecko/20091114 Lightning/1.0pre Thunderbird/3.0b4
In-Reply-To: <20091130081315.GA587@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134153>

First things first is I owe you a great thanks
for teaching me how to do a rebase.. :-)

took a while, and still a bit confusing
but I managed to do exactly what you
had written down.

bad thing is somehow the bisect came up
with no results. probably will do another bisect,
just to make sure things are in the right
direction, and the try the rebase again.

Again Thanks for the help/info on this.

Justin P. Mattock
