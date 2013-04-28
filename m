From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/6] clone: Make the 'junk_mode' symbol a file static
Date: Sat, 27 Apr 2013 21:55:40 -0400
Message-ID: <CAPig+cSJujQ0qMMJ4+sqob_sTzPEokF81bjm69KFK5Ja+mCV8g@mail.gmail.com>
References: <517C1B48.5090206@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sun Apr 28 03:55:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWGqA-0008Ic-Vq
	for gcvg-git-2@plane.gmane.org; Sun, 28 Apr 2013 03:55:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755590Ab3D1Bzm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 21:55:42 -0400
Received: from mail-lb0-f177.google.com ([209.85.217.177]:53230 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755440Ab3D1Bzm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 21:55:42 -0400
Received: by mail-lb0-f177.google.com with SMTP id x10so4697954lbi.22
        for <git@vger.kernel.org>; Sat, 27 Apr 2013 18:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=0xyhMFL3GDtXkB5AXgTsVMfykLKqTt30Ta7+EpZKZyw=;
        b=hBhzZMCE7xPtfCMlZYE1m+iAMY2VYpyecWfSl4irktVvSBZlF7aUW4rI/xj70Xe7gG
         hqvF1csB2BpMzvPIZds0nyXkPJH5BgZXBC02NTjsdKTcIV43CFUPizgtl2XD5Gf9LvVj
         U9lJyhcSMVaC04ccT6pPE358g1TG7JDqAoHlauekPWBy2civCHn6kcnzX0Q4rCjtOyzt
         W73GzWXwbuDp4wiNajGf8q8ugSGiGbQ4iIE2edUirRt06SOb3N7e77hloQrY4gW4VoY8
         pr35O/0CV2EqnCVND+ov1enTcmWJCu0ClsbTuHkAOpcZkueywFyvTxQ0dERgmbOyKjl/
         tNMg==
X-Received: by 10.112.59.68 with SMTP id x4mr23748770lbq.121.1367114140649;
 Sat, 27 Apr 2013 18:55:40 -0700 (PDT)
Received: by 10.114.199.11 with HTTP; Sat, 27 Apr 2013 18:55:40 -0700 (PDT)
In-Reply-To: <517C1B48.5090206@ramsay1.demon.co.uk>
X-Google-Sender-Auth: 7aTLEuMFmsdyr0P_mBuKPAf8chk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222723>

On Sat, Apr 27, 2013 at 2:39 PM, Ramsay Jones
<ramsay@ramsay1.demon.co.uk> wrote:
> Sparse issues an "'junk_mode' not declared. Should it be static?"
> warning. In order to suppress the warning, since this symbol does
> not need more than file visibility, we simply add the static
> modifier to it's declaration.

s/it's/its/

> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
