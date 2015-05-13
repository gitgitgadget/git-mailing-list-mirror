From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH v2] mergetools: add winmerge as a builtin tool
Date: Wed, 13 May 2015 22:37:49 +0200
Message-ID: <5553B61D.7050204@gmail.com>
References: <1431482407-63642-1-git-send-email-davvid@gmail.com>	<55534F4E.60402@gmail.com>	<3d7e3b09b89c46c39befca7564f5c1d6@www.dscho.org> <CAHGBnuPDSdCyVNM+Gagang1Cf9yw0Tyios45i6pnZSSzaJJC2Q@mail.gmail.com> <5553AD43.9010807@gmail.com> <5553B5BF.7040408@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: David Aguilar <davvid@gmail.com>, Phil Susi <phillsusi@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Philip Oakley <philipoakley@iee.org>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 13 22:38:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsdPt-0006t3-Th
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 22:38:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965263AbbEMUiF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 16:38:05 -0400
Received: from mail-wi0-f180.google.com ([209.85.212.180]:37327 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932239AbbEMUiE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2015 16:38:04 -0400
Received: by widdi4 with SMTP id di4so70287890wid.0
        for <git@vger.kernel.org>; Wed, 13 May 2015 13:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=feL6bVJRfkQLSSZtj9pdVxNK+4OsVW7y9G+AeHpg3lc=;
        b=D+UiHqutbqhSLCH7OybgtGdGOeiAfaX7zs0NcBLbBbn5/zqnXJu6MpTxaLDLi+FTcO
         uzRbwEpNbwlhTOEDsZuWaQArVUXSg3ILLHY6n4Hzhe87WHLqjajK0jtprNp/2+JmzSWN
         3hP0lGMIRvFxFx7OHwmBSA5i7adQQ5jSHSXiAmftsvSTl9uoBQPzf5EZQXF2ekm8COoy
         enJmBJc3JAe3Jmb3pRuCm95wLg/KkEQyrirOZybB8gNJJkt4mMth474crGoAkEPiPHgB
         XStG1fC400Bh2Gil7KjJz32fzwpW/e8+Tm6X6aJk7ool9rfN6T5mAzCVd4FgGLesnMui
         AFZA==
X-Received: by 10.194.81.169 with SMTP id b9mr1315735wjy.126.1431549483555;
        Wed, 13 May 2015 13:38:03 -0700 (PDT)
Received: from [192.168.188.20] (p4FF45E49.dip0.t-ipconnect.de. [79.244.94.73])
        by mx.google.com with ESMTPSA id u9sm34672971wjx.15.2015.05.13.13.38.02
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 May 2015 13:38:02 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <5553B5BF.7040408@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269008>

On 13.05.2015 22:36, Sebastian Schuberth wrote:

> for directory in "$(env | grep -E '^PROGRAM(FILES(\(X86\))?|W6432)=' | cut -d '=' -f 2 | sort -u)"

Sorry, that should have been "grep -Ei" in there.

-- 
Sebastian Schuberth
