From: Lance Fredrickson <lancethepants@gmail.com>
Subject: Re: bug report: build issue with git 2.2.2 using uclibc toolchain
Date: Fri, 30 Jan 2015 09:30:27 -0700
Message-ID: <54CBB1A3.9000805@gmail.com>
References: <54CBA968.2040807@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 30 17:30:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YHET7-0000YV-Iq
	for gcvg-git-2@plane.gmane.org; Fri, 30 Jan 2015 17:30:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932767AbbA3Qag (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2015 11:30:36 -0500
Received: from mail-pa0-f47.google.com ([209.85.220.47]:54074 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932604AbbA3Qac (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2015 11:30:32 -0500
Received: by mail-pa0-f47.google.com with SMTP id lj1so54089255pab.6
        for <git@vger.kernel.org>; Fri, 30 Jan 2015 08:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=hFLPqpSORPqx4Y5PxRlYJ6otTOdxa+NBtqxghQw0028=;
        b=jUeWDeVRdbH8nkuMudQpNKsew41czOQRlOKmgxhBx/SvCNRGCjqgsuG/6jEgy1b2sb
         aaoZfQd5C5UG7Rjj+TOb4L5peEAWWjVehyF/YK6hrF6kwFVgtL/ZGZxqW+Xw0i8j/SSp
         LPy4JhL3Q37LBDV4XYxvuRdPDozPJtEBdoriU6JcHIKFP8PLCtc1KLfaTtmlUEfIJWP6
         h7VKu31DE2tpm1xBvWCiKLi2q08BRVoz5SlC9X2+7HJVyh1ofVG0WmUeP1Guye35TA1t
         bEBJNAjl/rxj3GHYDkAYjjeNEe1SF1ntiJhm6hcl0MnuBPMUOQ5LGUK+5jH9LmP7YXnv
         lsBQ==
X-Received: by 10.70.42.208 with SMTP id q16mr10201817pdl.56.1422635431604;
        Fri, 30 Jan 2015 08:30:31 -0800 (PST)
Received: from [10.0.0.155] ([70.103.142.130])
        by mx.google.com with ESMTPSA id ex1sm11204135pbc.80.2015.01.30.08.30.30
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Jan 2015 08:30:30 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <54CBA968.2040807@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263182>

Sorry, file this one away under user error. I had an issue with my build 
environment.
cheers!

On 1/30/2015 8:55 AM, Lance Fredrickson wrote:
> I've been keeping up-to-date versions of git built for an embedded 
> mipsel architecture device running on uclibc.
> 2.2.1 and previous versions build fine, but 2.2.2 stops with an error.
>
> The toolchain is an OpenWRT variant (entware) using gcc 4.6.4 and 
> uclibc 0.9.32, available at the following.
> http://entware.wl500g.info/sources/
>
> Here is the output of the build error.
>
> CC builtin/grep.o
> builtin/get-tar-commit-id.c: In function 'cmd_get_tar_commit_id':
> builtin/get-tar-commit-id.c:31:12: error: dereferencing pointer to 
> incomplete type
