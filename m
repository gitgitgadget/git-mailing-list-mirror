From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: unable to retrieve new files from the server
Date: Sat, 11 Sep 2010 16:51:25 +0000
Message-ID: <AANLkTimkHjsyaNWV16DccSC-cQpVSPJfi56asMbGtPkX@mail.gmail.com>
References: <1284223572247-5521801.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Andy <hoangtu69@yahoo.com>
X-From: git-owner@vger.kernel.org Sat Sep 11 18:51:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OuTIa-0007qA-3H
	for gcvg-git-2@lo.gmane.org; Sat, 11 Sep 2010 18:51:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753038Ab0IKQv0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Sep 2010 12:51:26 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:44795 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752621Ab0IKQv0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Sep 2010 12:51:26 -0400
Received: by iwn5 with SMTP id 5so3385639iwn.19
        for <git@vger.kernel.org>; Sat, 11 Sep 2010 09:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=UKVd+zA3YYqYa1RYoI7Tvu0nDkegvhJ6GGpm6+jmkvU=;
        b=kShEdC0DeuUyL6tkxTvhvMSEM4APDV6gYn1M39emCOi5+Ls0gJ+3nK0YOS45w/y3wI
         NlC6lQl/1VbNePESBwtNuJK6FgQ4izd3M1Pm9p7PQaoHYJWote/7xTvbswaoUnckaR9O
         8VDY85a3ojIYceUsHlQbmN6isFgr7Zgydfhy4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=bKOkQ7hvO48du+vseeCRHD9ZLQQhch/S7/n1ycps+v6Z3Xf0fpyd2nTcEQC6tG3IJ2
         j04OIyfqDbsxIJd+85GwpIwe5N2oJfyAUoRkIrAJN4p5oq7D16qFn5MQ6pYH5PXkO2Sd
         0dNlH2mwnc0Br9TDHHIRAOsFahnbLZ0IH30xs=
Received: by 10.231.30.129 with SMTP id u1mr1442618ibc.3.1284223885478; Sat,
 11 Sep 2010 09:51:25 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Sat, 11 Sep 2010 09:51:25 -0700 (PDT)
In-Reply-To: <1284223572247-5521801.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155993>

On Sat, Sep 11, 2010 at 16:46, Andy <hoangtu69@yahoo.com> wrote:
>
> i did a git clone https//..../abc.git. =C2=A0everything was fine.
>
> Now there are new files on the server and I did a git pull and it sai=
d
> everything is up to date. =C2=A0But I still do not see the new files =
on my
> machine.
>
> How do I pull all new files down to my machine?

Did you commit those new files? And did you commit them to the tree
"git pull" is pulling from?
