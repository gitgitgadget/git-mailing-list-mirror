From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: Unexpected error: short SHA1 is ambiguous
Date: Sun, 27 Jun 2010 00:02:35 -0400
Message-ID: <AANLkTik_TqDoNxEbQW8lTv7l-qfCLR9ICXEabGCSGy_5@mail.gmail.com>
References: <AANLkTikSUBgySbxtKO1iB-GYFgxaL5lY0mfbb5f_xxMS@mail.gmail.com>
	<alpine.LFD.2.00.1006262323310.24097@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sun Jun 27 06:02:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSj4z-0004Ao-TQ
	for gcvg-git-2@lo.gmane.org; Sun, 27 Jun 2010 06:02:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782Ab0F0ECj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Jun 2010 00:02:39 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:52485 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750707Ab0F0ECi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Jun 2010 00:02:38 -0400
Received: by iwn7 with SMTP id 7so63717iwn.19
        for <git@vger.kernel.org>; Sat, 26 Jun 2010 21:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=rACaEVxe0BT7S7+2sli4EwL4O/mioFg0mjahfaq/y0M=;
        b=hBdtKExBKRYo+ipklPPrNgsoE0gDxHmJwcQyDguZv0gacEQSf6hn+W2eCXsCJvRMNp
         wAJGSmvfgeGNL/aKHgUE8VzQfXSdGfWAIrjLkr8NstjIbtGfDZ0PPPZZLzWkXx6UWJry
         tTT4klkEFLxnOyo5Ieu4WbE806ljjSTKwg5Sw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=xCRmakP4Fek9mangbeSrBgcFcwxBzFFIKhfi6zXNnMQMMvZcSwhf78AtOdm2YSqchW
         eY3M8z7VmJvEvCEmaN58FuiwXLZ5+c2H6eNHIff8w8WtEq3Maf7qD76bYqagjxwqyvea
         3Dpac9ZJP3RkSKtLkbs6qg1v9wGDP4YctnVxw=
Received: by 10.231.85.147 with SMTP id o19mr3247677ibl.82.1277611355802; Sat, 
	26 Jun 2010 21:02:35 -0700 (PDT)
Received: by 10.231.120.19 with HTTP; Sat, 26 Jun 2010 21:02:35 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1006262323310.24097@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149789>

On Sat, Jun 26, 2010 at 11:35 PM, Nicolas Pitre <nico@fluxnic.net> wrot=
e:

> No, the ^0 is not restricting anything. =C2=A0It merely says you want=
 to walk
> through zero parents from the specified commit, but the commit
> specification is ambiguous (3 possibilities exist).

Okay.

> rev-list will give you a range of commits. =C2=A0But again, which ran=
ge do
> you want? There are 3 possible starting points when only specifying
> aabb.

I see. Well, I guess I'd wanted something like "rev-list --no-walk
--all-matches <ambiguous SHA-1>" as a way to say "return everything
even if it isn't canonical".

In any case, I found a better way to go about what I was trying to do.

Thanks,

j.
