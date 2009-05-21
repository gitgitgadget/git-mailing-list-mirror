From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [RFC/PATCH] completion: complete pretty format placeholders
Date: Wed, 20 May 2009 20:59:00 -0700
Message-ID: <4A14D184.8030301@gmail.com>
References: <1242468449-3364-1-git-send-email-bebarino@gmail.com> <20090520225258.GT30527@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu May 21 05:59:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6zR4-0003oC-0A
	for gcvg-git-2@gmane.org; Thu, 21 May 2009 05:59:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751506AbZEUD7G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2009 23:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbZEUD7E
	(ORCPT <rfc822;git-outgoing>); Wed, 20 May 2009 23:59:04 -0400
Received: from mail-px0-f171.google.com ([209.85.216.171]:60739 "EHLO
	mail-px0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750971AbZEUD7D (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2009 23:59:03 -0400
Received: by pxi1 with SMTP id 1so463225pxi.33
        for <git@vger.kernel.org>; Wed, 20 May 2009 20:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=pq/DlXdyEiBbJrmvUwpuuzKvVqqq6UU2v2QLr1RZl6g=;
        b=teCvPcN1gvOFRM2SdVreULQRBtQ0abs77BraJk/fvUTAFcWGhaJk2FNomi/e0ceWJr
         6gWfAJdNLaj7739iIQvPBdgeEQADsnjNiTK7bc2P1d/BBIEW6JVSdNtMlmQOX3wBIVgQ
         02RKZX6zk6LSZCkXX4+gv3wKTBB6kfVvJHo1s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=LkRz+qkPtxKPcbFn+h07I12HgaYXgt0eEaViKOy686FTsN/WL420/gT0+AHaOg++/z
         /18ITS+nn7ObB1+/PRKMMFVAn4Yhpduz0igJYOU2FPd2YGFPyzcy2SVyT08jRrGEVPl2
         X2tV4nFoGO2qwUwzC8b/tgjgL1jy40+DBxn1c=
Received: by 10.115.58.1 with SMTP id l1mr4159778wak.191.1242878344056;
        Wed, 20 May 2009 20:59:04 -0700 (PDT)
Received: from ?192.168.1.2? ([76.89.212.195])
        by mx.google.com with ESMTPS id m6sm4552867wag.49.2009.05.20.20.59.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 20 May 2009 20:59:02 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090429)
In-Reply-To: <20090520225258.GT30527@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119651>

Shawn O. Pearce wrote:
> bash oddity?  Back when I started the completion I had a lot
> of trouble with stuff like --pretty=<TAB>, or foo:<TAB> because
> bash more often than not tried to second guess what I was doing.
> I wonder if you are running against that here.

Thanks for the heads up.

> To be honest, I'm not sure what value this provides.  Its just as
> many characters to type, isn't it, and it doesn't offer me any help
> as to which placeholder should be inserted to get the value I want.
> "Was it ae or aE that I wanted here?  WTF, manpage time!".

Yeah, you're probably right. Throw it on the dust pile ;-)
