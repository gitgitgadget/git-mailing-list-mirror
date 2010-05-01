From: Dmitrijs Ledkovs <dmitrij.ledkov@ubuntu.com>
Subject: Re: git fast-import crashes importing commits with more than one 
	author
Date: Sat, 1 May 2010 17:47:30 +0100
Message-ID: <g2x86ecb3c71005010947x662aad8bn1fc2950d741b07e7@mail.gmail.com>
References: <1272728636.27562.12.camel@localhost.localdomain> 
	<m2ocgztw7z.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Giedrius Slavinskas <giedrius.slavinskas@gmail.com>,
	git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sat May 01 18:48:00 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8FrD-00032q-8n
	for gcvg-git-2@lo.gmane.org; Sat, 01 May 2010 18:47:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243Ab0EAQrv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 May 2010 12:47:51 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:34076 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770Ab0EAQru (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 May 2010 12:47:50 -0400
Received: by pxi17 with SMTP id 17so658872pxi.19
        for <git@vger.kernel.org>; Sat, 01 May 2010 09:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received
         :in-reply-to:references:from:date:x-google-sender-auth:message-id
         :subject:to:cc:content-type;
        bh=7Tkxawd0YO3BrBQ8LjuJFtX99LPQCOQk5mB4McHhgW4=;
        b=FlUq9ziU1gcEAyaxdlN0+SYtfYXd6cOHjH9e98ATlBwl9cFmsgg/EOdMYkxYKp8E2u
         Djkl2PhpvfHR3Ltxqe2i4e1UuKqo32E0Xoonp9hCZ/FYkYT8F9PInXCT/vib/wNLjTy8
         dl4bC7LS2sZiit1CVl797KLBKLI1iSLhKGOcU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        b=szHUy/fpu0HZUWLGzZzPfS41k7JDi80arklt4QuW/Sqqq/UNDQJP1Hx6qVwjOXh19f
         WxKKc/ZOwdP5LlaxIu+BgfoB08vIXM/+L2arWEQhqLBuYHON7AGbkHbcKGPjhbcz15mA
         aeBJ/GpWMPVToNO6NDRgBaUvdWWRxujBBWVYI=
Received: by 10.143.24.14 with SMTP id b14mr7578646wfj.346.1272732470127; Sat, 
	01 May 2010 09:47:50 -0700 (PDT)
Received: by 10.142.191.1 with HTTP; Sat, 1 May 2010 09:47:30 -0700 (PDT)
In-Reply-To: <m2ocgztw7z.fsf@igel.home>
X-Google-Sender-Auth: 619d00f01ee71fa6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146089>

On 1 May 2010 17:36, Andreas Schwab <schwab@linux-m68k.org> wrote:
> Giedrius Slavinskas <giedrius.slavinskas@gmail.com> writes:
>
>> git fast-import does not support commits with more than one author. I
>> try to import bzr repository and it crashes.
>
> You can find a patch here:
> <http://bazaar.launchpad.net/~schwab-linux-m68k/bzr-fastimport/fastimport.dev/revision/262>
>
> Andreas.

Although this is fine shouldn't we put the additional authors to the
signed-off: lines in the git commit message?

--Dima.
