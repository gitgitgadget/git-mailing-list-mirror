From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v2] rebase -X: do not clobber strategy
Date: Wed, 10 Nov 2010 19:56:10 +0100
Message-ID: <AANLkTimEvp2mQu1QWhx-FDEx37NLi8jose_p+A1y1iHK@mail.gmail.com>
References: <1289373266-32593-1-git-send-email-martin.von.zweigbergk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 10 19:56:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGFqZ-0004Fe-O8
	for gcvg-git-2@lo.gmane.org; Wed, 10 Nov 2010 19:56:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755714Ab0KJS4d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Nov 2010 13:56:33 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:64097 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755166Ab0KJS4c (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Nov 2010 13:56:32 -0500
Received: by ywh2 with SMTP id 2so138205ywh.19
        for <git@vger.kernel.org>; Wed, 10 Nov 2010 10:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=W7rRMQnF0GJM8DNDp4hGmzWGtyyGGA/pSAXqwldTEwM=;
        b=bCKeeKT908NGX2K8wFqgMLDzZJ9EWQuu9Z0MWpbHFWwByhINajeukSQaKEJlbQYy54
         Yw1SRWeVlnogHaWv3br1VWxtzDhROPa+XvKsiHASoZxQ2Kbqb94HXtCCv+8Ego9KQ0Av
         pc22tuAuoHBw7QGhBBVrxrqOS07bTfwpSSYMI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=fyYplFXcVHag3ll6K3KSi1n+AIP3LNSpw01wmAkLBSFlLHKuiRQWSzrY7bGeORyRov
         YmMYabzca/e9B3vhsN/0X2oxk3cdb9ijcVVmwpLYqAw4Io4MyQnKUQifiwddjF9PRs0x
         iYbKQtDF75NxpKHoOKRow+VctpY4nj2Myixos=
Received: by 10.151.98.2 with SMTP id a2mr1747ybm.426.1289415390355; Wed, 10
 Nov 2010 10:56:30 -0800 (PST)
Received: by 10.150.158.17 with HTTP; Wed, 10 Nov 2010 10:56:10 -0800 (PST)
In-Reply-To: <1289373266-32593-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161170>

Heya,

On Wed, Nov 10, 2010 at 08:14, Martin von Zweigbergk
<martin.von.zweigbergk@gmail.com> wrote:
> If any strategy options are passed to -X, the strategy will always be
> set to 'recursive'. According to the documentation, it should default to
> 'recursive' if it is not set, but it should be possible to set it to
> other values.

Repeat of other threat since this is a new patch: can we have a test for this?

-- 
Cheers,

Sverre Rabbelier
