From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 0/2] bisect--helper: rewrite of check_term_format()
Date: Wed, 4 May 2016 07:22:06 +0200
Message-ID: <CAP8UFD1k4N_qeVYrbJhetKX75ynLSSvQogccR9=nQSR6XwTRVQ@mail.gmail.com>
References: <01020153a254974b-68f7d16a-66d7-4dc1-805d-2185ff1b3ebf-000000@eu-west-1.amazonses.com>
	<1462338472-3581-1-git-send-email-pranit.bauva@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Lars Schneider <larsxschneider@gmail.com>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 04 07:22:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axpGU-0002Xi-VG
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 07:22:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbcEDFWJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 01:22:09 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:36529 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750947AbcEDFWI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 01:22:08 -0400
Received: by mail-wm0-f52.google.com with SMTP id n129so172474323wmn.1
        for <git@vger.kernel.org>; Tue, 03 May 2016 22:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=N6dBLM3LpkUG50k/NRvpiWq40fDuFYuIJthgSyGzCaI=;
        b=mo5K64DsMIR9uxw4ApQkC+gaGz/15pKkaoBL0r8cxxiofOPB94YNdNCLsq2tCWMA89
         Dzk8YSdNM9gkVxZfPSDYDkK3mGo0RI8iZ6jjbYRCxqdv5dSHn/3W92cA7Ix7YbEZXdjm
         NcKMXHkYLh5pmQFyoi9/ewTd5OZFev3pNGCuaQfpJ+obDObITos+ZUGReoU2QXUkyLYM
         tUMI52eZyErlkc0tjsP40jceEpXuJYBHcMjhHpI8PQzeOxelZwBU3GWW/PqjTQnd2zwi
         mLqT5eL6Rz/FNwf5oo3J6zVSM8+wFnCeGVG85Wb2YDBECbG+98rAV1BpaWuMvWO6C+nn
         gaAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=N6dBLM3LpkUG50k/NRvpiWq40fDuFYuIJthgSyGzCaI=;
        b=OW+j7kufqwIiYCg22h0yhgfoBI315Zg1W47VRlqaOq/6c1ZWVVBhsCfDJZOXpPaiy4
         +slUJzEUL3lo9JT3BwZ6D5FJi/M4bT6I4XtOlLLm1wL+mzOJujQKxUb5exPS7vXIqCHA
         LjUgylizVEsWZ84hTdrSAufIfl3PJWt8TD2Jtujx4xvfX4fYqlenE3HuFXJa5O8sNFOE
         iWeKn2HYi+16qZ4rzpQ2Y3ZURu9nx1jq/RBwaxxvi4bZXlw0HIVoks2/haaDxeKvYtr4
         jlaW/VMyAMW3Q6mr4yYJ3Hu+xGxXp/OVdL1K1LUkzXfhXGQF0i7iBkxZdXeY4JmclPsV
         na5Q==
X-Gm-Message-State: AOPr4FVnXsR6FHoFgKKBiQJQUgezXQYLt5GevEC8yao+EW6P9AJjiJTE6l9V8XKdbtZDcl8TUIH9qhjFX/k2+g==
X-Received: by 10.28.169.11 with SMTP id s11mr29836290wme.62.1462339326731;
 Tue, 03 May 2016 22:22:06 -0700 (PDT)
Received: by 10.194.246.4 with HTTP; Tue, 3 May 2016 22:22:06 -0700 (PDT)
In-Reply-To: <1462338472-3581-1-git-send-email-pranit.bauva@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293490>

Pranit,

My gmail address is "christian.couder@gmail.com", not
"christain.couder@gmail.com". ('i' and 'a' are in the wrong oder in my
first name).

Thanks,
Christian.
