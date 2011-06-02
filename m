From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH 1/1] git-am: provide configuration to enable signoff by default
Date: Thu, 2 Jun 2011 16:41:48 -0300
Message-ID: <BANLkTin8s72OFDg_qqGrCsiALDCYHGSTUQ@mail.gmail.com>
References: <1306917751-27999-1-git-send-email-nsekhar@ti.com>
	<BANLkTinorC17+21SA44Eg26GHERSpLb0Rw@mail.gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024D2D2916@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: "Nori, Sekhar" <nsekhar@ti.com>
X-From: git-owner@vger.kernel.org Thu Jun 02 21:42:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSDmx-0007kU-AY
	for gcvg-git-2@lo.gmane.org; Thu, 02 Jun 2011 21:42:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752086Ab1FBTlu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2011 15:41:50 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:35970 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751166Ab1FBTls (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2011 15:41:48 -0400
Received: by gwaa18 with SMTP id a18so479093gwa.19
        for <git@vger.kernel.org>; Thu, 02 Jun 2011 12:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=RWwjBZVbcbyhiCq/+D+eiy037XtRLQ8cXO8KBHJdLlw=;
        b=Bnv18E3plkU5fsMs8zCpfICFIXQTUPeHVT8PN3VqzABv/qzwDkhwUE31dbB9IrwI2N
         1RPyNoP2i8q9rGGfRoFHRe1jsiqh1ZYycU46IrmBwbaQlmCiIravnLa43Xj3HFY3x0xA
         DiI3j2vGufgo8OXp/6KFZ1/u+yQGjARxrMPgQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=bgcQGN6I8mo0Ik6Tu0tiUMlAQWZwmJr9rZEZnXDscpnmT21Lf3l7oyR2nLwTUoQFs1
         NQhEZYzb7zRcN6h/0dLwErB7A1M49M37V4KEs0JsqKRFT+m2JzZ99ZBbf+61fszDp7ur
         iUzkZJ5WtPmubg/mRBjHjlNaVi5db2sbgMURI=
Received: by 10.150.247.4 with SMTP id u4mr1145249ybh.107.1307043708239; Thu,
 02 Jun 2011 12:41:48 -0700 (PDT)
Received: by 10.151.78.8 with HTTP; Thu, 2 Jun 2011 12:41:48 -0700 (PDT)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024D2D2916@dbde02.ent.ti.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174973>

On Thu, Jun 2, 2011 at 4:10 PM, Nori, Sekhar <nsekhar@ti.com> wrote:
> At this point I am not sure if this patch will be
> considered for inclusion. If I get to submit another
> version of it, I will surely add this info.
>
I think he is talking about the tests under the t/ directory (the git
test suite). You can take a look at many examples there.
