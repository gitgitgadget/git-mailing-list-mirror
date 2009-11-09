From: =?UTF-8?Q?Bj=C3=B6rn_Gustavsson?= <bgustavsson@gmail.com>
Subject: Re: [RFC/PATCH 2/4] Teach the --multiple option to 'git fetch'
Date: Mon, 9 Nov 2009 07:25:05 +0100
Message-ID: <6672d0160911082225v333488d1p906e6846df59b768@mail.gmail.com>
References: <4AF6E7DE.1020201@gmail.com>
	 <76718490911081659u318ea362l29342a9b3d90f03f@mail.gmail.com>
	 <20091109010824.GA17414@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 09 07:25:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7Ngg-00073h-2C
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 07:25:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752132AbZKIGZC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Nov 2009 01:25:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751537AbZKIGZB
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Nov 2009 01:25:01 -0500
Received: from mail-fx0-f221.google.com ([209.85.220.221]:33774 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751036AbZKIGZA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Nov 2009 01:25:00 -0500
Received: by fxm21 with SMTP id 21so37591fxm.21
        for <git@vger.kernel.org>; Sun, 08 Nov 2009 22:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=pAv/hBDofEDhWQul94FC1DYsa7Gaw4W/ceRSSFHJ36M=;
        b=CEjTkXoYekhEOLcxkTq7BXrt4drJNXccphSDBglbcYiz8uq+V8B1t5gso/fU4rCeUU
         nuDSQCMM8jdYTH2zFFfWScte00kXOuNBvMUCJSeKPkM4KbUTMgCnRUWYul5zx3ray2pU
         3CJ7pqrsvYMYaAQuJz4rhB6htyAu+cVCfb5GU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=S3ONNcdHzeWm8ag8QilmtWX01V1nTEwzVAw3/l/Rm6+2Ft0Qrshg1J3qUXgdEZd3JL
         AFnkqLc4gxCAsdMRtLMqHksTtJ3xSBDa2lPN8w3S0RtrxwttagJty41Hdi3GwlYYnOnq
         Qmtj0ANs3qPpZ/CyffTCr1Thc4XgPN7o/kRaw=
Received: by 10.204.33.194 with SMTP id i2mr7976663bkd.146.1257747905377; Sun, 
	08 Nov 2009 22:25:05 -0800 (PST)
In-Reply-To: <20091109010824.GA17414@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132441>

2009/11/9 Jeff King <peff@peff.net>:
> Isn't the colon optional, indicating that the ref should be fetched i=
nto
> FETCH_HEAD?

Yes, that's why I was forced to invent a new option.

--=20
Bj=C3=B6rn Gustavsson, Erlang/OTP, Ericsson AB
