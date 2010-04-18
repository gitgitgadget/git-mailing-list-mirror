From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Multiple user.name and user.email (possible feature request)
Date: Sun, 18 Apr 2010 20:43:11 +0200
Message-ID: <r2wfabb9a1e1004181143o7ebe2cf1t883ee4a12ba29a24@mail.gmail.com>
References: <19402.52486.274010.66636@winooski.ccs.neu.edu> 
	<F5BFE3BD-7416-4F13-AF7F-0775E3234C92@gmail.com> <20100418183759.GA11366@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Steven Michalske <smichalske@gmail.com>,
	Eli Barzilay <eli@barzilay.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Apr 18 20:43:41 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3ZT3-0006Ef-17
	for gcvg-git-2@lo.gmane.org; Sun, 18 Apr 2010 20:43:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757459Ab0DRSne (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Apr 2010 14:43:34 -0400
Received: from mail-bw0-f225.google.com ([209.85.218.225]:58727 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752011Ab0DRSne (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Apr 2010 14:43:34 -0400
Received: by bwz25 with SMTP id 25so4736158bwz.28
        for <git@vger.kernel.org>; Sun, 18 Apr 2010 11:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=1fO2+9CuYrBaDbaswQICrPsmrO8YrQzwEsdwjPzPTzg=;
        b=AfqDa8G8QBQDoGn1lC88IkK5yxjDHCuFMDfR8eJ/IvhyRm/fcpgEo0V972llQw5AkG
         cbE2vC/iL4KBbXUGZacoBvhkHSECll3XvL4ti9TlOlmTgS+iFl3quEPJi/oaJPMi7IGx
         UeCIH7nFZoE64VPSzmelKsbTloEZZs1nRNDJ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=ghn45CKQYp8Tt3S26CVgw0JjZBsZp5S2XV1QduODADh+d1orKBb5HeeR1DdJ8vLrSY
         BW7MwAF1OngZQsGcWyAhsF6Yl0hdrYc7/UOo8YZlGCv/yrvhxT2cjDfhAbkqah44mkx5
         jrz7zN41TzZuJ2b1SQiDD1y6SHDuwQ3Xd3K5k=
Received: by 10.103.168.14 with HTTP; Sun, 18 Apr 2010 11:43:11 -0700 (PDT)
In-Reply-To: <20100418183759.GA11366@coredump.intra.peff.net>
Received: by 10.103.78.10 with SMTP id f10mr2809628mul.126.1271616211111; Sun, 
	18 Apr 2010 11:43:31 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145235>

Heya,

On Sun, Apr 18, 2010 at 20:37, Jeff King <peff@peff.net> wrote:
> So I expect that will serve Eli's purpose.

If it does not, would a pre-commit hook work? If he sets some
recognizable string (such as not setting it) as email and install a
hook that barfs if it sees that?

-- 
Cheers,

Sverre Rabbelier
