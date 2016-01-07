From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/10] use the $( ... ) construct for command substitution
Date: Thu, 7 Jan 2016 14:00:53 -0800
Message-ID: <CAPc5daW3U6qWCPJHPRf-Zuf8xH4xOJME1Axa+4DYq1yCBnAyWQ@mail.gmail.com>
References: <1452174710-28188-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 07 23:01:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHIcP-0006wQ-Ts
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jan 2016 23:01:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753367AbcAGWBO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2016 17:01:14 -0500
Received: from mail-io0-f172.google.com ([209.85.223.172]:36733 "EHLO
	mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753194AbcAGWBN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2016 17:01:13 -0500
Received: by mail-io0-f172.google.com with SMTP id g73so69931287ioe.3
        for <git@vger.kernel.org>; Thu, 07 Jan 2016 14:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=qV1nTjA5zp6eDT3EjUbL1hWSkV5Ks4Hi1IxAUdR3PIE=;
        b=x9IVjtPYjQYgeC0FxbHsY9YdpSzHWH2efUp2zcFAuzjTfFt+uBNxpwetwVYniVxKqk
         3xJBtUNMckEOgIkrlW2JkgDSXfPaLSZTPEfFzBxP4N2vWrUQCGcOMOsYzGwLN2PiHYKU
         eK3l/2JMrqcf4aPh86DPO0Ia4xbXbGTFKBTdKu72HUDGEcPkKFLOlAGU9uzYqBwYMsMZ
         Fat35ka+HbwHNz8LHzCMTCF55SdHgtjVhl83mVyS2/ViStTixK9BPiPtDkw2jkSNLSb8
         kyi3GUCYeBpE5xioh8uuPkhG6FDwlf3nfWja+koVkqBsRn7oxYuJQsxKopgciYYSv7xV
         zU9A==
X-Received: by 10.107.170.212 with SMTP id g81mr82352484ioj.44.1452204072544;
 Thu, 07 Jan 2016 14:01:12 -0800 (PST)
Received: by 10.36.52.137 with HTTP; Thu, 7 Jan 2016 14:00:53 -0800 (PST)
In-Reply-To: <1452174710-28188-1-git-send-email-gitter.spiros@gmail.com>
X-Google-Sender-Auth: _f1-FGiRdK2tnus_CYhZov0WkZ8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283512>

All looked trivially correct. Thanks, will queue.
