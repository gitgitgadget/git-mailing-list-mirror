From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC/PATCH] Documentation/technical/api-fswatch.txt: start with outline
Date: Mon, 25 Mar 2013 17:59:15 +0700
Message-ID: <CACsJy8Bx83P=HK1pcy7ASnP5t+_snERxnVxji9_TGW-3fuUq-w@mail.gmail.com>
References: <1362946623-23649-1-git-send-email-artagnon@gmail.com>
 <513FB85C.5010106@gmail.com> <CACsJy8CBru+Z0+oYVKGdwjiF4DDH3w4vCjunaoCnoDQ6AizwWg@mail.gmail.com>
 <5140BC80.4000201@gmail.com> <7vtxof146d.fsf@alter.siamese.dyndns.org>
 <87ehffv30f.fsf@pctrast.inf.ethz.ch> <CALkWK0=0+HYn=bSrGC5sMQOE-53As0h9dG3N9wvUB2=NW3=98A@mail.gmail.com>
 <87r4jdt404.fsf@pctrast.inf.ethz.ch> <CALkWK0nt22NW=_iH2u8iiOMofoF6k+1sZLp-NsoYZtbADfCEuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Git List <git@vger.kernel.org>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Robert Zeh <robert.allan.zeh@gmail.com>,
	Jeff King <peff@peff.net>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Drew Northup <n1xim.email@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 25 12:00:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UK58V-0000yy-0V
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 12:00:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756007Ab3CYK7s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 06:59:48 -0400
Received: from mail-oa0-f44.google.com ([209.85.219.44]:33183 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755262Ab3CYK7q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 06:59:46 -0400
Received: by mail-oa0-f44.google.com with SMTP id h1so6236461oag.17
        for <git@vger.kernel.org>; Mon, 25 Mar 2013 03:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=NEby0JQJmRtFvJI7SRTtxAVmd61Vr/Ok4XnysQm9yuk=;
        b=DEwMTJ6dPfHD4cmi0dOFCVGMUhGNIw3m4UB/cqwlo9O1wu3hjKUOvpnkEZubc+wQMt
         4zAEthHoejc2wXyex375UslgNEKD3SWG7xEJS3Km1FJXBN7Vfz+28cE2bls3O1YEMGLC
         Nvvr4IJjChqmAqMHTaQ+QRyb1uAK/CU03Dl9G1Wv7hw0A6PexiYQaxPKwPcA1VkDVfef
         +5we2cBIhK0cvGz3uTChvEbB8DX8JboUJTamfFDfF0MwzyPZqAD++VmNjRulEm4OH2OJ
         bsu8Nc5aHA3L+EzLsE4BePdY+dRGxm0wAdGk/PHqukPj5HCyAlXoeZkviTVGBQZekgvE
         VxUA==
X-Received: by 10.60.125.1 with SMTP id mm1mr10361601oeb.52.1364209185482;
 Mon, 25 Mar 2013 03:59:45 -0700 (PDT)
Received: by 10.76.27.137 with HTTP; Mon, 25 Mar 2013 03:59:15 -0700 (PDT)
In-Reply-To: <CALkWK0nt22NW=_iH2u8iiOMofoF6k+1sZLp-NsoYZtbADfCEuQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219029>

On Mon, Mar 25, 2013 at 5:44 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Just a small heads-up for people using Emacs.  24.4 has inotify
> support, and magit-inotify.el [1] has already started using it.  From
> initial impressions, I'm quite impressed with it.

Have you tried it? From a quick look, it seems to watch all
directories. I wonder how it performs on webkit (at least 5k dirs)

> [1]: https://github.com/magit/magit/blob/master/contrib/magit-inotify.el
-- 
Duy
