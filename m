From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: Re: [PATCH] gitweb: Added syntax highlight support for golang
Date: Sat, 8 Feb 2014 03:28:44 +0530
Message-ID: <CAK9CXBUewMhr19KarmymOXmoq1ijPuU2mq4hqc6a-W0TCq5SRg@mail.gmail.com>
References: <1391807441-23049-1-git-send-email-pavan.sss1991@gmail.com>
 <xmqqiosqtwqk.fsf@gitster.dls.corp.google.com> <CAK9CXBXXge+ZGN_ocWMH5jkPJcTg74rhtWsDiOuqAeeGXDW_tg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 07 22:59:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBtS3-0004Tu-9v
	for gcvg-git-2@plane.gmane.org; Fri, 07 Feb 2014 22:59:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751750AbaBGV7G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Feb 2014 16:59:06 -0500
Received: from mail-qc0-f174.google.com ([209.85.216.174]:32811 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744AbaBGV7F (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Feb 2014 16:59:05 -0500
Received: by mail-qc0-f174.google.com with SMTP id x13so7068990qcv.33
        for <git@vger.kernel.org>; Fri, 07 Feb 2014 13:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=7Q6KfGo3V2CLwHpcjYjQ5k+t2jlefF0c/9oRFi7bKN4=;
        b=apmjIBS0E8tUy33qEUdA4E8NiZopeYqhKEOM0yVRz9ITbnoPiHALsWJg/BH2THw4bQ
         420zWRaTLCVk48FpgcFD0VIzJ81IpGBVDrfvcqcDQBu+oV9l7qkxcH4QD9d78mSHBawx
         u5EIwnh1SCtNBKr0Y4JYKwxkKyWc9GShdIwIgGnJSAvjm60tlz64RWtot8zjSZxKU98N
         GFATfWUzryqyNg23GIhSEDF7354gNS+P4slIhnUWDBpgotO5ygUL+Dq76lSG+WyChR+R
         AoPuXDN5F2rRyQMj7Av5x7KK6YsNyYBCIeRY6USpnPs5/2hWVEb/X3nCfRUEUey0LSKr
         f0ZQ==
X-Received: by 10.224.4.5 with SMTP id 5mr26443621qap.61.1391810344837; Fri,
 07 Feb 2014 13:59:04 -0800 (PST)
Received: by 10.224.121.211 with HTTP; Fri, 7 Feb 2014 13:58:44 -0800 (PST)
In-Reply-To: <CAK9CXBXXge+ZGN_ocWMH5jkPJcTg74rhtWsDiOuqAeeGXDW_tg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241808>

Sorry. I misunderstood your message. Yes, I guess lazy loading the
supported file extensions would be better. But not all highlighters
support `-p` option. So, I think its better to leave it to the user.

Thanks
