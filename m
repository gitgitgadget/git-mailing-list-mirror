From: =?UTF-8?Q?Jean-No=c3=abl_Avila?= <avila.jn@gmail.com>
Subject: Re: [BUG] can not escape sharps in git config file
Date: Tue, 24 May 2016 12:25:46 +0200
Message-ID: <57442C2A.3010202@gmail.com>
References: <57442992.6030306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 24 12:26:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b59XV-0001m6-M6
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 12:26:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755718AbcEXK0N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 May 2016 06:26:13 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:35687 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754760AbcEXK0L (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 06:26:11 -0400
Received: by mail-wm0-f43.google.com with SMTP id a136so65681908wme.0
        for <git@vger.kernel.org>; Tue, 24 May 2016 03:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=lkAeYKkMZ4c3z5xbVaVUsNJkXYKFhOO1NkEqK3r2bus=;
        b=MCfS5uJsmP4yQfeKhfwCdAT0SZ6puOYI/RDsn0KNwBeVvn3JzJ/NyBif1qn4rFqzn8
         pKw8f0fuuFWzzoftBhX5ZoZIx933baqnVOvX+s8NzHRKY/vihdKZaPX/2QbJT9GtqFmm
         Ix8OyvjOaetM5CRsHWRO523HbmUFohRH1RNLh9ayhke8VRNKOmGfy7Yoe7a6tGj24H+m
         R9nfFhfFejaxIVX+E5sC7cgYwgvT8i16H0HvKdlGl19+zJif+fynGjEJiTFw0/0t5Gar
         0F5QKYJDEAPS8HrnLzQt16d6xPQ4oydFHc8SNORmouUjgY8b8BWSLT/Cj6j7Z4kbg6K7
         e1oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=lkAeYKkMZ4c3z5xbVaVUsNJkXYKFhOO1NkEqK3r2bus=;
        b=I2fuXqDxqf+A+0iyJ3tGBPGelhdF4jojcp6sZni5hV3VPs7CqzrZRk7BOlgcz6LfIB
         lo+3GLyCZFGm2JYLG4K9ah3PTfz915IgafbxwKxVgqGD2n4wcVyETO8a0HkcnjxSbrBh
         FXliLCUrWMzShD59Zx5WLF5o8DB9NOJs7CGHVWb75sDl5JnjTjVevqjlbKTU3CpmvEKD
         M5bAIeWMmGYPpeHrmgzyQME/uJsvayIvePS8Nmew2ND/C/KEWdCxevxvd/DF+ac9Pe2f
         VuIJJMn9cKfVvqiYC7xob2Wh+IfiGXjuMfi9Znd6Rt1gttmMousIC3ghYo4D4dJAe/gS
         e4OA==
X-Gm-Message-State: ALyK8tICDiiz4cnQj8LIplGxEUvBdyCASl45rQT8/2CEWP4Xdx7vu4OwZUkIBbj9+1/yQw==
X-Received: by 10.194.243.231 with SMTP id xb7mr3433700wjc.33.1464085547745;
        Tue, 24 May 2016 03:25:47 -0700 (PDT)
Received: from [192.168.1.75] (static-csq-cds-097114.business.bouyguestelecom.com. [164.177.97.114])
        by smtp.googlemail.com with ESMTPSA id r5sm2393623wjy.37.2016.05.24.03.25.46
        for <git@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 24 May 2016 03:25:46 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
In-Reply-To: <57442992.6030306@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295483>

=46orgot to add:

=C2=B1 git --version
git version 2.8.3
