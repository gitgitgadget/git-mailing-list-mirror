From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix detection of uname failure
Date: Fri, 17 Jul 2015 10:09:13 -0700
Message-ID: <xmqq615i3e4m.fsf@gitster.dls.corp.google.com>
References: <1437135095-6244-1-git-send-email-charles@hashpling.org>
	<ef7d56584c3b5d6431f895df1d94eba8@www.dscho.org>
	<20150717170142.GA9616@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Fri Jul 17 19:09:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZG98S-0004JT-Gz
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jul 2015 19:09:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752766AbbGQRJQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2015 13:09:16 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34825 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752566AbbGQRJP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2015 13:09:15 -0400
Received: by pactm7 with SMTP id tm7so64218807pac.2
        for <git@vger.kernel.org>; Fri, 17 Jul 2015 10:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=tnnNgKNq4Sx4kUzR/0kyPiGqNnjcFfXhGJiz0WVgjJU=;
        b=xEwgc7vicSbGeABu6ynWCniFhtNV9JsGrXsaQnNjcCXq1R+xLsbhImuLWNAsn1DQ4V
         hUeblmZsP1wu1Ke1MxP0FB2xVkVX/+JDgWEu3+hCLO/g4ZRaVwg7ffwEbpRfQkRmdUEI
         EMpIILdMGb0jW9W32OwpqaNuJfZWRsw1hXsNqFTmzTC+WFYW6F2pMiuCARRRiqgKLXfo
         oT1fWPOZjWUnJ13c+gbrugZIxK8J1TFtiYCTxZrMTyY6fyeB935hlX7w8XM9uvj3rfkq
         PeIj5r0fduza5shLumhCJjkSHJI2q1tLNWMq9AvnAORYOMA1Ehsy/mFuoIDreL4lmW1h
         60fA==
X-Received: by 10.68.167.131 with SMTP id zo3mr31399156pbb.123.1437152954701;
        Fri, 17 Jul 2015 10:09:14 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:902a:e9ec:1aae:aea2])
        by smtp.gmail.com with ESMTPSA id gs7sm11821387pbc.6.2015.07.17.10.09.13
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 17 Jul 2015 10:09:13 -0700 (PDT)
In-Reply-To: <20150717170142.GA9616@hashpling.org> (Charles Bailey's message
	of "Fri, 17 Jul 2015 18:01:42 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274086>

Charles Bailey <charles@hashpling.org> writes:

> ... I think '< 0' is
> probably better. In POSIX, we shouldn't ever get a negative value which
> isn't -1, but if we ever do it is probably safer to fail. I'll send and
> update.

Thanks; I was about to type the same reasoning and conclusion ;-)
