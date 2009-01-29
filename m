From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: git clone --bare doesn't create refs/heads/*?
Date: Thu, 29 Jan 2009 22:48:01 +0800
Message-ID: <be6fef0d0901290648g3e057255p2e69491edc3227e2@mail.gmail.com>
References: <be6fef0d0901290606q25ad7c82ob250a5f89d4db0cf@mail.gmail.com>
	 <20090129142657.GG21473@genesis.frugalware.org>
	 <be6fef0d0901290636m5b472499mdf614841a06ec978@mail.gmail.com>
	 <20090129144036.GH21473@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Thu Jan 29 15:49:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSYCw-0003Tv-2q
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 15:49:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753687AbZA2OsG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 09:48:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753528AbZA2OsF
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 09:48:05 -0500
Received: from wa-out-1112.google.com ([209.85.146.179]:3443 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752149AbZA2OsE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 09:48:04 -0500
Received: by wa-out-1112.google.com with SMTP id v33so1321595wah.21
        for <git@vger.kernel.org>; Thu, 29 Jan 2009 06:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=M5A/rFyem1bE7gC8kIOtQFIPu7cILEj0CKa3ljcKibc=;
        b=i41DHGTt1kQJBHldumvgVYcr+iuJTffNy+gW0gIrHbe+fd7zWpcGqNfKs2NvJeYlsM
         ZZt8iOn5ANHWm01pLK+F1j7xv7gSxS723QfU8ig5cVw8soXMni2+OgXbIEh7kDYFEfUc
         G8CsRLKtpVuCQUeDU9+gZ7A9i8xsTLpxJIcA8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ICri/2A5M9uHW4H9OkuNpSHR4v0hSs1E76Jn0S7ri+H0RYl5zN91WMBwImf9PNn3pD
         Gv13wIqJEb+O0ZLpsLAbnIiNKbccE9J7k4oij/nY3plckj9ezcaeKoejS3iYlCz7IdY6
         /alhRo5wUO/VbYPQ+QXL637NtQL4l24AmpI9U=
Received: by 10.114.72.1 with SMTP id u1mr70933waa.203.1233240481194; Thu, 29 
	Jan 2009 06:48:01 -0800 (PST)
In-Reply-To: <20090129144036.GH21473@genesis.frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107689>

On Thu, Jan 29, 2009 at 10:40 PM, Miklos Vajna <vmiklos@frugalware.org> wrote:
> [ Please don't top-post. ]

Oops.

> Ah, packed refs. :)
>
> See man git-pack-refs, git clone uses it to pack refs after a clone.
> They are still in the 'packed-refs' file.

Thanks, that does clears things up.


-- 
Cheers,
Ray Chuan
