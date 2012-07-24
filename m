From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: [PATCH v3 1/7] i18n: New keywords for xgettext extraction from
 sh
Date: Tue, 24 Jul 2012 11:38:02 +0200
Message-ID: <500E6CFA.6030203@gmail.com>
References: <cover.1343112786.git.worldhello.net@gmail.com> <6fbf2661d428ca4c4227b418368716d903dfd3e3.1343112786.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 11:38:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StbZH-0007cD-6B
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jul 2012 11:38:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753013Ab2GXJiJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 05:38:09 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:35154 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752591Ab2GXJiH (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Jul 2012 05:38:07 -0400
Received: by lahd3 with SMTP id d3so716082lah.19
        for <git@vger.kernel.org>; Tue, 24 Jul 2012 02:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=d0EWwMfAmMegobJYaRlETpAekWN2kjyJfwqNEES6CQg=;
        b=07QKsfmrqYdOBHms7OdyMexKVB0r3yjl7YjoNj4NCVLWsYsVaJmhto4NU7Y/iPWL5d
         CqMSGH5YLlD3echS+yL+PdDlIXUfVDhQ0B9Sgi2Auiemt7t4mkuX7wp3rSiazB0C++k2
         rcD2ipfBJ1IY8cXW5xpzNAwV3KfFLelWnJRmXmckhkeXEL3HaMdAYSgNGUocxHDEnYSd
         ZbsSuRk1wuqdLJv0wv2sIBs1FPOxJur9irVT2tWs6DwxY+NmirNeEpB0O5jpfPTDjcGX
         MeMkXLikhlOSkxaGr2Ukc+uSyVjVUXTgjakXtCdXzi0xFBx92LwU3pokH31yZjBFKX29
         /8FQ==
Received: by 10.112.11.100 with SMTP id p4mr9501811lbb.35.1343122686395;
        Tue, 24 Jul 2012 02:38:06 -0700 (PDT)
Received: from [192.168.178.21] (host105-96-dynamic.4-87-r.retail.telecomitalia.it. [87.4.96.105])
        by mx.google.com with ESMTPS id hg4sm16044247lab.11.2012.07.24.02.38.03
        (version=SSLv3 cipher=OTHER);
        Tue, 24 Jul 2012 02:38:05 -0700 (PDT)
In-Reply-To: <6fbf2661d428ca4c4227b418368716d903dfd3e3.1343112786.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202022>

On 07/24/2012 08:59 AM, Jiang Xin wrote:
> Since we have additional shell wrappers (gettextln and eval_gettextln)
> for gettext, we need to take into account these wrappers when run
>
s/when run/when running/ or s/when we run/.

Sorry for not spotting that in my first review!

> 'make pot' to extract messages from shell scripts.
> 

Regards,
  Stefano
