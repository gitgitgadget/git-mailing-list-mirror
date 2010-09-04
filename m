From: Elijah Newren <newren@gmail.com>
Subject: Re: What's cooking in git.git (Sep 2010, #01; Wed, 1)
Date: Sat, 4 Sep 2010 17:48:33 -0600
Message-ID: <AANLkTik=81_ma6iZLJ1RQJ74o1g7dNN2GfT6bTT+hQti@mail.gmail.com>
References: <7vaao15jk2.fsf@alter.siamese.dyndns.org>
	<AANLkTi=ma8MLssD_1YeSju7iJucRN9NFzYESJ2rGhyjv@mail.gmail.com>
	<AANLkTik7eBGJrQ3HEYjesvR9y1PpwUphVvpBmzVCiu6p@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 05 01:48:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Os2Td-0001PZ-I2
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 01:48:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754265Ab0IDXsf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Sep 2010 19:48:35 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:36552 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753745Ab0IDXse (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Sep 2010 19:48:34 -0400
Received: by fxm13 with SMTP id 13so1952182fxm.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 16:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=TjQE/gElppM7uD5EFNlExk9rsCia3M/PJd6Soe8I4Fk=;
        b=uP7EU52GtY6/HEVKXbdwVfyy6L0S3VuhxhgrMHDVDe9jdeHO4hw5ilYjKgBe8/3T20
         96PH8G8ApmsOwK1MbhR9yYVENcp28iuUlWaNvXyMEftsNBeCDmh7tYCFbsdCWgmVPJd6
         A1BPvYnsO8c3ty/wBZKCqcIGLrArd+V/NtZ0Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=pj8c+YUJVd5rY5T7kCh5TLi4bV8cF3noGChPFgHh6Dr+ps0Y9CrCoBzaTOh9QIXrxw
         c1s33m6TM5PHFoi2Dge5zEyv+hW9VcZGPWj+EByCj1k31wYu1NHiqiFXpvFqOUO1W0A3
         HBtBIoOvNpc7B/pGYFroFcdO2n//jLtT0eJCY=
Received: by 10.223.123.145 with SMTP id p17mr1407946far.90.1283644113520;
 Sat, 04 Sep 2010 16:48:33 -0700 (PDT)
Received: by 10.223.50.154 with HTTP; Sat, 4 Sep 2010 16:48:33 -0700 (PDT)
In-Reply-To: <AANLkTik7eBGJrQ3HEYjesvR9y1PpwUphVvpBmzVCiu6p@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155387>

On Wed, Sep 1, 2010 at 5:39 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> While at there, how about adding tree exclusion mechanism that you
> mentioned in sparse clone? That would be really cool.

Tree exclusion or commit exclusion?  I think I have the former working
(I'll post a patch series soon), but not the latter yet.
