From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v3 2/3] travis-ci: express Linux/OS X dependency versions more clearly
Date: Mon, 25 Apr 2016 09:05:27 +0200
Message-ID: <EAB93C5E-56E1-4361-8987-E9DFB6C2F428@gmail.com>
References: <1461524292-20490-1-git-send-email-larsxschneider@gmail.com> <1461524292-20490-3-git-send-email-larsxschneider@gmail.com> <CAPig+cSoWqZhQY8asE0akgSKqaRbU0pd87_mjA5kBdEueUZBrQ@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"sschuberth@gmail.com" <sschuberth@gmail.com>,
	"gitster@pobox.com" <gitster@pobox.com>,
	"ben.woosley@gmail.com" <ben.woosley@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Apr 25 09:05:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auaaP-0008Q8-9A
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 09:05:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753643AbcDYHFc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 03:05:32 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:36209 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753630AbcDYHFb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Apr 2016 03:05:31 -0400
Received: by mail-wm0-f51.google.com with SMTP id v188so85861646wme.1
        for <git@vger.kernel.org>; Mon, 25 Apr 2016 00:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=S5za64iz5iPkg95usOO2LnCp/6l0RYmKrXww+fYO0Bs=;
        b=H4uG3th/LVHiJ6oYp0cQ79ngw3pXHgb2/wCnu68fAp4U0VKpvADW2NbIoR5Hy0YFBF
         SvcjqeyfmtOMarBLH3/wNEQiFrGqPyJDQWmOiSUlcVka4/dC4iEv2aPB42gasYXgYbej
         IPP2FB6vVZAcJuyfKva9MZLpjeTaNV9paQgIUMAzwYi0jnCE2NxBFalU31qSyk3mR23J
         McTJ98B1FZgprHyVW+xWvcx7Ve9uIrIltLC4TiQl3u+p4NmQyRyCDdvwAKdhuuhx1saA
         NbMaZlGDQzr4BRkjue8Xa0YaF25HwtH6SP73Med53KXdMRUv022HD2Q2B6buiCHblCZV
         hWXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=S5za64iz5iPkg95usOO2LnCp/6l0RYmKrXww+fYO0Bs=;
        b=HBGAzxsFN7xrtLB/Zi1gs6nZ1pPkg6Dx4kjvb7d36JLwWZHSIdFFDc0wPj4+zRGcre
         CI7nqb3Sw/vCvAm5FsljQSNcUhULdq12p4W7gWIHQQ2Imz4w/4cgErJxrP8zlZ8RxeQS
         YaHYtBM+tDNLaoUXERmsyAGGxcyr0FBb/0ifUHHcFODBEDLd4+DCcC68WXrDYghPg+Bv
         P2cX4cC/He7oZyh3ZcCm7/xzMkewOZDLBFR1BI97Rm7AFMwlNPUUWh1e4K7KSlX6aEJX
         F8oye/W0iLROHO+0TUObcIUv6m0HiyxXZfDIR+bcazNxZLkiXj+OMhrr7Ed+1qufKNmS
         /oAg==
X-Gm-Message-State: AOPr4FUEyh4ABDlxp5hnL7g56SJZXUh1uabHy+R8mV1rgYzPdDt02334NxQJDYF7FWBc9g==
X-Received: by 10.28.24.195 with SMTP id 186mr10235373wmy.30.1461567929837;
        Mon, 25 Apr 2016 00:05:29 -0700 (PDT)
Received: from slxbook3.fritz.box (p5DDB4886.dip0.t-ipconnect.de. [93.219.72.134])
        by smtp.gmail.com with ESMTPSA id b124sm16696980wmb.1.2016.04.25.00.05.28
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Apr 2016 00:05:29 -0700 (PDT)
In-Reply-To: <CAPig+cSoWqZhQY8asE0akgSKqaRbU0pd87_mjA5kBdEueUZBrQ@mail.gmail.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292451>


On 25 Apr 2016, at 06:40, Eric Sunshine <sunshine@sunshineco.com> wrote:

> On Sunday, April 24, 2016, <larsxschneider@gmail.com> wrote:
>> The Git Travis CI OSX build always installs the latest versions of Git LFS and
>> Perforce via brew and the Linux build installs fixed versions. Consequently new
>> LFS/Perforce versions can brake the OS X build even if there is no change in
> 
> s/brake/break/

Thank you!

> 
>> Git.
>> 
>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
