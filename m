From: =?GB2312?B?0Oy1zw==?= <xudifsd@gmail.com>
Subject: Re: Manually decoding a git object
Date: Mon, 20 Feb 2012 12:45:46 +0800
Message-ID: <CAMocUqRNNXpGOJ2ZG8bWpkieKkVfoo0=Lkevjw+E3Tssw68Hwg@mail.gmail.com>
References: <1329312140-24089-1-git-send-email-pclouds@gmail.com>
	<1329624946-32173-1-git-send-email-pclouds@gmail.com>
	<A716A27D407F401DAAC373027D5CFF2A@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Mon Feb 20 05:45:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzL8K-0005fi-U0
	for gcvg-git-2@plane.gmane.org; Mon, 20 Feb 2012 05:45:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751893Ab2BTEps (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Feb 2012 23:45:48 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:60810 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751412Ab2BTEps (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Feb 2012 23:45:48 -0500
Received: by bkcjm19 with SMTP id jm19so4246582bkc.19
        for <git@vger.kernel.org>; Sun, 19 Feb 2012 20:45:46 -0800 (PST)
Received-SPF: pass (google.com: domain of xudifsd@gmail.com designates 10.205.139.71 as permitted sender) client-ip=10.205.139.71;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of xudifsd@gmail.com designates 10.205.139.71 as permitted sender) smtp.mail=xudifsd@gmail.com; dkim=pass header.i=xudifsd@gmail.com
Received: from mr.google.com ([10.205.139.71])
        by 10.205.139.71 with SMTP id iv7mr9959118bkc.67.1329713146779 (num_hops = 1);
        Sun, 19 Feb 2012 20:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=7IEwegrVLir02uBqxIk1DXhTGebdaSG/268mlUG7mtQ=;
        b=BEDXWXs/IPLziri+Os14ip1zFQL+8zP2Mz1yo5Lclzas1eM0W/XuY6YFajDNPy4J9z
         cB7EXwm2BwhbyFrMPwsAtC8qEM46vP1OJslLguAloCP/6Pl59p7gV2swUkbYmuOIRWrR
         sJBDPpeN9uqJWtOotGY7rff5YN1NYXdS8Rnoo=
Received: by 10.205.139.71 with SMTP id iv7mr8035144bkc.67.1329713146696; Sun,
 19 Feb 2012 20:45:46 -0800 (PST)
Received: by 10.204.64.69 with HTTP; Sun, 19 Feb 2012 20:45:46 -0800 (PST)
In-Reply-To: <A716A27D407F401DAAC373027D5CFF2A@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191044>

2012/2/20 Philip Oakley <philipoakley@iee.org>:
> If I have a renamed file which is a git object, such a "Git_Object", was
> 8c-something-or-other, what is the easiest way of examining / decoding /
> recreating the original file (either as its sha1, or a cat-file).
>
I don't think I fully understood what you mean, I assume you just move
an object file from $GIT_DIR/objects/ to somewhere and rename it,
let's call it "obj", so if you want to exam its content you can just
simply call "git cat-file -p obj". And you can also use "git cat-file
-t obj" to exam its object type. If it's a blob you can use "git
cat-file -p obj > original" to recreate it, else it's meaningless to
recreate it.
