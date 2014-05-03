From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: BUG or FEATURE? Use of '/' in branch names
Date: Sat, 03 May 2014 09:35:25 +0200
Message-ID: <1399102525.2716.1.camel@spirit>
References: <5363D1B4.1000503@lge.com>
	 <AAC0CF0A2CCEC34CBE983015FD81C4F7392A504B61@AICEXMBXCL02.LGE.NET>
	 <20140502221617.GO9218@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Keith Derrick <keith.derrick@lge.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"simon.busch@lge.com" <simon.busch@lge.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 03 09:35:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgUTv-0004rH-4o
	for gcvg-git-2@plane.gmane.org; Sat, 03 May 2014 09:35:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbaECHfa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2014 03:35:30 -0400
Received: from mail-ee0-f45.google.com ([74.125.83.45]:64136 "EHLO
	mail-ee0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751148AbaECHf3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2014 03:35:29 -0400
Received: by mail-ee0-f45.google.com with SMTP id d17so3650328eek.18
        for <git@vger.kernel.org>; Sat, 03 May 2014 00:35:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=IG4JQxhTFTUmsbULkV3ehw9iv++sGMBxJb/pvYka1ig=;
        b=jLJAQybqENiOOR2i9ZN5NFvvMYM4kqcmLYM+ZwAW9wc2qCRaVpCyiueUCmlyMXfLFg
         gnhUbTzUmkPfqqYCEJN3jxudmax8RkhzoIkhbM8U/R6joehVo4f19d+h4BvRx95mJrs9
         5OR9uyCIOlhtFHKO98umi8J4UkgNZsP0PuvKTyalweUQzPb1/c/uyaFZvuqUbplBAMAq
         nUNXTGe1+5WdF78PwI+VhYbEPbQEYeZ2Nt2VKQxl+MRInnMnLEPGM2O9xX7C/TuIBULi
         ojrWSuqPojfwNlFbrZ9Eq5MyTH91uxMhaiu9Xcy7PSB0KBxFyH3DlJHKV4DU9bd2WOg+
         f7Lw==
X-Gm-Message-State: ALoCoQnDCMSsqnMEmkMkwhrnz7Z8hewXwV/xkNA1Nu0mLi4aIxPA3NHRHaLjh7iPQrBrvqS9uJxC
X-Received: by 10.15.42.138 with SMTP id u10mr19330541eev.7.1399102528719;
        Sat, 03 May 2014 00:35:28 -0700 (PDT)
Received: from [10.42.1.3] (82-170-157-37.ip.telfort.nl. [82.170.157.37])
        by mx.google.com with ESMTPSA id w12sm10679540eez.36.2014.05.03.00.35.26
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 03 May 2014 00:35:27 -0700 (PDT)
In-Reply-To: <20140502221617.GO9218@google.com>
X-Mailer: Evolution 3.8.4-0ubuntu1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248023>

On vr, 2014-05-02 at 15:16 -0700, Jonathan Nieder wrote:
> >     $ git checkout -b hotfix/b2
> >     error: unable to resolve reference refs/heads/hotfix/b2: Not a
> directory
> >     fatal: Failed to lock ref for update: Not a directory
> >     $
> 
> That's an ugly message.  I think we can do better. (hint hint)

2.0.0-rc2 has a better message already:

$ git checkout -b hotfix/b2
error: 'refs/heads/hotfix' exists; cannot create 'refs/heads/hotfix/b2'
fatal: Failed to lock ref for update: Not a directory


-- 
Dennis Kaarsemaker
www.kaarsemaker.net
