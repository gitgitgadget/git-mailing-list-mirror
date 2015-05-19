From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Git Server Repository Security?
Date: Tue, 19 May 2015 06:11:44 +0530
Message-ID: <555A86C8.2020006@gmail.com>
References: <CABQ4iYiWu17H1XhPYebmP27x=R11SKW0P91AW2y9S=r-2c0B1A@mail.gmail.com>	<20150518102633.GA15186@book.hvoigt.net> <CABQ4iYgjtdw46Psow_e7uGLqx0ZiFt+TQOgXvCmP1-W10LGEmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: John McIntyre <joh98.mac@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue May 19 02:41:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuVbZ-0002Vy-Mo
	for gcvg-git-2@plane.gmane.org; Tue, 19 May 2015 02:41:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751706AbbESAlu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 20:41:50 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:34384 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751223AbbESAlt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 20:41:49 -0400
Received: by pabru16 with SMTP id ru16so173555666pab.1
        for <git@vger.kernel.org>; Mon, 18 May 2015 17:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=SNJv2MO2B0vMElzMzzHptwc4yIWyBhJ69/qdG7jBV4k=;
        b=K1JWOZAFUwcoeKdGJn/OzYfprZHXjTtUN3X+8G6OSK4dTXkCPY5tSUGuKBLXzgW7mR
         U6mxZU7bXuCdRwGxFXdNloReGqNUBRaGhuvZDPJqvMaKKk+/L9kjaVk30DpNZyVlmBbU
         Q/RbFNWACwdGbFAhaPZ5+f4rBSNHLWSjH4+vKmFxWMq7cdlupR1VkuEYgch7NeKguitm
         dpuWnRWKqHk7APL0pL0otazDr5cRu+B9bKrP9E6EQYSoXbG9j3Vp1SuMalAr51IGo6pe
         DzGhdRnBVSl122B+O6+PLaxhkCfSLfBYEEJ4h4MEP+xYZWvE5ibMDpBKmRjtQpwbXiAs
         CGvA==
X-Received: by 10.68.98.65 with SMTP id eg1mr48497474pbb.72.1431996108748;
        Mon, 18 May 2015 17:41:48 -0700 (PDT)
Received: from sita-lt.atc.tcs.com ([117.195.171.56])
        by mx.google.com with ESMTPSA id om4sm11188731pdb.68.2015.05.18.17.41.46
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 May 2015 17:41:48 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <CABQ4iYgjtdw46Psow_e7uGLqx0ZiFt+TQOgXvCmP1-W10LGEmg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269335>

On 05/18/2015 04:28 PM, John McIntyre wrote:
> 2015-05-18 11:26 GMT+01:00 Heiko Voigt <hvoigt@hvoigt.net>:

>> If you want a simple tool using ssh-keys have a look at gitolite[1].
>> It quite simple to setup and with it you can specify all kinds of access
>> rights.
> 
> That's adding a separate level of complexity.
> 
> I looked into filesystem-level permissions.  I don't see any means of
> doing so, because everyone accesses the repositories using the 'git'
> user.  So even if I add a group like 'devClient1' and then change the
> group ownership of a repo to that user, they'll still be able to
> access all repos..?

My usual answer to this is http://gitolite.com/gitolite/overview.html#basic-use-case

The first example is doable with file system permissions if you give
everyone a separate userid, but it's a nightmare.  The second one is not
even possible.
