From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH v4 00/11] Resend sp/maint-dumb-http-pack-reidx
Date: Tue, 20 Apr 2010 12:33:47 +0800
Message-ID: <u2sbe6fef0d1004192133l3af2f8d6v1eea4c8c02c6a7c5@mail.gmail.com>
References: <20100418115744.0000238b@unknown>
	 <1271686990-16363-1-git-send-email-spearce@spearce.org>
	 <20100419224643.00001ff1@unknown> <20100419144907.GC4295@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Christian Halstrick <christian.halstrick@gmail.com>,
	jan.sievers@sap.com, Matthias Sohn <matthias.sohn@sap.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 20 06:33:56 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O459m-0005VR-1w
	for gcvg-git-2@lo.gmane.org; Tue, 20 Apr 2010 06:33:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753476Ab0DTEdt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Apr 2010 00:33:49 -0400
Received: from mail-iw0-f197.google.com ([209.85.223.197]:65056 "EHLO
	mail-iw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753400Ab0DTEds (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Apr 2010 00:33:48 -0400
Received: by iwn35 with SMTP id 35so2795335iwn.21
        for <git@vger.kernel.org>; Mon, 19 Apr 2010 21:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type;
        bh=6qWu+2fJMdAMIgsjNdPHlPBkJTiNW6a5aMGNheVfOis=;
        b=qtfrElfIWRJsBQBUsbBRuCt/Td82Kapcz92Up/eozFq/DTKjGqp9Rke2dXcdsGuoKB
         Ig+nFuEZWLeoRipEZG1O7MdJWkpLZAQPWqoWvGqdA6xW/IcAn6uKQiXCNQbvvdLxbezp
         rd70Ks2NNuH6U4CccLpU4rGQsmbAcy2dJoPcQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=ZgOSJXp93uaxNq5TwxaGbT4FmWK/KLJ4l36Xd/PmQ7h8IRtJ9pxvf+9SlzMrnWNxjs
         4KZKdSzPWCyTcNriIw5HVcNe4f/PSC5WYTHD1jtIv/T5iY1YNxMeNGnuBUuzrTqFEEWr
         dRafaln8TUdvsEZM8u8p7hq6//AMsKDE/W+9c=
Received: by 10.231.10.65 with HTTP; Mon, 19 Apr 2010 21:33:47 -0700 (PDT)
In-Reply-To: <20100419144907.GC4295@spearce.org>
Received: by 10.231.166.68 with SMTP id l4mr2228394iby.40.1271738027633; Mon, 
	19 Apr 2010 21:33:47 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145349>

Hi Junio,

On Mon, Apr 19, 2010 at 10:49 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
> Tay Ray Chuan <rctay89@gmail.com> wrote:
>> the small patch below could also be applied to the rebased topic branch.
>>
>> -->8--
>> From: Tay Ray Chuan <rctay89@gmail.com>
>> Subject: [PATCH] http.c::new_http_pack_request: do away with the temp variable filename
>>
>> Now that the temporary variable char *filename is only used in one
>> place, do away with it and just call sha1_pack_name() directly.
>>
>> Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
>
> FWIW, Acked-by: Shawn O. Pearce <spearce@spearce.org>

I noticed that the inlined patch (in message
<20100419224643.00001ff1@unknown>) being acked here wasn't applied to
the topic branch 'sp/maint-dumb-http-pack-reidx' in pu; just a
heads-up in case you've missed something.

-- 
Cheers,
Ray Chuan
