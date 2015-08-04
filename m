From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Aug 2015, #01; Mon, 3)
Date: Mon, 03 Aug 2015 18:13:50 -0700
Message-ID: <xmqqoain6ek1.fsf@gitster.dls.corp.google.com>
References: <xmqq38006mod.fsf@gitster.dls.corp.google.com>
	<CACRoPnRj4apVat2oWVHvUgWdLp6RJZsWw-s=juB-Sdc3dL30ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 04 03:13:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMQnm-0006Ur-AU
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 03:13:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753219AbbHDBNy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2015 21:13:54 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35617 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751136AbbHDBNw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2015 21:13:52 -0400
Received: by pasy3 with SMTP id y3so26717891pas.2
        for <git@vger.kernel.org>; Mon, 03 Aug 2015 18:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=T0KO/cEJVANle5ewT/amoNDROPI3p5K+OO5QekczQEc=;
        b=glX9TwkFKDpdJTYsWENDQYiZ9tUyPQDl9quzvPwBvsgpYZ2yhbg+1eziGMVvJCHB+h
         +BQrLC5FNq9/MaAzyEVW2Hr9Eb8Yg1+/9xm5mL6p6fw1P40oRXmMkMa71h90r9hyixMK
         CDiExiZJSsZiSPYvoDNzswXMa3lMN+p10SuulbmVN5eMQbtNBMwYYkjTSXDV2p+EvUQg
         2T/qjYe5G/zxqCGQpULVzZJbMXYlqjsYMYNFG7SbogDwAdRzsOlVjYC/iINbrRyR1/Ay
         RCVWP8kOjJiZW3b1VWgsu+okun9d5oGWx9JdSqZfixqf7rHnN+/vOVhkXVqTCVP2mE+G
         jGzw==
X-Received: by 10.68.233.228 with SMTP id tz4mr1944781pbc.152.1438650831605;
        Mon, 03 Aug 2015 18:13:51 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:38a2:7ad5:137e:6e11])
        by smtp.gmail.com with ESMTPSA id ok17sm18841137pdb.26.2015.08.03.18.13.50
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 03 Aug 2015 18:13:51 -0700 (PDT)
In-Reply-To: <CACRoPnRj4apVat2oWVHvUgWdLp6RJZsWw-s=juB-Sdc3dL30ng@mail.gmail.com>
	(Paul Tan's message of "Tue, 4 Aug 2015 08:16:29 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275235>

Paul Tan <pyokagan@gmail.com> writes:

> I'm thinking about leaving them broken for now to push this patch
> series forward,...

Options upon restarting was not working at all with the old code
anyway, so that course of action sounds sensible.

Thanks.
