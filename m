From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/2] Improve git-pull's option parsing
Date: Tue, 02 Jun 2015 13:26:36 -0700
Message-ID: <xmqqpp5d26wz.fsf@gitster.dls.corp.google.com>
References: <1433254973-13797-1-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 02 22:29:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yzsnt-000780-Un
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 22:28:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752229AbbFBU0p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 16:26:45 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:37932 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752149AbbFBU0i (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 16:26:38 -0400
Received: by igblz2 with SMTP id lz2so20621864igb.1
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 13:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=wIbk4lAO1TdfmaYSCb4KY7RaTZVfd+51XEuD+TpDuZY=;
        b=P7/B9LXMKYu1jt9MSEaWZdnv0OwsimKY+5BMrNBEhgxto1ObWB2o0mdZkql1DOFSeu
         DvLBNpk/173VXAy2BJvTn38dXaJclF2JiPbBVyngRbmy/hB6wsbFgL+zdm4BkvKGFmMm
         Rg37VM7/LQKp1RJj41IBugIWMJ1g0+64rTcXr4kvWCp3v5B0/Gt5scDAVqMNWa78op2P
         3I50g6ZGB80qzAHd1LEK2OXU4tXHA4BqwAb8/MPno6l3s9/mG9OBz3c6Rv1n9picbXCh
         TTEilDHCYnO1dsb3fUMG+0W3a0sFLMbHvW59ULHoxBj40igSdoFRu2Gn/iLapZYUF+Zg
         1abA==
X-Received: by 10.107.19.221 with SMTP id 90mr36477266iot.26.1433276798135;
        Tue, 02 Jun 2015 13:26:38 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3140:53f3:e8c0:89b0])
        by mx.google.com with ESMTPSA id p8sm10673202iga.13.2015.06.02.13.26.37
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Jun 2015 13:26:37 -0700 (PDT)
In-Reply-To: <1433254973-13797-1-git-send-email-pyokagan@gmail.com> (Paul
	Tan's message of "Tue, 2 Jun 2015 22:22:51 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270596>

Paul Tan <pyokagan@gmail.com> writes:

> However, certain functions in git-pull assume that the positional
> parameters do not contain any options. Fix this by making git-pull
> handle git-fetch's options as well at the option parsing stage.

Good.
