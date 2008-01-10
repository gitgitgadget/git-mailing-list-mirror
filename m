From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH 1/5] Add zlib decompress helper functions
Date: Thu, 10 Jan 2008 23:04:00 +0100
Message-ID: <e5bfff550801101404g488354f5rb05cccf0923fbb9c@mail.gmail.com>
References: <e5bfff550801101304m4f0b97baua6553c45772793b6@mail.gmail.com>
	 <alpine.LFD.1.00.0801101351250.3148@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jan 10 23:04:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JD5Vr-0004Bm-1f
	for gcvg-git-2@gmane.org; Thu, 10 Jan 2008 23:04:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753447AbYAJWEF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2008 17:04:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753245AbYAJWEE
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jan 2008 17:04:04 -0500
Received: from py-out-1112.google.com ([64.233.166.180]:40973 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753244AbYAJWEB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2008 17:04:01 -0500
Received: by py-out-1112.google.com with SMTP id u52so1255579pyb.10
        for <git@vger.kernel.org>; Thu, 10 Jan 2008 14:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=YM6RMbs5qsGrcuAqnVCr/Oll18anHcbtCp0zF0wJ2NQ=;
        b=VzrftMVxMFXtQqEIQbRTJbdvoUAm0yUP7uhtAYlLtFB0GExiTHPPFGWvbHxZrEMdFu1j3/gYvW/D7OjVh7fS7fc6wyB4/urf/3s2g9cPFY3YB/4WoVjeoBNBr8c9IlEylYK1DUPDIaEwj95wVmlfs/w0rytNn9imt7/tW9Dmd3M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qtIWntuMRrPBlNAtGCZkwMZus/F4zqZQQHdFlxhANzFgag0hMN03CKbOObSuB8oeNPxboI5n5JD8HQqH7liNoOxK969WJAtx2QVvZOQTVLOKEB1O/NiwNfkQwRzyc7Pte3Yag6s6FH3X4Ao3O4QsZG43euiGoQhxvFd2DgZGWS4=
Received: by 10.141.113.6 with SMTP id q6mr1531226rvm.249.1200002640299;
        Thu, 10 Jan 2008 14:04:00 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Thu, 10 Jan 2008 14:04:00 -0800 (PST)
In-Reply-To: <alpine.LFD.1.00.0801101351250.3148@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70102>

On Jan 10, 2008 10:57 PM, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
>
> On Thu, 10 Jan 2008, Marco Costalba wrote:
> >
> > When decompressing a zlib stream use this
> > helpers instead of calling low level zlib
> > function.
>
> I really *really* hate your naming.
>

I agree 100% it was chosen only to keep zlib conventions.

>
> [ How many people really know that "inflate" means "uncompress", without
>   having to think about it a bit?
>

I misnamed the whole patch series but the last one due to deflate
being tot intuitive !!!

Ok I wrote the e-mails very quickly and cut and paste was heavily
involved, but when I realized that I called all the series 'decompress
helpers' I went blush!

Marco
