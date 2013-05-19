From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v5 1/2] cache.h: eliminate SHA-1 deprecation warnings on
 Mac OS X
Date: Sun, 19 May 2013 14:51:05 -0700
Message-ID: <CAJDDKr5Yqe8LR83MKVxgUbOY37DVT7ZF4dr3ehAj2fHPc=YO7Q@mail.gmail.com>
References: <1368601868-42410-1-git-send-email-davvid@gmail.com>
	<5193CC6B.50909@web.de>
	<CAPig+cTHh7iEY0+rReQ2LC94CsX-_aKdMLiVnL0ZF-FtKL6DaQ@mail.gmail.com>
	<CAJDDKr726C5BZwufz5o7JWZiP3pKce4g=AZvEbj8qzk8dOqzQA@mail.gmail.com>
	<7vbo891ra8.fsf@alter.siamese.dyndns.org>
	<CAPig+cSYKM3XUm4m=ip_=p0mQz=gz0VKx7bfS=UdUsFMECWEQw@mail.gmail.com>
	<7vfvxlzdyu.fsf@alter.siamese.dyndns.org>
	<CAJDDKr58oM6Dm7sb-sUu2tTt210Su_q+ixc+HA0DHbc0Kmrv9w@mail.gmail.com>
	<7vzjvrzdr7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 19 23:51:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeBVZ-0001P0-6U
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 23:51:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752944Ab3ESVvI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 17:51:08 -0400
Received: from mail-da0-f50.google.com ([209.85.210.50]:44136 "EHLO
	mail-da0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752721Ab3ESVvH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 May 2013 17:51:07 -0400
Received: by mail-da0-f50.google.com with SMTP id i23so2623481dad.37
        for <git@vger.kernel.org>; Sun, 19 May 2013 14:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=P+4cb3C+WxmAwdt2Lb8PZlDR93IlCKyiyNBUiz+Nla0=;
        b=OotFeTOROzPDNeA+CO8V5HMRuUJNSPTdWxXNCwf/hD+I8v1YT/YXTejh4xc3Tots84
         h2yKsapYpinPtHrEX148Kvze+dZOJwQGiOHIPyDLVYG45ovDjyjQJ9jxPYQYkd6r90YG
         7xEhkuIyFF77sgqeJUK8aUlpBrebwWBCKpQ1ffPqd4de4osAcGlnDl1Bl9jysQOSxEuQ
         RNJJCvQFeRke6UcM2c1jkCGWaFlA+wk1TUFJkURlyebJBIYspo6frJdRZF5LhCDIKW9f
         spKtGbu7Py3woNxkODYMyRXDibgMuEl322O3vYRVxLlqudeTbTUuwfR2LRvOZupv5Xvp
         cpiA==
X-Received: by 10.68.58.165 with SMTP id s5mr57554514pbq.220.1369000265807;
 Sun, 19 May 2013 14:51:05 -0700 (PDT)
Received: by 10.70.55.106 with HTTP; Sun, 19 May 2013 14:51:05 -0700 (PDT)
In-Reply-To: <7vzjvrzdr7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224925>

On Sat, May 18, 2013 at 11:26 PM, Junio C Hamano <gitster@pobox.com> wrote:
> David Aguilar <davvid@gmail.com> writes:
>
>> Thanks Eric and Junio.  I looked over the patches and they look good.
>
> Are you sure about that?  It seemed to me that it was breaking
> everybody that is not on MacOS X --- did I misread the patch?

Gah, correct.  I've now tested v8 which Eric just sent out.  It worked
fine for me, with and without NO_APPLE_COMMON_CRYPTO.

Thanks,
--
David
