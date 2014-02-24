From: =?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH 5/6] Document a bunch of functions defined in sha1_file.c
Date: Mon, 24 Feb 2014 19:18:19 +0100
Message-ID: <530B8CEB.5040903@gmail.com>
References: <1393000327-11402-1-git-send-email-mhagger@alum.mit.edu> <1393000327-11402-6-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Feb 24 19:18:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WI06o-0008Ub-1o
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 19:18:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752837AbaBXSS0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Feb 2014 13:18:26 -0500
Received: from mail-ea0-f170.google.com ([209.85.215.170]:54864 "EHLO
	mail-ea0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752362AbaBXSSZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Feb 2014 13:18:25 -0500
Received: by mail-ea0-f170.google.com with SMTP id g15so3315169eak.1
        for <git@vger.kernel.org>; Mon, 24 Feb 2014 10:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=fcKuNR/hTQ7DFEvef7EdSRRj4Jf2mZ0Btgf1hWpaA/s=;
        b=JmTEXr6oyBXPvaos/9UKmzAspeDG5ZiYeW2SiH5gjJQpk2M56yEnATE5nzwU0rb7iA
         YgvYNrQeN6Vl9dkMkIIqOsXJBiEbVo1CES7smb8vU0S7YOyAEInr36sP9gLW3mv6M+UC
         SD/EGj7AGlDzA/U8Fia1Bs3FaqT9OQESis4mjQH6sVIt9LUtCNFAGsSOrnKkAt3rb8cI
         q5qZCX7rug599f/T/hwQwvRqJilH4AeZ+5l0wK2pRTereDJFdssdbDuR+TObNcBkqCCc
         vbchl0C/TlvwffQWBuhA0JrTddUvay/4M8LNTWW9por6LY6FDY0WKOZzwinvPnxVwUJG
         Df9w==
X-Received: by 10.15.56.130 with SMTP id y2mr26169591eew.17.1393265904507;
        Mon, 24 Feb 2014 10:18:24 -0800 (PST)
Received: from [192.168.130.241] ([158.75.2.130])
        by mx.google.com with ESMTPSA id j41sm66594985eeg.10.2014.02.24.10.18.22
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 24 Feb 2014 10:18:23 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <1393000327-11402-6-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242628>

Michael Haggerty wrote:

> -/*
> - * NOTE! This returns a statically allocated buffer, so you have to =
be
> - * careful about using it. Do an "xstrdup()" if you need to save the
> - * filename.
> - *
> - * Also note that this returns the location for creating.  Reading
> - * SHA1 file can happen from any alternate directory listed in the
> - * DB_ENVIRONMENT environment variable if it is not found in
> - * the primary object database.
> - */
>   const char *sha1_file_name(const unsigned char *sha1)

Has this changed?

--=20
Jakub Nar=C4=99bski
