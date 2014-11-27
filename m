From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Where is the best place to report a security vulnerability in
 git?
Date: Thu, 27 Nov 2014 09:02:08 +0530
Message-ID: <54769B38.30708@gmail.com>
References: <175a570ee03dba2828cb7e129c9445c9@davenport.net.nz> <20141127012053.GU6527@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>,
	Hugh Davenport <hugh@davenport.net.nz>
X-From: git-owner@vger.kernel.org Thu Nov 27 04:32:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xtpod-0000wT-1J
	for gcvg-git-2@plane.gmane.org; Thu, 27 Nov 2014 04:32:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753915AbaK0DcT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2014 22:32:19 -0500
Received: from mail-pd0-f169.google.com ([209.85.192.169]:42904 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753889AbaK0DcS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2014 22:32:18 -0500
Received: by mail-pd0-f169.google.com with SMTP id fp1so3997776pdb.14
        for <git@vger.kernel.org>; Wed, 26 Nov 2014 19:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=fo0EPikAa2q7PJbSz4QTMlY31W5322psobawWGesco4=;
        b=IuN3I8v9K3ljhCOuRoAgEWqgEqkc2RnMJBe6Z+lUlY5YkK8EbfJhYIyWDaH8iU28B4
         RKg8HGrGfX/jTjjMbbPTGTo1PdWFXfVIni6zbKXW0Wuz37DUZYsX5VJFG/TW6nYvaQga
         mPl+5aR0AUdulhBEpXJP/iSKOY6XTFu20zUmiuHsRbtV5hb0kLr3se1fpHajy2biR5Yv
         sHrgtjLaOgF4r3IstqAy0/kYyWe86z/EirnZxpHqUzEGqwVwHKi0S2gG0eSSSflEAw4b
         3p3OrfVP3cd0CCVfBLsftJHM94YjukDyf5Czn5h+vcrPR/MWJP40ETbVVZZg3lpv2gnt
         SNwA==
X-Received: by 10.67.13.38 with SMTP id ev6mr43317091pad.25.1417059137908;
        Wed, 26 Nov 2014 19:32:17 -0800 (PST)
Received: from sita-lt.atc.tcs.com (atcmail.atc.tcs.com. [203.200.212.145])
        by mx.google.com with ESMTPSA id pj5sm5593185pdb.65.2014.11.26.19.32.15
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Nov 2014 19:32:16 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <20141127012053.GU6527@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260331>

On 11/27/2014 06:50 AM, Jonathan Nieder wrote:
> Hi Hugh,
> 
> Hugh Davenport wrote:
> 
>> Where is the best place to report a security vulnerability in git?
> 
> Current practice is to contact Junio C Hamano <gitster@pobox.com>.
> Cc-ing Jeff King <peff@peff.net> isn't a bad idea while at it.
> 
> We should probably set up a mailing list to make this more obvious,
> but that's what we have today.

Hi Hugh,

I maintain a somewhat widely used access control program for remote
access to git, so I'm interested also.

Gitolite [1] and similar systems provide access control for git repos.
There's a very good chance that something which is not a concern for
"local" use, could become an attack vector if enabled through gitolite.

Hence my interest, and my request that I be copied.

Jonathan/Junio/Jeff: if such a mailing list does happen please consider
adding me into it.

regards
sitaram

[1]: https://gitolite.com
