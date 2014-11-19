From: Paul Smith <paul@mad-scientist.net>
Subject: Re: [PATCH] git-new-workdir: Don't fail if the target directory is
 empty
Date: Tue, 18 Nov 2014 19:57:30 -0500
Organization: GNU's Not UNIX!
Message-ID: <1416358650.9305.184.camel@homebase>
References: <1416073760.9305.174.camel@homebase>
	 <xmqqy4r9yc5u.fsf@gitster.dls.corp.google.com>
	 <s934mtwo0zv.fsf@mad-scientist.net>
	 <xmqq8uj8wbhl.fsf@gitster.dls.corp.google.com>
	 <1416344066.3899.25.camel@mad-scientist.net>
	 <xmqqegt0usy3.fsf@gitster.dls.corp.google.com>
	 <1416349502.3899.30.camel@mad-scientist.net>
	 <CAPc5daVy0Oe6UX3VCk_7UdabktbM29MceP9mt0ZZHad1K4HVmQ@mail.gmail.com>
Reply-To: paul@mad-scientist.net
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 19 02:03:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xqtgb-00087b-3q
	for gcvg-git-2@plane.gmane.org; Wed, 19 Nov 2014 02:03:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754941AbaKSBDx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 20:03:53 -0500
Received: from gproxy8-pub.mail.unifiedlayer.com ([67.222.33.93]:38765 "HELO
	gproxy8-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754505AbaKSBDw (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Nov 2014 20:03:52 -0500
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Nov 2014 20:03:52 EST
Received: (qmail 24687 invoked by uid 0); 19 Nov 2014 00:57:12 -0000
Received: from unknown (HELO CMOut01) (10.0.90.82)
  by gproxy8.mail.unifiedlayer.com with SMTP; 19 Nov 2014 00:57:12 -0000
Received: from box531.bluehost.com ([74.220.219.131])
	by CMOut01 with 
	id HCx71p00L2qhmhE01CxARf; Tue, 18 Nov 2014 17:57:12 -0700
X-Authority-Analysis: v=2.1 cv=dfgTgxne c=1 sm=1 tr=0
 a=GcR8MKwCKDX7fzHfRD/fNg==:117 a=GcR8MKwCKDX7fzHfRD/fNg==:17 a=cNaOj0WVAAAA:8
 a=f5113yIGAAAA:8 a=IkcTkHD0fZMA:10 a=pBbsfl06AAAA:8 a=cdVwids0oJMA:10
 a=qenwzdlAJUAA:10 a=5y4faFyK3SkA:10 a=piN17nOxxR0Col_DHngA:9
 a=QEXdDO2ut3YA:10 a=LmaAypxc0lkA:10 a=ASCG4TCqUw4A:10 a=Ut603UFfLCcA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mad-scientist.net; s=default;
	h=Content-Transfer-Encoding:Mime-Version:Content-Type:References:In-Reply-To:Date:Cc:To:Reply-To:From:Subject:Message-ID; bh=YHkfsOCRKzKBan/TaQxxnpOTUcGbHPF5M4m1MCSvM6M=;
	b=PQBjI6dl05QWinLzsLT0nqGVKH62Z3NTJ80QohqUlps8LSbkiVmkx+MyEdlXMgKKFTONx2nbKJfLdTilFT08d2NRJxpNcIrgzCiMtvWuFuJfMYROgV7kH7lVxdNKMQJH;
Received: from [72.74.248.26] (port=58718 helo=homebase.home)
	by box531.bluehost.com with esmtpsa (TLSv1.2:DHE-RSA-AES128-SHA:128)
	(Exim 4.82)
	(envelope-from <paul@mad-scientist.net>)
	id 1XqtZz-0006bW-7K; Tue, 18 Nov 2014 17:57:07 -0700
In-Reply-To: <CAPc5daVy0Oe6UX3VCk_7UdabktbM29MceP9mt0ZZHad1K4HVmQ@mail.gmail.com>
X-Mailer: Evolution 3.11.3-fta1~13.10 
X-Identified-User: {678:box531.bluehost.com:madscie1:mad-scientist.us} {sentby:smtp auth 72.74.248.26 authed with paul@mad-scientist.us}
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 2014-11-18 at 14:51 -0800, Junio C Hamano wrote:
> OK, thanks for digging. Let's go with this version, then.

Thanks for your attention, Junio!
