From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Refactoring hardcoded SHA-1 constants
Date: Sat, 19 Apr 2014 07:48:21 +0700
Message-ID: <CACsJy8BMuj8jcsODGLPYxakh2pMV83AqsiMb7XFNkNwdGc7NLg@mail.gmail.com>
References: <20140418221841.GC57656@vauxhall.crustytoothpaste.net>
 <20140418224049.GA15516@google.com> <5351BE03.2070604@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Git Mailing List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sat Apr 19 02:49:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WbJTG-0007dW-Cw
	for gcvg-git-2@plane.gmane.org; Sat, 19 Apr 2014 02:49:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754232AbaDSAsx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Apr 2014 20:48:53 -0400
Received: from mail-qa0-f42.google.com ([209.85.216.42]:61959 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752982AbaDSAsv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Apr 2014 20:48:51 -0400
Received: by mail-qa0-f42.google.com with SMTP id k15so2118572qaq.1
        for <git@vger.kernel.org>; Fri, 18 Apr 2014 17:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=CbCucQCjo3I+ZeU+fxoXm6yYtFozSXLRBdnZB6EC5+E=;
        b=YdPXy5Mk3OrnAACM93OyveC5RtMd4Hx8fC32dPrL9yw0zpWFv/7GoAarrsw82bVPvG
         tZ8NhDa+E7f8CcoFd4yTcJEH90866Nxt4ai2vF06WR+MamrTQV2eUJ0Ojo6UN39SPZLD
         ELiHc117aSHtqO4B5QzwY980Me+OKrnUkXGjD/V1YFkn+FcbIs8/kZbmPf612sjzQZ4z
         tNQJHMWohZ9p3udXGB5bXE2cq5rzYpziZgsOt07CrIyKgDZ1axG0TRdQLKPCWgl+QHd+
         Fxhx/GjOu3atMIyloVnPFGWvchowS9vTuJ7KP6szlLAX/LT0xQHQnow6Q+4Dxhr5SnB2
         1ZNA==
X-Received: by 10.229.176.72 with SMTP id bd8mr22422914qcb.12.1397868531200;
 Fri, 18 Apr 2014 17:48:51 -0700 (PDT)
Received: by 10.96.138.9 with HTTP; Fri, 18 Apr 2014 17:48:21 -0700 (PDT)
In-Reply-To: <5351BE03.2070604@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246493>

On Sat, Apr 19, 2014 at 7:06 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> Let the brainstorming (and bikeshedding) begin!
>
> 1. GIT_OID_RAWSZ / GIT_OID_HEXSZ
>
> 2. OID_RAWSZ / OID_HEXSZ
>
> 3. OID_BINARY_LEN / OID_ASCII_LEN
>
> 4. BINARY_OID_LEN / ASCII_OID_LEN

5. sizeof(oid) / ASCII_OID_LEN
-- 
Duy
