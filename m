From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCHv3 08/16] t4026 (color): add missing &&
Date: Sun, 26 Sep 2010 06:39:49 -0600
Message-ID: <AANLkTi=cVF8QbBWZvAf_uYnFvMMdnoScsGkX-QbV33kL@mail.gmail.com>
References: <1285441627-28233-1-git-send-email-newren@gmail.com>
	<1285441627-28233-9-git-send-email-newren@gmail.com>
	<20100926033831.GA31436@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Sep 26 14:40:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzqWj-00032A-7N
	for gcvg-git-2@lo.gmane.org; Sun, 26 Sep 2010 14:40:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757660Ab0IZMjv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Sep 2010 08:39:51 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45423 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757647Ab0IZMjv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Sep 2010 08:39:51 -0400
Received: by fxm3 with SMTP id 3so1382099fxm.19
        for <git@vger.kernel.org>; Sun, 26 Sep 2010 05:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=RnROmWAi8g78PRmuI9HcVysibxlG8K2RWUzAl4baEm0=;
        b=XwyBs5RSpgjEBz9mP9aRCRTP7KiSDnBWjEI9vMSQ5qOHBvdpm9L3MT+WylEIah23bB
         Nt8y0C2asa/PgAyjIq/5XbPS/NHytrgL9wC3sb+yV47z68jfBsZzbHMo42XnguuHHWtV
         RXVmBARgWXCtcW4ncunHgj9lh9CRkeednaDRQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=KYSzRb7PQPKiUB9bZHh0pjM+CirWKZaWi1PW4pmNIAPRtZpYthLpKWD/AqVNYDlzo+
         fn5HBwAMq+rs1KI+l6684O8Eqzg4H/1v+9dZEXFRlXPVQ8m6mo1KzJDBUXAbtiageonD
         Wj4uKUdNH9Ol6rOjK7ItoqfFE/VHpI/kZ1IdY=
Received: by 10.223.105.78 with SMTP id s14mr4523817fao.1.1285504789802; Sun,
 26 Sep 2010 05:39:49 -0700 (PDT)
Received: by 10.223.119.209 with HTTP; Sun, 26 Sep 2010 05:39:49 -0700 (PDT)
In-Reply-To: <20100926033831.GA31436@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157221>

On Sat, Sep 25, 2010 at 9:38 PM, Jeff King <peff@peff.net> wrote:
> On Sat, Sep 25, 2010 at 01:06:59PM -0600, Elijah Newren wrote:
>
>> Ever since 8b12413 (color: allow multiple attributes 2010-02-27),
>> diff.color.new has been unused in t4026, so also remove the final unsetting
>> of that value to make the third to last test pass with appropriate
>> chaining.
>
> Thanks, I think this is the right patch from our previous discussion,
> but your subject line seems stale. :)

Indeed, sorry about that.  I'll update it for the resend.
