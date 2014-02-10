From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 7/9] rebase: parse options in stuck-long mode
Date: Mon, 10 Feb 2014 01:59:02 -0500
Message-ID: <CAPig+cT-SptdV_rargSgJLMANQaJqnq8g+DjgdNwMvwHXC_NUA@mail.gmail.com>
References: <1391994218-639101-1-git-send-email-sandals@crustytoothpaste.net>
	<1391994218-639101-8-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Nicolas Vigier <boklm@mars-attacks.org>,
	Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Mon Feb 10 07:59:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WCkq8-000097-Gf
	for gcvg-git-2@plane.gmane.org; Mon, 10 Feb 2014 07:59:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835AbaBJG7F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Feb 2014 01:59:05 -0500
Received: from mail-yk0-f172.google.com ([209.85.160.172]:60774 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750795AbaBJG7E (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Feb 2014 01:59:04 -0500
Received: by mail-yk0-f172.google.com with SMTP id 200so6065317ykr.3
        for <git@vger.kernel.org>; Sun, 09 Feb 2014 22:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=ORdXevepwRFTnVvWwr3rORqRugTZkU+nN4D0X3ofmtg=;
        b=RWqTuUhMzF8nwPKGigxtWjVeTxHAOmQIT9COZgeHF4peBYLSjj+b1woYnBESDwBU3J
         x/YyxVmQtwy9rA81x7mgsVtAGjhxSH0RUF1K4eWCcVKvw9rTwlDFRtpOfcOQilXGDLhd
         bb45Yhlo6x177mAVuYmrcZovMrq2Kl4Jm7NGS85MkvC8ikwdSHPjYdF3BJYhUjpuFMI8
         2wdalwy+I3aFYA7VPcRNbcIWMlok9YXaFpMqSlCZuSJLXnG3Oys+LlvqAYKRp3+RGMMa
         LB+MQ0E66lq9qcvqwPtIoRdXINXDIZXa05FjzDLWcZmqMiG9Twc8GcoeLyjci2zs34xJ
         er/g==
X-Received: by 10.236.157.102 with SMTP id n66mr12644656yhk.41.1392015542915;
 Sun, 09 Feb 2014 22:59:02 -0800 (PST)
Received: by 10.170.189.143 with HTTP; Sun, 9 Feb 2014 22:59:02 -0800 (PST)
In-Reply-To: <1391994218-639101-8-git-send-email-sandals@crustytoothpaste.net>
X-Google-Sender-Auth: GJtrmdG6VZAYqUumO7cEKGBYz_4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241902>

On Sun, Feb 9, 2014 at 8:03 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> From: Nicolas Vigier <boklm@mars-attacks.org>
>
> There is no functionnal change. The reason for this change is to be able

s/functionnal/functional/

> to add a new option taking an optional argument.
>
> Signed-off-by: Nicolas Vigier <boklm@mars-attacks.org>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
