From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: tests failing on Cygwin
Date: Sat, 7 Aug 2010 23:04:18 +0000
Message-ID: <AANLkTinuDuMRADHjTMbVW4tPm2qNd1S0Pg7YrQ94MN3B@mail.gmail.com>
References: <AANLkTimeE-dJrSrjJSuP9Zm93tF9woNakO+HwspJg6CZ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: "Amir E. Aharoni" <amir.aharoni@mail.huji.ac.il>
X-From: git-owner@vger.kernel.org Sun Aug 08 01:04:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhsRF-0003m7-Cl
	for gcvg-git-2@lo.gmane.org; Sun, 08 Aug 2010 01:04:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754074Ab0HGXEU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Aug 2010 19:04:20 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:61071 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753605Ab0HGXET (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Aug 2010 19:04:19 -0400
Received: by iwn33 with SMTP id 33so2530043iwn.19
        for <git@vger.kernel.org>; Sat, 07 Aug 2010 16:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=eVUN+Ai7UxyABykFJ+Z/rdd6R8tWHW9gbcMJEhpSkSw=;
        b=xbdDnwr6Tkkx+LUaRwGLLEt+e9pdpCzNY446IeuQKiAZYKx5s/fUoAO+wc4FqOEt9L
         vNs/hsUGKJj/C3InzP4YwUux3Z3ngr5cjH13JWYV+ElPJB/0MCjaoG0PjedHZPW1tn7h
         xqksO1KWaADhe89Bq32gAjdij/45l3Go8pfV4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=d51ajj67ysXTY9XMifLgHGH2IF2F407d9ezilQuvHIRDpuTXsq3jAijsKVZ5G2Dl1U
         FL5B0zYaqfmrXZeFUCgN87dVOHxAIdSSxKQl1+1jlZ4O/z1z6lWFXNlEaXC7T/Bb3be+
         4jNkXMiFCWFehkv/EuTAheuNLS4vGcrEXaTQs=
Received: by 10.231.155.206 with SMTP id t14mr16613982ibw.34.1281222258337; 
	Sat, 07 Aug 2010 16:04:18 -0700 (PDT)
Received: by 10.231.186.226 with HTTP; Sat, 7 Aug 2010 16:04:18 -0700 (PDT)
In-Reply-To: <AANLkTimeE-dJrSrjJSuP9Zm93tF9woNakO+HwspJg6CZ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152871>

On Sat, Aug 7, 2010 at 21:37, Amir E. Aharoni
<amir.aharoni@mail.huji.ac.il> wrote:

(forgot to reply to this)

> I couldn't find a better place to report this and i don't know whether
> anyone really cares about this, but i'll try anyway.

This is the right place, and we care. But we don't have a lot of
people using Windows here, so stuff like this might be broken.

The Windows builds of Git use MINGW now that I can tell, not Cygwin,
so Cygwin might break in some ways that MINGW doesn't.

Anyway, un-breaking it would be nice.
