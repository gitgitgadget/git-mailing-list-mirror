From: Mike Gorchak <mike.gorchak.qnx@gmail.com>
Subject: Re: [PATCH] Improve QNX support in GIT
Date: Mon, 25 Feb 2013 10:30:43 +0200
Message-ID: <CAHXAxrOADzLckUz70e9T7EU7aWnuGadSswCU21KV2rK=sjwosg@mail.gmail.com>
References: <CAHXAxrMRxKKiEarSQ0fCLt6-zyS=52B+kmZMLDf8SQAGzGbjjQ@mail.gmail.com>
	<CAHXAxrMgJf2C3dAe1O2DW5qFYFnCDhbQNmpnvK4ZOduJnqwQWg@mail.gmail.com>
	<7vvc9i5cbw.fsf@alter.siamese.dyndns.org>
	<CAHXAxrO_AeLoHw6TaVkDZsS=J6Ro+qEuMs4rbyCoFuHAGT+6vg@mail.gmail.com>
	<7vvc9h4d7c.fsf@alter.siamese.dyndns.org>
	<7vtxp0zwyn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 25 09:31:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9tSn-0006w7-6a
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 09:31:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757316Ab3BYIao (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2013 03:30:44 -0500
Received: from mail-qa0-f43.google.com ([209.85.216.43]:51381 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754959Ab3BYIao (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2013 03:30:44 -0500
Received: by mail-qa0-f43.google.com with SMTP id dx4so1430492qab.16
        for <git@vger.kernel.org>; Mon, 25 Feb 2013 00:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=PAGRpxbBxi4OE11SCL5fLEoExVDgUCSBqqXOMtynXHg=;
        b=gIHbjbXpdefJkeliwyAqr/NjazuVEqtc/ilbmoin7leyw2x3GH35R0Fbjc+cLjc6ij
         dVgFNYaQK+7KE1roRM1O4oupUNsRpk9rPytB7yZS74JeB+OWkF/9AVCIuPNsh+2SxUxT
         IkKpkMMft4P7Sqw/uT2vUGyyfzWRmO4+2N8ReLDo46XLZkTlLrGD1agm39uO0lZbapdu
         N5XSc3CYzp1S8k2dNnhFp+TGwBYB5lMHPzEI1NBBD0dVVh+fKj+taGUzkKi8j7BO8ZkC
         aL193O6wO8pQqZ/2oyymIX8Q5MGruUbOto+PG1oWb4/tqZ/Cw5eINvFgPmvXck61gHjg
         b0uQ==
X-Received: by 10.224.32.11 with SMTP id a11mr9992920qad.87.1361781043280;
 Mon, 25 Feb 2013 00:30:43 -0800 (PST)
Received: by 10.49.71.68 with HTTP; Mon, 25 Feb 2013 00:30:43 -0800 (PST)
In-Reply-To: <7vtxp0zwyn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217047>

Hi Junio,

> Swapping the order between CFLAGS and BASIC_CFLAGS in ALL_CFLAGS may
> be a good change for that reason as well.

This sounds very reasonable.

> In any case, I won't take a patch to rename source files left and
> right only to work around name collisions with random system header
> files we do not even use ourselves, unless/until I know we have
> tried all the other saner approaches first.  That's a workaround,
> not a solution.

Ok, no problem, I will create another patch which alter CFLAGS order.
