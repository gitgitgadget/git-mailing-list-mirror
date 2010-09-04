From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: inaccurate commit message message?
Date: Sat, 4 Sep 2010 18:07:52 -0500
Message-ID: <AANLkTi=eK4qt7KLg7z-3vqV+hgUoW_xire6WftBJAYku@mail.gmail.com>
References: <AANLkTinbq8z-ygVUWPRq9PA95-+8O8SwOJCLkfMKCg9T@mail.gmail.com>
 <AANLkTinGNss5siAjpic07OB036y8K0kvBjSj=unDhQWs@mail.gmail.com> <AANLkTi=Vb2cQHPo388m9HYVdYkk3XC_-pM9bm182PWyf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Ramana Kumar <ramana.kumar@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 05 01:08:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Os1qP-0005Fo-4B
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 01:08:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754157Ab0IDXIP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Sep 2010 19:08:15 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:47195 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753895Ab0IDXIO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Sep 2010 19:08:14 -0400
Received: by gyd8 with SMTP id 8so1267700gyd.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 16:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=7twif0YXhy9WtEMeRRaXN96YYjE6zqbF1d//p4rUALs=;
        b=XpnnRJuw5LRO+BKuY3IxsF2iA2MRmaeWTgAKf9VZ/k0mwfGu6wdiG/oBOFQzBXlqD/
         rVkVzjEvt2wbFDiCfYtgvBL0Hue8qW3FgC+B4HzVmrx+1rpVwQ7l19y7OqXARsdDHC9n
         QeCk6JcuNut7g6adMKLu/uOBbDdw+3VpkGeRk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=VUji2fJ7CgveOuDzZkIbjEW72HiZArms7gg1xvZ7l597Toxel3fhQlCi6prKs2AJ19
         73sXFh+v5SQpDfj7mzRo7Fl/C2gKWECAGR0iCRtpZFiq1GQfIv3oU/bqHI+FzzbvVN+E
         B5T10bYEHTgzt3SWnNAxFqT/W8Sdxl/4N2k7k=
Received: by 10.151.99.15 with SMTP id b15mr646277ybm.272.1283641692973; Sat,
 04 Sep 2010 16:08:12 -0700 (PDT)
Received: by 10.150.204.21 with HTTP; Sat, 4 Sep 2010 16:07:52 -0700 (PDT)
In-Reply-To: <AANLkTi=Vb2cQHPo388m9HYVdYkk3XC_-pM9bm182PWyf@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155385>

Heya,

On Sat, Sep 4, 2010 at 17:55, Ramana Kumar <ramana.kumar@gmail.com> wrote:
> The documentation, both in man git-commit and in the commit message
> message, is misleading when you do git commit --verbose.

Correct.

> My proposal is to make it less misleading, by saying in at least one,
> and ideally both, of those places what you just told me for the first
> time: when you do a git commit --verbose, the diff lines and
> everything after will be ignored for the commit message.

Sounds like a good idea. See builtin/commit.c around line 660. You'll
want to check for the verbose flag and adjust the message printed
there accordingly. See Documentation/SubmittingPatches.txt on how to
submit patches.

Please do ask if you have any questions, I'd be glad to help.

-- 
Cheers,

Sverre Rabbelier
