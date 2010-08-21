From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [BUG] log: Non-zero exit code?
Date: Sat, 21 Aug 2010 12:01:18 +0530
Message-ID: <20100821063116.GK6211@kytes>
References: <20100821062158.GJ6211@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 21 08:33:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Omhdm-0004h3-9H
	for gcvg-git-2@lo.gmane.org; Sat, 21 Aug 2010 08:33:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407Ab0HUGdN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Aug 2010 02:33:13 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:41420 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751242Ab0HUGdM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Aug 2010 02:33:12 -0400
Received: by pzk26 with SMTP id 26so1536638pzk.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 23:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=9BbEgRqGKsnJ0V3M1KTzf0BdryUG/uIvV22q4JsSJFs=;
        b=wifVM7bpOvJTakWE226X3zySw8qZ3fGHFl5hLeov2wT5/26miOPBq+qcxJPFRLWSde
         L2E/HEWuorv7t0CYxj4dK0hoyUOZzSumyjXrQrMrPxCWrlSvLblo3Gzzz3zkPL4fXIky
         wHlZNvC7EVGcCjTEbA/K03kh63VfONBeRyWEc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=HwTLXiRKOQ+YBeT4SejajFbnPlR4Xj5IMeb2p61oooFt7LwGLSCvv8C2mrulTH6hA/
         VE+EcTQMiZyM0UIukSM1nAljhddj3iqxj/tq3LPgZqKJzONGE+21oEidXCzR+nUqI/xc
         ++BXgYdbeWLCVCRpNNpKgYDSFH86B1vm2eO0A=
Received: by 10.114.124.10 with SMTP id w10mr2662902wac.144.1282372391479;
        Fri, 20 Aug 2010 23:33:11 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id d39sm6515731wam.16.2010.08.20.23.33.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 23:33:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100821062158.GJ6211@kytes>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154116>

Hi,

> diff --git a/t/t4202-log.sh b/t/t4202-log.sh
> index 2e51356..bd05bc9 100755
> --- a/t/t4202-log.sh
> +++ b/t/t4202-log.sh
> @@ -37,6 +37,12 @@ test_expect_success setup '
>  
>  '
>  
> +test_expect_success 'exit code' '
> +
> +        git log
> +        test_cmp $? 0
> +'
> +

Er, I meant test $? = 0.

-- Ram
