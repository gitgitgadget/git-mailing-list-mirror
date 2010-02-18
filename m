From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Using trees for metatagging
Date: Thu, 18 Feb 2010 18:32:31 -0500
Message-ID: <32541b131002181532h79d3250fid5984f46f82b71f9@mail.gmail.com>
References: <20100218041240.GA4127@lapse.rw.madduck.net> <201002182200.09100.johan@herland.net> 
	<20100218225758.GL9756@lapse.rw.madduck.net> <32541b131002181506v1d28526cpf8491994868272af@mail.gmail.com> 
	<20100218232523.GD22371@lapse.rw.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Fri Feb 19 00:32:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiFrd-0008C4-26
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 00:32:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752073Ab0BRXcw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2010 18:32:52 -0500
Received: from mail-yx0-f180.google.com ([209.85.210.180]:57706 "EHLO
	mail-yx0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751886Ab0BRXcv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2010 18:32:51 -0500
Received: by yxe10 with SMTP id 10so1636308yxe.33
        for <git@vger.kernel.org>; Thu, 18 Feb 2010 15:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=anODYhrxxzie6JEha5jSbYXugBpoAz/x2qcAofs0vOI=;
        b=o62NFcGbnwvHIkIST3kCzvCdSc3uWDhP2Aqy9YGpDlcZKwt761+2xxopaNUB2d+K/m
         qRj+bjzZ5KkvQX96tJrBW85Qv5D4ucqVYOlJuoRolHK04Y4JgKuqR5fpPc9fqGCu/QPG
         7X4onzFwK2Y+k9fXIq89/4CzjfqVFsXt3K8EE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=NQwXaKlo2QP/s/FcESB5V9hMaWVkMihkUM62pyA2gEIFdcemT4Ck7rRV6TVJat6cDj
         2DmNA8ogV3vviKE2bRk17Q78+PLxIRyHRpYPSdNzzkffLVUN+bhtKb89yQsVYelbugXu
         J54TzjIJCyD7rHXWZKU+ODtVX6x5SZtZ2TMyI=
Received: by 10.151.3.3 with SMTP id f3mr512293ybi.336.1266535971062; Thu, 18 
	Feb 2010 15:32:51 -0800 (PST)
In-Reply-To: <20100218232523.GD22371@lapse.rw.madduck.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140395>

On Thu, Feb 18, 2010 at 6:25 PM, martin f krafft <madduck@madduck.net> wrote:
> also sprach Avery Pennarun <apenwarr@gmail.com> [2010.02.19.1206 +1300]:
>> So checking in a file that contains a list of object ids (or
>> filenames) is perfectly appropriate.
>
> Indeed. But Git provides a lot of tools to manipulate all those,
> which I would not be able to reuse in the text-file approach.

But you're talking about using a nonstandard approach anyway (unless
you use git-notes).  So you'd end up rolling your own code with git's
plumbing anyway, which you can do just as easily with a text file full
of object ids.

Once you have an object id, there are plenty of existing git commands
to do whatever you want.

Have fun,

Avery
