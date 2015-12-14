From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: Where does http.sslcainfo get set in Windows (2.6.3)?
Date: Mon, 14 Dec 2015 17:27:21 +0100
Message-ID: <74D611CB-89C3-4A5B-A405-1089EB30FB32@gmail.com>
References: <1450107945.1012555.467004601.1D76923E@webmail.messagingengine.com>
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Titus Barik <titus@barik.net>
X-From: git-owner@vger.kernel.org Mon Dec 14 17:34:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8W54-0004eP-TI
	for gcvg-git-2@plane.gmane.org; Mon, 14 Dec 2015 17:34:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752818AbbLNQe1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 11:34:27 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:34050 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752414AbbLNQeZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2015 11:34:25 -0500
Received: by mail-wm0-f45.google.com with SMTP id p66so70440244wmp.1
        for <git@vger.kernel.org>; Mon, 14 Dec 2015 08:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=9pu/PXkkqGVwhYqSyPfF/Gqpf7EwSldXj62MEiXPzD8=;
        b=ItWbNhjlUphw6FHmdYaka0CpEcdT10nt5/LU7Iedb55UrbxdxoWDqzw0DOkvtgIuf4
         xeTu7xgFpAR4zKKRat1Fu6bFpjjSDw5K1LNgL1SC0w+40YSiHJiHMcGqTt9ze6JPo4n1
         U0mWCtnXZiq8fBNCXl+xVJTwUmzKCZqBgUNwovwQSen9O2n6MyW0LV2GdgX63+oRQNKs
         9qNaoRtqs+hWlWI+pwPvlSWNAMYIUVp84aTtxmnXeOvmZFYdq9GvEaSr6FidegT8M0Ro
         nEbtpTLswy9CF9XqE8ursEhZsQW9oOpPi8rZmt1Yu1nJzHX1+yhttE8tNimFsYqz1ZR9
         R9wA==
X-Received: by 10.28.223.212 with SMTP id w203mr26848529wmg.88.1450110442933;
        Mon, 14 Dec 2015 08:27:22 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id bh6sm30552226wjb.0.2015.12.14.08.27.21
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 14 Dec 2015 08:27:22 -0800 (PST)
In-Reply-To: <1450107945.1012555.467004601.1D76923E@webmail.messagingengine.com>
X-Mailer: Apple Mail (2.3096.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282370>

Hi Titus,

try to look here:
C:\Users\All Users\Git\config

(that's where I found it... maybe different on your end).

Cheers,
Lars

> On 14 Dec 2015, at 16:45, Titus Barik <titus@barik.net> wrote:
> 
> Hi all,
> 
> I'm in Windows using git version: git version 2.6.3.windows.1. Git is
> installed to /c/Users/tbarik/AppData/Local/Programs/Git/cmd/git.
> 
> However, when I look for the config name http.sslcainfo, it returns:
> 
> $ git config --get-all http.sslcainfo
> C:/Program Files/Git/mingw64/ssl/certs/ca-bundle.crt
> 
> Although I can override the name, I'm trying to figure out where this is
> being set, since the correct location should be (in this case)
> C:/Users/tbarik/AppData/Local/Programs/Git/mingw64/ssl/certs/ca-bundle.crt.
> 
> I don't see C:/Program Files/Git/mingw64/ssl/certs/ca-bundle.crt in
> either --global, --system, or --local, hence my confusion as to where
> this path is coming from.
> 
> Thanks,
> 
> Titus
> 
> -- 
> Titus Barik, PE <titus@barik.net>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
