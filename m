From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: [PATCH v2 2/3] unpack-trees: plug a memory leak
Date: Thu, 30 May 2013 15:40:48 +0200
Message-ID: <51A756E0.4050409@gmail.com>
References: <1369920861-30030-1-git-send-email-felipe.contreras@gmail.com> <1369920861-30030-3-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Adam Spiers <git@adamspiers.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Stephen Boyd <sboyd@codeaurora.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 30 15:41:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ui36D-00022q-0w
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 15:41:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756268Ab3E3Nk4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 May 2013 09:40:56 -0400
Received: from mail-bk0-f52.google.com ([209.85.214.52]:37452 "EHLO
	mail-bk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756191Ab3E3Nky (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 09:40:54 -0400
Received: by mail-bk0-f52.google.com with SMTP id mz10so153510bkb.25
        for <git@vger.kernel.org>; Thu, 30 May 2013 06:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=XHYhvicCy7KuFeIKmSq7tw3uYQ6ibpvMq3kZJ365kro=;
        b=twjcUEjZma2oPyuBwEfRzYwjZUNVo3o2zIkQ/O0Mf2YptuHPyXmpA+J3cM7znNMwpH
         gHEX5D9FL/0tWWqRNP2vMBf9ssVeb29/009tcwyM8t6biym1pEzvm4GXxjc3aZHrZCEw
         cpVY4gnd4WJCLOq+acsyIlIX4x3zHsC/sfO/eHGBpQP5fcu9ANDeWUgXwKVjkNtk7BdJ
         es6CuL/gfp2mvfaw9Os4h8eLtMlfV1gwu5JNhh97VJATORaF/8bkg4n2VgXmFlOyMQLp
         VUR5JHJxt4t9k466TrpZ3xf4fMk3pGRdVv6Oergp79TGycert1lOtCSzGanWJdGF1bqM
         zVXg==
X-Received: by 10.204.108.4 with SMTP id d4mr1838612bkp.176.1369921251566;
        Thu, 30 May 2013 06:40:51 -0700 (PDT)
Received: from [192.168.178.20] (host93-95-dynamic.6-79-r.retail.telecomitalia.it. [79.6.95.93])
        by mx.google.com with ESMTPSA id b12sm13641156bkz.0.2013.05.30.06.40.49
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 30 May 2013 06:40:50 -0700 (PDT)
In-Reply-To: <1369920861-30030-3-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225990>

On 05/30/2013 03:34 PM, Felipe Contreras wrote:
> Before overwriting the destination index, first let's discard it's
>
s/it's/its/

> contents.
>
> [SNIP]

Regards,
  Stefano
