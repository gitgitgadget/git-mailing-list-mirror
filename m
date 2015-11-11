From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Allow git alias to override existing Git commands
Date: Wed, 11 Nov 2015 16:15:14 +0530
Message-ID: <56431C3A.6060308@gmail.com>
References: <56421BD9.5060501@game-point.net>
 <CAGZ79kZxQWVMe3N1ti8npyp9_4DUPAVy9Uk5a75Jwh3Eud2eZQ@mail.gmail.com>
 <56424DDE.2030808@game-point.net> <5642C8BA.8030003@gmail.com>
 <56430A27.2030604@game-point.net> <56430F9F.7060900@gmail.com>
 <56431499.9010708@game-point.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeremy Morton <admin@game-point.net>
X-From: git-owner@vger.kernel.org Wed Nov 11 11:45:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZwSu6-0002JR-Mk
	for gcvg-git-2@plane.gmane.org; Wed, 11 Nov 2015 11:45:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751885AbbKKKpW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2015 05:45:22 -0500
Received: from mail-pa0-f44.google.com ([209.85.220.44]:36031 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751059AbbKKKpV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2015 05:45:21 -0500
Received: by pacdm15 with SMTP id dm15so28104600pac.3
        for <git@vger.kernel.org>; Wed, 11 Nov 2015 02:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=+qpMZfYkBJwR1uWxBg1iojmR02QZ9w2tl3mMxLy7RIw=;
        b=bMi2j/5j2oeOw/cCIlVD6NLlyJBPJFFVoIM+bEQK1kmCn14asEc6btQSSXoXED9rKO
         NQMYLj/3CG5IY2g0eTUgnkoTkgDvSl2kWXQmWWB/1KGMViN+pNePxw7TfXkJH0Bl4ZO7
         LiHzdnm8/ul1kX5BNtawKjLgt+Kziff5NRhYG87mGR3gFbr2qn+jZizQoKZYF5raxSeR
         yAptJlsihH0aQxz0xqjbKJcxFLR7f7AMTVBNTYzTnjnruThTr/+QkyseM5l3ScCNgmXa
         qKYrDbftMon9n8rVR6kyeKCaGmLkttlkIMwwH4Dm6DcIlG5AqSgn54+waGTpK/ahKLCz
         ynaQ==
X-Received: by 10.66.160.194 with SMTP id xm2mr13521014pab.68.1447238721202;
        Wed, 11 Nov 2015 02:45:21 -0800 (PST)
Received: from sita-lt.atc.tcs.com ([117.195.175.90])
        by smtp.googlemail.com with ESMTPSA id yh3sm8812503pbb.82.2015.11.11.02.45.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 11 Nov 2015 02:45:19 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <56431499.9010708@game-point.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281159>

On 11/11/15 15:42, Jeremy Morton wrote:
> On 11/11/2015 09:51, Sitaram Chamarty wrote:
>> I can only repeat what I said before: it's not all black and white.
>>
>> Reducing the opportunity to make mistakes is useful for everyone, even
>> expetrs.  Especially stuff that you may have setup aeons ago and hits
>> you only aeons later when something (supposedly unrelated) somewhere
>> else changes and you didn't remember and you tear your hair out.
> 
> Not when it reduces useful functionality for experts, it's not.

Speaking of... did you try the script I sent in an earlier mail?

Putting it in /usr/local/bin (on Fedora.  YMMV) seems to work fine,
since that appears earlier than /bin where the real git lives.
