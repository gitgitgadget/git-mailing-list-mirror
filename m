From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/9] icase match on non-ascii
Date: Wed, 8 Jul 2015 08:36:02 -0700
Message-ID: <CAPc5daWG7=tBm_G+G6Qkmd7bd=5Dd-8bimj1p+KW_FSTOFfRaw@mail.gmail.com>
References: <1436186551-32544-1-git-send-email-pclouds@gmail.com> <1436351919-2520-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Plamen Totev <plamen.totev@abv.bg>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 08 17:36:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCrOd-0006Pl-Uj
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 17:36:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758104AbbGHPgX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2015 11:36:23 -0400
Received: from mail-oi0-f47.google.com ([209.85.218.47]:36133 "EHLO
	mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757370AbbGHPgW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2015 11:36:22 -0400
Received: by oibp128 with SMTP id p128so7280463oib.3
        for <git@vger.kernel.org>; Wed, 08 Jul 2015 08:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=yB8VeUX/Y9gud/0tdZQSu0I0A2JIYO9bbKbFvWMvCtg=;
        b=Er2o0t8ph4yo6e+r0Y5EmU7g8FCnYGXjePiPIu+vCAQWHL0PoTUDRT8LLTHyIGDrIk
         +Bn/NVUwpQaCaVF9sF/Uo7gRzZqkxD/QlzPNcoYvRSBJUfC8Yo0ldTv5dNtH2Q1eaRiq
         vx2EADs1711KYZgXp4bg3ptbuIQlaAWr4qDtwZerpA+g2COgGFqt7nA+pWN3b4aFZfA2
         dJEMGh3NbVdk0iXvrJBVOxrgP/OHE1JlcMWvQDj7bORkfe6s7oY1MyGBDBV/u4y8ChJe
         WslugYABrdaW1jr1gW8bhuE3EPAz5WAzhaX20+fYMRBCIPk85dyCCQSAn3P5TF0newPl
         02pA==
X-Received: by 10.60.155.97 with SMTP id vv1mr10750515oeb.15.1436369781852;
 Wed, 08 Jul 2015 08:36:21 -0700 (PDT)
Received: by 10.202.202.129 with HTTP; Wed, 8 Jul 2015 08:36:02 -0700 (PDT)
In-Reply-To: <1436351919-2520-1-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: hMGsW4bXZNs-6UI6Tz-YVbSZG4Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273689>

> Patch 5 is "funny". The patch itself is in iso-8859-1, but my name in
> the commit message is in utf-8.

As an e-mail message is a single file, by definition that is not merely
"funny" but just "broken", no matter what encoding your MUA
declares the contents are in, no?
