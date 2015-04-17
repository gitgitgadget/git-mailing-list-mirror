From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 0/3] Another approach to large transactions
Date: Fri, 17 Apr 2015 15:17:53 -0700
Message-ID: <CAGZ79kZvE+YJeKCYXN-RD3MFmP17VkqW8WUUssk6UgK_38iWrg@mail.gmail.com>
References: <1429226259-21622-1-git-send-email-sbeller@google.com>
	<xmqq8udqheb5.fsf@gitster.dls.corp.google.com>
	<xmqqsibyo141.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 18 00:18:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YjEaF-00063f-Ez
	for gcvg-git-2@plane.gmane.org; Sat, 18 Apr 2015 00:17:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753923AbbDQWRz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2015 18:17:55 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:35232 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751703AbbDQWRy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2015 18:17:54 -0400
Received: by iejt8 with SMTP id t8so82683574iej.2
        for <git@vger.kernel.org>; Fri, 17 Apr 2015 15:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=iHMgBEjRBlKiG3GzB04mjj/WlEGPo1VHkZ+E6Z2Ii70=;
        b=f65gU3SFLUDpMCql98r2wEZ+nspKDFiR0qUKAp+whsU9BzvHln2Sn654wDHbSxVKPG
         Pf0rSKZ0IW/pE9UW3RGY2/tmLZDKo2rDBll7iv9xQzJ0MRMDkIhtM6oZIpQLVlBJ452a
         t15EjrX/fkb9zVX85oJbM/WzPbtQ4+G6Ru7aVq6ra0mY4C+v3OH1a1X9gobk7TA1KOq0
         f2s3785vKHYF7J4A+ZptAsi+pZQ3aktG606VLT4i9UIefUtZa/Q9eugZFt4c/PxBSGJn
         X10TbWvhMu5JPMlhJYdHvkmj+QRCNaZ6AGUKSgndhLT+Ek9g/QUwxiT0H7YZXCJFqQPk
         Ph+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=iHMgBEjRBlKiG3GzB04mjj/WlEGPo1VHkZ+E6Z2Ii70=;
        b=Xm0l/q+atKCMheRDundjaP6AqzDWFLdnEZzPFajj3DXTlRShKKJzfkgQyc5xAlcPAC
         DrwMxWmO5bwPFvaVvTWPlK1HbDQbW45+LJ3VozONGo+U8dJW//9swbjOSQCzDg1GkrIn
         B6ewg01e074nkM7+9R6VV1avtBXJNxYglhFRWB1wNt8C6+ibGxkTR4lGYlCErxz8UqGV
         wjs4g/PoYAdUfJWYsk+/MzRoX60n12T/EE1UlBGU17CfXbtz1otgP0U3DxqmDkjZT//c
         R4NK4lusy06ZTvDEMcNC+TqY6zRjJOZMFheHdMXntkc9mm+eAIy296xlEnhtqkC211uR
         +Q6Q==
X-Gm-Message-State: ALoCoQm0EOBxAXfIWpU+pJKPRk34VKM4EZBQb6VjrZH+VRPJFI/lcA8ri9VB8F6KrIp+3H/tuPhA
X-Received: by 10.42.188.19 with SMTP id cy19mr6175039icb.92.1429309073926;
 Fri, 17 Apr 2015 15:17:53 -0700 (PDT)
Received: by 10.107.46.22 with HTTP; Fri, 17 Apr 2015 15:17:53 -0700 (PDT)
In-Reply-To: <xmqqsibyo141.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267397>

On Fri, Apr 17, 2015 at 3:12 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> This is now pushed out and sitting at the tip of 'pu'.  It seems to
> break one of the tests in 1400 when merged to 'next', but I didn't
> look it closely.
>
> Thanks.

ok, I'll look more closely.
