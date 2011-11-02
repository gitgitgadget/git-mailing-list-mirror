From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: Re: Q: "git diff" using tag names
Date: Thu, 3 Nov 2011 00:08:46 +0400
Message-ID: <20111103000846.784cba29@zappedws>
References: <4EAABC15020000A100007D9D@gwsmtp1.uni-regensburg.de>
	<20111028165943.2cc8253d@ashu.dyn.rarus.ru>
	<4EB0FFCA020000A100007DE2@gwsmtp1.uni-regensburg.de>
	<20111102132945.582707aa@ashu.dyn.rarus.ru>
	<7vty6mkgsg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>,
	<git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 02 21:09:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLh7U-0006D3-2n
	for gcvg-git-2@lo.gmane.org; Wed, 02 Nov 2011 21:09:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991Ab1KBUJE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Nov 2011 16:09:04 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:43722 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750920Ab1KBUJC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Nov 2011 16:09:02 -0400
Received: by mail-bw0-f46.google.com with SMTP id 11so476422bke.19
        for <git@vger.kernel.org>; Wed, 02 Nov 2011 13:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=iMXEZjuATZnNmxEGR1nG44Wf1ltxHrNEvkaja2lRpBk=;
        b=htOcPHsoJ73NBKSGQmaTRHMSCPBt00pBK9GbTfejaG1leWNFyNEa3ySrJjmPbWAnVN
         934rq2Tg26Wv0tYZZwd/Cd/W6r74ls8cKiOWseYGShIijaNPS1HRkGv2oRwX3AndD1wY
         UP7vws6IA+W9qxjtqle59hh12D0PNvVKI0jcc=
Received: by 10.204.141.134 with SMTP id m6mr5138013bku.91.1320264541947;
        Wed, 02 Nov 2011 13:09:01 -0700 (PDT)
Received: from zappedws (ppp91-77-25-108.pppoe.mtu-net.ru. [91.77.25.108])
        by mx.google.com with ESMTPS id j9sm3380545bkd.2.2011.11.02.13.08.58
        (version=SSLv3 cipher=OTHER);
        Wed, 02 Nov 2011 13:09:01 -0700 (PDT)
In-Reply-To: <7vty6mkgsg.fsf@alter.siamese.dyndns.org>
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.22.0; i386-redhat-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184662>

Oh, I see

> Alexey Shumkin <alex.crezoff@gmail.com> writes:
> 
> >> Also it seems that both syntaxes work:
> >> git diff v0.4..v0.5
> >> git diff v0.4 v0.5
> > honestly, I do not know the difference (at the moment :))
> > may be gurus or manual will help to discover it
> 
> The latter is the kosher version, as diff is about two "endpoints"
> and not about "ranges". The only reason the former is parsed without
> erroring out is because too many people are used to type .. between
> two things without thinking, learned the notation from "git log",
> which _is_ about ranges.
