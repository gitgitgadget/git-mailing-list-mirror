From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH v4 2/3] relative_path should honor dos-driver-prefix
Date: Thu, 10 Oct 2013 22:34:04 +0200
Message-ID: <52570F3C.20509@gmail.com>
References: <cover.1379644482.git.worldhello.net@gmail.com> <b7d2432db756e16e9addb2fcccf5538c6fad342f.1379644482.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Tvangeste <i.4m.l33t@yandex.ru>,
	Johannes Sixt <j6t@kdbg.org>,
	Karsten Blees <karsten.blees@gmail.com>,
	=?ISO-8859-1?Q?Torsten_B=F6ge?= =?ISO-8859-1?Q?rshausen?= 
	<tboegi@web.de>
To: Jiang Xin <worldhello.net@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 10 22:34:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUMw2-0003Vu-Cp
	for gcvg-git-2@plane.gmane.org; Thu, 10 Oct 2013 22:34:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756589Ab3JJUeK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Oct 2013 16:34:10 -0400
Received: from mail-bk0-f49.google.com ([209.85.214.49]:64827 "EHLO
	mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755212Ab3JJUeJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Oct 2013 16:34:09 -0400
Received: by mail-bk0-f49.google.com with SMTP id r7so1188419bkg.8
        for <git@vger.kernel.org>; Thu, 10 Oct 2013 13:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=Tr14RMZA/smBNqgrcz/veQ4YoFWFdvKGSrGoYfzGMqs=;
        b=abT9hlhVYmZaCloRzb/zKLkUCjVXcRxQ0OjDsz3GZv84NvMTbWtwPmB2F4z6zQGcKJ
         7Ojz9ARK5Ydi9KnKV+oJCjAJk79zKptOHusJJyG4eeK7xUUzbnk5niyh5ywHZkQ5D9qz
         +EXtqdwRpcplR/1VzLaf2IpNiUYfk60ANqBZKugfWja1ZSRQkEikdSm1FlkmfnbKDrHu
         TF+zOUOcsRWVe8eAM9/XR1orgPkkHt1gaQ6ARaPSdq0ov5/UvIxyU4v+XI+eHR1GTh6s
         lpJDRZ/culqhsT4lrKwrvBl3c2Xv3fE26XeJVDAXsMtBJLz9Qe5LeRjie3cMTvICaRGo
         IzDg==
X-Received: by 10.205.105.73 with SMTP id dp9mr3687214bkc.33.1381437247927;
        Thu, 10 Oct 2013 13:34:07 -0700 (PDT)
Received: from [192.168.188.20] (p5DDB14BE.dip0.t-ipconnect.de. [93.219.20.190])
        by mx.google.com with ESMTPSA id ny10sm28347407bkb.17.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 10 Oct 2013 13:34:07 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <b7d2432db756e16e9addb2fcccf5538c6fad342f.1379644482.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235882>

On 20.09.2013 04:38, Jiang Xin wrote:

> Tvangeste found that the "relative_path" function could not work
> properly on Windows if "in" and "prefix" have DOS driver prefix
> (such as "C:/windows"). ($gmane/234434)

s/driver/drive/

> E.g., When execute: test-path-utils relative_path "C:/a/b" "D:/x/y",
> should return "C:/a/b", but returns "../../C:/a/b", which is wrong.
>
> So make relative_path honor dos-driver-prefix, and add test cases
> for it in t0060.

s/dos-driver-prefix/DOS drive prefix/

-- 
Sebastian Schuberth
