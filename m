From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] log --oneline: put decoration at the end of the line
Date: Thu, 20 Sep 2012 17:43:20 +0700
Message-ID: <CACsJy8BP0vzWG-Po=WBVC_V5Z5_ysoCOTkU-XV3Hy_jVE4H1XQ@mail.gmail.com>
References: <1348055540-13774-1-git-send-email-pclouds@gmail.com>
 <20120919182039.GE11699@sigill.intra.peff.net> <7vr4pxg507.fsf@alter.siamese.dyndns.org>
 <7vr4pxegec.fsf@alter.siamese.dyndns.org> <20120919234226.GA27626@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 20 12:44:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEeF8-00072E-4S
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 12:44:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753676Ab2ITKoN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2012 06:44:13 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:62474 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753598Ab2ITKnv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2012 06:43:51 -0400
Received: by ieak13 with SMTP id k13so3117476iea.19
        for <git@vger.kernel.org>; Thu, 20 Sep 2012 03:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=oT0q+p57XnNBSp8B6R4ZB+mkxMsBKAYkn1B8v7sfrZQ=;
        b=wvhQDhlZd0nUE4/kzX0SIfGde9TFEe9FhGMvyVVxh3a0LDKY0VUslin/P1mh6Ig8Vg
         j1e8lba1T5Qg5q3qa4okuQJ9FfRN3AaJz8RSnjsq1KMDk6lWD/JJsuOziQgQ//QAXz+O
         9YPBK6M0PRv+rIgKMzfg5yTO1dyfh6BbTHUXmUSnhkaYP9uMRzZFtGZwzfXW41zN2AT8
         Jnbz6hhTlPoeZ+0z9vMBlQCzVf5abEyX9uBy6nWZzBP4Pou7OO4QGoJLyLvZWwNqtJeC
         ruWLmshTZt295uEfySySdP4GuQB2NL5ALYCm7tKrgM+FA6Y/QYOllBMObhwoirOYe6f9
         DWkg==
Received: by 10.50.87.167 with SMTP id az7mr1259485igb.40.1348137830426; Thu,
 20 Sep 2012 03:43:50 -0700 (PDT)
Received: by 10.64.29.199 with HTTP; Thu, 20 Sep 2012 03:43:20 -0700 (PDT)
In-Reply-To: <20120919234226.GA27626@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206045>

On Thu, Sep 20, 2012 at 6:42 AM, Jeff King <peff@peff.net> wrote:
> If you are particular about the exact format, how about using
> --format="%h%d %s" instead?
>
> Obviously Duy could do the same to achieve his format, but I think there
> is still value in considering what the default for --oneline should be.

Yeah I was wondering if a new default would make sense.

I tried --pretty=format:"%h %s %d" but the colors were lost.
--decorate uses more than one color so %C* does not immitate the
colorful output we have with --decorate. Maybe I should add %Cd as
"colored %d" and update my alias to use it.

And perhaps a specifier to enable right alignment. It may help make
better use of wide terminal screen.
-- 
Duy
