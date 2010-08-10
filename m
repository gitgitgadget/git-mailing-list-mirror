From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: workflow for working on feature branches and incrementally 
	incorporating "master" changes
Date: Tue, 10 Aug 2010 21:02:05 +0000
Message-ID: <AANLkTi=VpQcR3qY+ML0rbe_CEptEKsXpD0noPqpGJu3s@mail.gmail.com>
References: <AANLkTi=h2MbSKmQk9p6w44WORAa8XzkpF0nBXKOgJ4T1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Bradley Wagner <bradley.wagner@hannonhill.com>
X-From: git-owner@vger.kernel.org Tue Aug 10 23:02:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oivxc-0006s4-GM
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 23:02:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757980Ab0HJVCH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Aug 2010 17:02:07 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59974 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755894Ab0HJVCG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Aug 2010 17:02:06 -0400
Received: by fxm13 with SMTP id 13so987831fxm.19
        for <git@vger.kernel.org>; Tue, 10 Aug 2010 14:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=lym3bclFgDaJjp8uTxLw+n/X1QZxs33b1x1Ho0vmW0M=;
        b=qriRu3jhThnBFnDzOpGuaQLLwv+I+rkkogmkhTTI0VSauU0zFr8372WkMe6JZ1saeV
         L0frN2T6zg/iDdlOMAm2cgI7uoLKCaqmxPpQH55IqeMlHQI/d6JRmbfpmlMwCt8tENeO
         RuhPdJTbk2RiNhvjTgEaXSY5b3JPyBf9cLEyg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=ur6B6/GSXfyJAJJ2ScZ7pU75zQis1RMuk9XPfmqUP83KlmQvWvAJQUGDmOtQES/6BF
         vIWvKCvOYBppgVyZnwXwRfuO4OlWH+1iAVhigs+UEOO228fqtjCn5EFgaUEf6K/xuP28
         GwrKmrr8d+JiG2SH+RqXuohgUsh1Ta4Tmz1+U=
Received: by 10.223.117.20 with SMTP id o20mr18833764faq.55.1281474125252; 
	Tue, 10 Aug 2010 14:02:05 -0700 (PDT)
Received: by 10.223.109.195 with HTTP; Tue, 10 Aug 2010 14:02:05 -0700 (PDT)
In-Reply-To: <AANLkTi=h2MbSKmQk9p6w44WORAa8XzkpF0nBXKOgJ4T1@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153160>

On Tue, Aug 10, 2010 at 20:20, Bradley Wagner
<bradley.wagner@hannonhill.com> wrote:

> We're coming at this from SVN, so we might just be thinking about this
> the wrong way.

What workflow did you use with SVN? Did it use branches? If so you
could just use that.
