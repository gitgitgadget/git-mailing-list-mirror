From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: git-daemon on NSLU2
Date: Fri, 24 Aug 2007 15:38:32 -0400
Message-ID: <9e4733910708241238n1899f332j4fafbd6d7ccc48b9@mail.gmail.com>
References: <9e4733910708232254w4e74ca72o917c7cadae4ee0f4@mail.gmail.com>
	 <20070824062106.GV27913@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Aug 24 21:39:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOezj-0000UH-TW
	for gcvg-git@gmane.org; Fri, 24 Aug 2007 21:39:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750908AbXHXTie (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Aug 2007 15:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755868AbXHXTie
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Aug 2007 15:38:34 -0400
Received: from rv-out-0910.google.com ([209.85.198.188]:58201 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755181AbXHXTid (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2007 15:38:33 -0400
Received: by rv-out-0910.google.com with SMTP id k20so722883rvb
        for <git@vger.kernel.org>; Fri, 24 Aug 2007 12:38:32 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ehCUIgYp4fw8jFrhw4dqJLOmMbCIFRzps5kc69jC4gqa51nvlhbZdd8vbhZUus1YjpSl6Isel6IkJDPXw2/YpLlLHbStCRZ38aOQv9Hcs9BDMRCAM0+B9w5Td5RxnL39vwn7sgQ4HFTYKKD/YBor4vgnKjTZbwr8xEad5aZ+CDg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TFMvuTVF80MkSR6eLz5gZBRhjXkpr1+BGmFCK2DBijpPR/ZF0P5yE6HP1HE+7vovNgJFKvxqhKBV8MBG/0TyUlUT6q8ScGtlOHtcvTAr10YgLWjnpR5ioXC12joRsyJhiIhWIn9Vw0nxcOpkmptFFT1pJLQZ3OR4IfGbKFDHh/8=
Received: by 10.114.178.1 with SMTP id a1mr742533waf.1187984312542;
        Fri, 24 Aug 2007 12:38:32 -0700 (PDT)
Received: by 10.114.195.5 with HTTP; Fri, 24 Aug 2007 12:38:32 -0700 (PDT)
In-Reply-To: <20070824062106.GV27913@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56595>

I'm still trying to debug git-daemon

I do find it surprising that git-index-pack can't be happy with in
20MB of RAM and it has to continuously swap it's 30MB of virtual. My
disk is chattering itself to death. It stayed that way for 40 minutes.

I'm practicing on the kernel tree.

-- 
Jon Smirl
jonsmirl@gmail.com
