From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 00/16] Subtree clone proof of concept
Date: Tue, 3 Aug 2010 08:55:51 +1000
Message-ID: <AANLkTi=309R5e9TOGSRrtqe5u_5p5U2Xk7oHzez5+oOp@mail.gmail.com>
References: <1280593105-22015-1-git-send-email-pclouds@gmail.com>
	<AANLkTims5Xq67QXaE54bCTHP-BZSNRVsJnUKM6YJjt2G@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 03 00:56:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Og3vK-0001dm-UW
	for gcvg-git-2@lo.gmane.org; Tue, 03 Aug 2010 00:55:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754473Ab0HBWzx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Aug 2010 18:55:53 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:43402 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754396Ab0HBWzx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Aug 2010 18:55:53 -0400
Received: by wyb39 with SMTP id 39so3794935wyb.19
        for <git@vger.kernel.org>; Mon, 02 Aug 2010 15:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Lv2ln4r+wV9zWdXkj++XrZOVvyCGDf4fjAVmsVqBhJo=;
        b=h/9IAszuxwX3K748hAV8L39G8xgfCjvm8tnRUzonYkbgkiRLdCRdsOkU7dpJgbdRRi
         1pGPASmPASoTDXQdNbdciTJAqyWl8oQ+0+OIgX2Q6ZtMMb8samC49RsSvbBfAywJG8My
         6iY1u7qrtxydYczBQKwtmRpmB+ZhlLwE6yZ0k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=MjoyjhXgRrn/TVAynvvBFlPpfMn1LJ9Zi3oRR2oIrxJIXoGKT3qug6nHVgwc3Q2zN9
         sllALG/3oHfMMrS5w28y0Ju1nF5o0bAfE1jUNjlRQUI5Skf5fflUU35pfAJaczMN9jgZ
         SgRiPGhYyXMgeBhfn9WV62+YfmoVFQ8e5YAHI=
Received: by 10.216.0.82 with SMTP id 60mr5520wea.13.1280789751868; Mon, 02 
	Aug 2010 15:55:51 -0700 (PDT)
Received: by 10.216.173.199 with HTTP; Mon, 2 Aug 2010 15:55:51 -0700 (PDT)
In-Reply-To: <AANLkTims5Xq67QXaE54bCTHP-BZSNRVsJnUKM6YJjt2G@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152482>

2010/8/2 Elijah Newren <newren@gmail.com>:
>> haven't tested it further. Space consumption is 24MB (58MB for full
>> repo). =C2=A0Not really impressive, but if one truely cares about di=
sk
>> space, he/she should also use shallow clone.
>
> 58 MB for full repo? =C2=A0What are you counting? =C2=A0For me, I get=
 25M:

My number 24MB was incorrect because process_tree() leaked too many
blobs. It should have been 16MB. Anyway I have updated my series and
put it here (to spam git mailing less)

http://repo.or.cz/w/git/pclouds.git/shortlog/refs/heads/subtree
(caveat: constantly rebased tree)

if you still want to play with it. For number lovers, fetching only
Documentation from linux-2.6.git took 94MB (full repo 366MB). Yeah
Documentation was an easy target.
--=20
Duy
