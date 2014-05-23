X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: =?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH v1 3/3] Documentation: replace: add --graft option
Date: Fri, 23 May 2014 19:06:41 +0200
Message-ID: <537F8021.8080304@gmail.com>
References: <20140522211836.27162.80311.chriscool@tuxfamily.org> <20140522213307.27162.3251.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Fri, 23 May 2014 17:07:16 +0000 (UTC)
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=rKpu9DmkXEEJNcFQr00XhsKeQKZ6kAbaJa7isHF4rhI=;
        b=proHkoLxFjKqyOFMf+MSMm3zcRCZCFCVrH9lzTc4WMt9rCb43I26iEtwIuGOxupHPl
         KVuXsf4he5XueAp0Fs+ZUOpcJ8iJjMDY6yhcYXFxdh6nB4+kmwMOMLv8UYOPGf8IfZC5
         QE2gU0+qYWozlxPz+xPmBQbHTj+9WGet1dE3wBF1qTX3kTWwOAVUR3GOOps/d8+zfflY
         Gi+F7HBbJUTJqEinQ6dByoBp7pqpSz0rBAoozArSLJ7AJCLSmiHn4MtY+1jpVZBf/gTD
         9AYxIgC+qei56jKFtlQqbv1qWRhFZAs0iSMOI0oO86In6Ab7oGydBCIh14kgCdble1KF
         NevQ==
X-Received: by 10.14.194.133 with SMTP id m5mr9947917een.38.1400864804761;
        Fri, 23 May 2014 10:06:44 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <20140522213307.27162.3251.chriscool@tuxfamily.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250000>
Received: from vger.kernel.org ([209.132.180.67]) by plane.gmane.org with
 esmtp (Exim 4.69) (envelope-from <git-owner@vger.kernel.org>) id
 1Wnsvz-0001CK-17 for gcvg-git-2@plane.gmane.org; Fri, 23 May 2014 19:07:07
 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753757AbaEWRG6 convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 May 2014 13:06:58 -0400
Received: from mail-ee0-f51.google.com ([74.125.83.51]:46751 "EHLO
 mail-ee0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1753128AbaEWRGq (ORCPT <rfc822;git@vger.kernel.org>); Fri, 23 May
 2014 13:06:46 -0400
Received: by mail-ee0-f51.google.com with SMTP id e51so3778750eek.24 for
 <git@vger.kernel.org>; Fri, 23 May 2014 10:06:44 -0700 (PDT)
Received: from [192.168.130.241] ([158.75.2.130]) by mx.google.com with
 ESMTPSA id h45sm9678275eev.20.2014.05.23.10.06.42 for <multiple recipients>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128); Fri, 23 May 2014
 10:06:43 -0700 (PDT)
Sender: git-owner@vger.kernel.org

W dniu 2014-05-22 23:33, Christian Couder pisze:

> +--graft <commit> [<parent>...]::
> +	Create a graft commit. A new commit is created with the same
> +	content as <commit> except that its parents will be
> +	[<parent>...] instead of <commit>'s parents. A replacement ref
> +	is then created to replace <commit> with the newly created
> +	commit.
> +
>   -l <pattern>::
>   --list <pattern>::
>   	List replace refs for objects that match the given pattern (or

Here I think you can add the graft replacing example:

   cat .git/info/grafts | while read line
   do git replace --graft $line; done

--=20
Jakub Nar=C4=99bski
