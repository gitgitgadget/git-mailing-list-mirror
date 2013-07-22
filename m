From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH v7 3/4] tests: add new test for the url_normalize function
Date: Mon, 22 Jul 2013 03:29:44 -0700
Message-ID: <35487727-EA84-414D-A7C3-D3C546CF1BEE@gmail.com>
References: <f1109cf05979890ea9441fae7881586@f74d39fa044aa309eaea14b9f57fe79> <185ed81d5965642db680fa361ee07ce@f74d39fa044aa309eaea14b9f57fe79> <7v61w3qei5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Petr Baudis <pasky@ucw.cz>,
	Richard Hartmann <richih.mailinglist@gmail.com>,
	Jeff King <peff@peff.net>,
	Daniel Knittl-Frank <knittl89@googlemail.com>,
	=?ISO-8859-1?Q?Jan_Kr=FCger?= <jk@jk.gs>,
	Alejandro Mery <amery@geeks.cl>,
	Aaron Schrab <aaron@schrab.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 22 12:29:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1DNK-0007Ya-BV
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jul 2013 12:29:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757174Ab3GVK3t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jul 2013 06:29:49 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:41263 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756799Ab3GVK3s (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jul 2013 06:29:48 -0400
Received: by mail-pa0-f53.google.com with SMTP id lb1so99635pab.40
        for <git@vger.kernel.org>; Mon, 22 Jul 2013 03:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc:x-mauler;
        bh=3HKuVCLdDDWdE5WVvY6dZqZ5kKQKlite5L663Uzc/X0=;
        b=GH/VxcDSgffvGdgdBwYDP4wLZQvVygmSdvxSEHe5p4FvDZd/Vf6WfyiwAX/T2YF4vR
         Pt/rDqyFm23kUNiIkNMzyjIcvm35wlwgMeJqXfUpX15t/MdJ3tQ51AO+IynbhpXDdvFf
         mbVsLj+iwl1YQ72OPKgLliNLSrCu4tSKFxddYy6ZTOPtrUkaj3oEPoHmEWw5Pjdh42Ek
         y136SS8mbKjycfxrNL1s9Io7zohb1MJAyR3uebpFrPksvCspKVFcN0TxvMIew0m7zGPC
         RQRR+CHVarB5IjfyOVKKb7q3ENoUu262nlUBUmUxSEgrUZZDXmfBH8vpDe8RNpiXhF+t
         xPVA==
X-Received: by 10.68.200.104 with SMTP id jr8mr30160576pbc.43.1374488988207;
        Mon, 22 Jul 2013 03:29:48 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id py6sm35048045pbb.33.2013.07.22.03.29.45
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 22 Jul 2013 03:29:47 -0700 (PDT)
In-Reply-To: <7v61w3qei5.fsf@alter.siamese.dyndns.org>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230970>

I was able to apply the patch I got back.  It was marked as  
charset=ISO-8859-1 so it should be fine.

I wasn't sure how best to handle those though, so I will send a new  
version with the suggested .gitattributes patch included as well.

On Jul 21, 2013, at 23:45, Junio C Hamano wrote:
> I suspect that files under t/t5200/ were not suiable for e-mail
> transmission.  Can you regenerate this after running:
>
>    $ echo '/t/t5200/* binary' >>.git/info/attributes
>
> or better yet with:
>
> diff --git a/t/.gitattributes b/t/.gitattributes
> index 1b97c54..6240ed2 100644
> --- a/t/.gitattributes
> +++ b/t/.gitattributes
> @@ -1 +1,2 @@
> t[0-9][0-9][0-9][0-9]/* -whitespace
> +t5200/* binary
