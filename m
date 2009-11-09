From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: pulling git -- version confusion
Date: Mon, 9 Nov 2009 20:16:21 +0100
Message-ID: <fabb9a1e0911091116p4c869cefx79cb1354ed464507@mail.gmail.com>
References: <f46c52560911082214x81ae8beya139a8bcb3cbcf2a@mail.gmail.com> 
	<fabb9a1e0911082237x462b1203v724b51e309a2d89@mail.gmail.com> 
	<f46c52560911082345y71eb12c9w114b799d70720dc6@mail.gmail.com> 
	<fabb9a1e0911082351o326b205aic205552faae4e4da@mail.gmail.com> 
	<f46c52560911090524l51140858sdde29d76e2cfed49@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Rustom Mody <rustompmody@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 09 20:16:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7ZjN-0007oW-1w
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 20:16:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751073AbZKITQi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2009 14:16:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751046AbZKITQh
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Nov 2009 14:16:37 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:56727 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750964AbZKITQh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2009 14:16:37 -0500
Received: by ewy3 with SMTP id 3so3456021ewy.37
        for <git@vger.kernel.org>; Mon, 09 Nov 2009 11:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=vuRTT+Rb30v7P0CR0/C0oZEtmsJUYjnx81mOCsxDADw=;
        b=ONs/My8y3PlslCO0Jq+Tgi/nyhzPNnJg+Rjof+8Rkgj5DQjuFUjeSB5bjaepZ/d1i1
         W3gFrXGHX76qguRUXFM8ORbuO14PcgTroY1rfP1AAMhiL+H/+3ReE7FdxgKij+bQefKI
         K+yRfWmFjGENvSYrtmoz2oOB/IvmCssyr62zU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=GBcTzu1cuVH2lU8xKOSAb3Cfc72sr44z2zh26blazBrEyPYRyZuii7b9aCmw8cK8Qo
         UDdoArVq9OW6aNSQAIDhhI4MChWq9cuQqQ294aMeUu7eme552Nt3OOYKybpoVNSLBs7A
         W/zatqJB5BvNshjfhphOtnXrtWzATNMLNhg6A=
Received: by 10.216.91.10 with SMTP id g10mr2449937wef.217.1257794201751; Mon, 
	09 Nov 2009 11:16:41 -0800 (PST)
In-Reply-To: <f46c52560911090524l51140858sdde29d76e2cfed49@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132508>

Heya,

On Mon, Nov 9, 2009 at 14:24, Rustom Mody <rustompmody@gmail.com> wrote:
> So theres no remote?
> But .git/remotes/origin has

Ick, how about switching to:
$ git remote add origin"git://git.kernel.org/pub/scm/git/git.git"

And then you can do what I said earlier?

-- 
Cheers,

Sverre Rabbelier
