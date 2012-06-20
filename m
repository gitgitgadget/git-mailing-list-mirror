From: Brad King <brad.king@kitware.com>
Subject: Re: [PATCH 0/2] submodule add + autocrlf + safecrlf
Date: Wed, 20 Jun 2012 14:09:12 -0400
Message-ID: <4FE211C8.3080007@kitware.com>
References: <cover.1340202515.git.brad.king@kitware.com> <7vipelx49g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 20 20:09:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShPLF-0001Qh-E0
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 20:09:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754551Ab2FTSJQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jun 2012 14:09:16 -0400
Received: from na3sys009aog127.obsmtp.com ([74.125.149.107]:45040 "HELO
	na3sys009aog127.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753210Ab2FTSJQ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jun 2012 14:09:16 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]) (using TLSv1) by na3sys009aob127.postini.com ([74.125.148.12]) with SMTP
	ID DSNKT+IRy5mv64NWcbFBnG8PjimJ+juNPj97@postini.com; Wed, 20 Jun 2012 11:09:15 PDT
Received: by obbwd20 with SMTP id wd20so2368333obb.37
        for <git@vger.kernel.org>; Wed, 20 Jun 2012 11:09:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=nNbq2MI97e9qFZTefvDcZTeVMJ5g/fBPhXd3Xo9enyM=;
        b=Mkhzq5sEEEpQU741B4XjpSLOPZUkFaUnEN4UXGpVEKLTTMAUkEELVkIhwU4/OlSDaS
         yjlINQSMEafVktEPUbq3OFVk0mtHwbQVoVfoTvBc1otDsZgBhlOUcM8l7f1phqLhpa9r
         UDk9RZDRVGKL2snW1QbqQnF7+IzCHBwvD4LyIDaNrdVjCV91Dqt1j2tIE2IMAUYtWtMg
         U0iiGY6U7gqZGdUjcYII4tjZ+Ou2z6mPT4qXIYWf3PHKNjTQWZXY0K76EHB43eCfz7o9
         L/K6Sx3ikjGIsdskjvXNU/cRXIkHQyKZ6DR7s/NHihbPOkpGGGJW3ecXffUFPIN7ALmu
         l3OQ==
Received: by 10.182.18.137 with SMTP id w9mr24704376obd.75.1340215754628;
        Wed, 20 Jun 2012 11:09:14 -0700 (PDT)
Received: from [192.168.1.236] (66-194-253-20.static.twtelecom.net. [66.194.253.20])
        by mx.google.com with ESMTPS id k8sm16085519oeh.9.2012.06.20.11.09.12
        (version=SSLv3 cipher=OTHER);
        Wed, 20 Jun 2012 11:09:13 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.4) Gecko/20120510 Icedove/10.0.4
In-Reply-To: <7vipelx49g.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4
X-Gm-Message-State: ALoCoQlanklV3qRP2xoLaWxkzU8/5U7H6RQ3T429wgq0EMVu4jXjr3m3kU9YwdVCTdwkkOBsGHYP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200313>

On 06/20/2012 01:49 PM, Junio C Hamano wrote:
> I have a suspicion that "git config" should be taught about this
> kind of thing instead.
> 
> Shoudn't your .git/config file that is outside the revision control
> also end with CRLF if your platform and project prefer CRLF over LF?

That would be reasonable, but is beyond the scope I'm willing to
tackle myself.

I don't actually have a project like this so I have no strong
opinion on this issue.  I discovered the problem by accident
and have already worked around it in the obscure case it matters
for me.

Perhaps only the first patch in the series is worth inclusion.
It can become the beginning of a series if someone wants to address
handling crlf in config files.  Note that in the case I discovered
this the crlf configuration was in ~/.gitconfig so the project
knew nothing about it and had no .gitattributes.

-Brad
