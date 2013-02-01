From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] gitk-git/.gitignore: add rule for gitk-wish
Date: Fri, 1 Feb 2013 15:52:10 -0800
Message-ID: <20130201235209.GK12368@google.com>
References: <1359456750-29342-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Paul Mackerras <paulus@samba.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 02 00:52:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1QPW-0003sq-Sj
	for gcvg-git-2@plane.gmane.org; Sat, 02 Feb 2013 00:52:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757027Ab3BAXwP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2013 18:52:15 -0500
Received: from mail-pa0-f54.google.com ([209.85.220.54]:36287 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755464Ab3BAXwP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2013 18:52:15 -0500
Received: by mail-pa0-f54.google.com with SMTP id fa10so826121pad.27
        for <git@vger.kernel.org>; Fri, 01 Feb 2013 15:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=RIJCALW/FcI4fEglbqI4OKLbgxoOnIkEMBMWYhQQKAg=;
        b=iEcqlUIKi025zTIjS7N+g6JQfjfbctNTB3CSpw1Z/s/2TVAvlDXfvZIvoArBN/CWEj
         oCT92r5kzHTDwmuST3UfxgT9s2UwJ5EANT3GbOyHdV0QTaAxgQqEexQDbToKaXOx7HmA
         M3RGJ7VbbxSmGu5MOQX7Kkv+XIwJ0X54f69sfR8fG9tP+WVBd6iO5xu7k/G29dPR0M6B
         eiXfNLw+HgR6QCOvG3pmwD5JoE2Oj7rtz3k9RnvflUF8rLkwi6kbCv9pkgAkkI+KSBPi
         bx5TuQ+dcc9KCc0BbKJW+D9LKNCouu/2vOUs788dhYWeZFsPHeJJlyyBr4otBD69Qzd2
         JT1A==
X-Received: by 10.66.82.200 with SMTP id k8mr34256396pay.56.1359762734474;
        Fri, 01 Feb 2013 15:52:14 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id a1sm10578112pav.2.2013.02.01.15.52.12
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 01 Feb 2013 15:52:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1359456750-29342-1-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215279>

Hi Ram,

Ramkumar Ramachandra wrote:

> 8f26aa4 (Makefile: remove tracking of TCLTK_PATH, 2012-12-18) removed
> "/gitk-git/gitk-wish" from the toplevel .gitignore, with the intent of
> moving it to gitk-git/.gitignore in a later patch.  This was never
> realized.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  Minor patch, so I didn't bother sending it through Paul.

All gitk patches go through Paul's repo.  I keep forgetting the
address, so I look it up each time.

	$ git log -1 --oneline gitk-git/
	9a6c84e Merge git://ozlabs.org/~paulus/gitk

Looks like this was fixed in the week since last pull.

	http://thread.gmane.org/gmane.comp.version-control.git/214312

Paul, would it be safe for Junio to pull again?

Thanks,
Jonathan
