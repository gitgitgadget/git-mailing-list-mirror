From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [BUG] t9801 and t9803 broken on next
Date: Thu, 19 May 2016 19:32:59 +0200
Message-ID: <9CA2E5C1-ECAD-4C8C-A495-55041A1CC256@gmail.com>
References: <3A110437-F778-42E2-A987-86B4EAB3D963@gmail.com> <20160513103621.GA12329@dcvr.yhbt.net> <xmqqpospap8g.fsf@gitster.mtv.corp.google.com> <4830D469-3885-4010-9A04-D809F0C6159D@gmail.com> <xmqq37pk8q0h.fsf@gitster.mtv.corp.google.com> <5E7631C9-DD59-4358-B907-D7C7AEA1739C@gmail.com> <20160517121330.GA7346@sigill.intra.peff.net> <DD9F360B-78F0-4C83-B642-606688772E39@gmail.com> <xmqq1t4ykmjj.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Jeff King <peff@peff.net>, Eric Wong <e@80x24.org>,
	Git Users <git@vger.kernel.org>,
	Luke Diamand <luke@diamand.org>, spearce@spearce.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 19 19:38:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3Roq-0008V6-Mk
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 19:33:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754282AbcESRdE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2016 13:33:04 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:36114 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754063AbcESRdC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 May 2016 13:33:02 -0400
Received: by mail-wm0-f54.google.com with SMTP id n129so241080119wmn.1
        for <git@vger.kernel.org>; Thu, 19 May 2016 10:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=KFYkwfn3MQ5+11jHn/JiVB1dnUmNPsKKhm8Zb35IFLQ=;
        b=QYHS2nhi/qtFwDE2YcbcrsUZltbtFT1CZCKySc1FDh4ku7p4v56XpPROHGOCcvmP0l
         hYL6T9k4KuQoYH7+uyudov3c01iG9ofCXTaSOj7blS8gIMla5k3x6XzOIQ9agM8FHBIz
         JdncVATjKi9UkHI/PKtbRLbYW6cXEYnC24PEByRxyTklo7DuBBjR70M55eM3KZ+JmhVu
         rriRq0GO28ETcYDPVNA4xp9VrQM7pT0F7sUt1OjP+KM6EVHwKki9dWY2IH3RnDIhhYx9
         rinVDGzm4+nJdeNzYybbuPfRfdeX3SHOQgKX+PG5RywsUYlm/HCEN52US1vrL1qpbRog
         mQhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=KFYkwfn3MQ5+11jHn/JiVB1dnUmNPsKKhm8Zb35IFLQ=;
        b=OssixTob5O/PWA+P67PI3XSiaIWccT81NUaCJvrVdCUQi7xyDCJnA27DIs4jAxztMZ
         9K17ViDcJw+qpEh4VUxb5JlWEDz+5bn49ZfsuA09GBCht+YzXGc9O88nAmz2QID5lABT
         HXtz+VrLw36IztGpQGzF0HIWc9CTNHo5hUev+W6BckO2/MVAjU8/799up8d1pC+/4jAg
         HbHCLPCdYMWDyxKBjtRCnTQrWPj6ak28KhgSuDFR+fN0TwbW+fDJLj9ckrBcVHc43pRi
         HARQlciZqPNWpTJVz/dFFytzDyrY3myvn7WHq/HxCnEzfQJsaolnfiX7Y1pvBxC54VxN
         0v9Q==
X-Gm-Message-State: AOPr4FXY1EuMyCclbD3X1jFCRs4cP+7bxYwlsXxcBEWJixvbC68qi5Dn4nwck5gG/9Ogyg==
X-Received: by 10.28.14.73 with SMTP id 70mr14566428wmo.15.1463679180443;
        Thu, 19 May 2016 10:33:00 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id m140sm254336wma.24.2016.05.19.10.32.59
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 May 2016 10:32:59 -0700 (PDT)
In-Reply-To: <xmqq1t4ykmjj.fsf@gitster.mtv.corp.google.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295079>


> On 19 May 2016, at 19:03, Junio C Hamano <gitster@pobox.com> wrote:
> 
> Lars Schneider <larsxschneider@gmail.com> writes:
> 
>> From my point of view little packs are no problem. I run fast-import on
>> a dedicated migration machine. After fast-import completion I run repack [1] 
>> before I upload the repo to its final location.
> 
> How do you determine that many little packs are not a problem to
> you, though?  Until they get repacked, they are where the
> fast-import will get existing objects from.  The more little packs
> you accumulate as you go, the more slow fast-import's access to them
> has to become.
True. But my particular use case is a one time operation for a given
repository. Therefore I don't care how long it takes. The only important
aspect is that the result is correct.

That being said, Peff's proposed fix looks correct to me but since I 
am no fast-import expert my opinion doesn't count too much.

- Lars
