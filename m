From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: [PATCH 6/7] Remove unused and bad gettext block from git-am
Date: Sat, 21 Jul 2012 18:29:38 +0200
Message-ID: <500AD8F2.1000101@gmail.com>
References: <cover.1342884458.git.worldhello.net@gmail.com> <a7d2248051ddc62e38e67d9efbb41c01498c7a4c.1342884459.git.worldhello.net@gmail.com> <0fd901035a418562d3d9282553a96124814a298a.1342884459.git.worldhello.net@gmail.com> <77cbbce0450735a66ef1d9101af0bc82e3fc545c.1342884459.git.worldhello.net@gmail.com> <941f7bd695e8a14c940a5b8e4214d2773ae82557.1342884459.git.worldhello.net@gmail.com> <d5c4000b859f4b30af6fc3faec008403b82246bf.1342884459.git.worldhello.net@gmail.com> <d1af1d40b0edbb8e356ecbb700cd0a7c13832a8f.1342884459.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 21 18:29:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SscYv-0006TJ-2p
	for gcvg-git-2@plane.gmane.org; Sat, 21 Jul 2012 18:29:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394Ab2GUQ3o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jul 2012 12:29:44 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:33572 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085Ab2GUQ3o (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jul 2012 12:29:44 -0400
Received: by bkwj10 with SMTP id j10so4173214bkw.19
        for <git@vger.kernel.org>; Sat, 21 Jul 2012 09:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=UQouc73apSLbGmk+P7MKK9tN+YkPzL3WciYYEDp634U=;
        b=h8QKkkQjmc0cv97z62vW/OoKZIJWhwgio8NG1ZsnHHJ2qRZGoL3Zdn7SoMyxcORZ0U
         DipBrHv4MTbuy/nCsUsCsEoO5/rT+pBZnZVaiJmjpqHToHQhZtO9sipnRx4JmrlfEEe5
         yWCEx4TGAh93jhiQXnehKnrJulqvDm/3K07g8oB+MJp3eu6GMAV406uxDf+BuctpJsiX
         YcOhfrQ1rX1UPlVNOvwxdpuNeNJ6zVD0U5AGyL9VLUySMKnt+HP8Tnb9fTv6u+gtHF1r
         BRmB8sR69PrpAQ00RYbhxI/1uQJ7pDHmTyquCyvChk/Xw6dbxjSSBJVLNDX1vYHKqw79
         D4Ng==
Received: by 10.205.127.77 with SMTP id gz13mr4917641bkc.17.1342888182717;
        Sat, 21 Jul 2012 09:29:42 -0700 (PDT)
Received: from [192.168.178.21] (host105-96-dynamic.4-87-r.retail.telecomitalia.it. [87.4.96.105])
        by mx.google.com with ESMTPS id hg13sm4264283bkc.7.2012.07.21.09.29.41
        (version=SSLv3 cipher=OTHER);
        Sat, 21 Jul 2012 09:29:42 -0700 (PDT)
In-Reply-To: <d1af1d40b0edbb8e356ecbb700cd0a7c13832a8f.1342884459.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201827>

On 07/21/2012 05:50 PM, Jiang Xin wrote:
> Gettext message
>
s/message/messages/ I think.

> should not start with '-' nor '--'. Since the '-d' and
> '--dotest' options are not exist
>
s/are not/do not/

> in OPTIONS_SPEC variable,
>
s/OPTIONS_SPEC/the OPTIONS_SPEC/

> so it's safe to remove the block.
>
This "so" is redundant, in light of the earlier "Since".  I'd just remove it.

Regards,
  Stefano
