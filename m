From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH 2/2] Convert the users for of for_each_string_list to 
	string_list_for_each
Date: Fri, 2 Jul 2010 18:08:51 -0300
Message-ID: <AANLkTin6vHhkT7Q4h5A1g3OOQYzEPdVIOCWVyzxPacnS@mail.gmail.com>
References: <AANLkTimYyHtjCfRtrTgVh3LJeJQeBpdXMRsf3khKatFx@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	jrnieder@gmail.com, srabbelier@gmail.com
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 02 23:15:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUna9-0004dx-Tw
	for gcvg-git-2@lo.gmane.org; Fri, 02 Jul 2010 23:15:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757353Ab0GBVP2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jul 2010 17:15:28 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:61219 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751664Ab0GBVP1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jul 2010 17:15:27 -0400
X-Greylist: delayed 395 seconds by postgrey-1.27 at vger.kernel.org; Fri, 02 Jul 2010 17:15:27 EDT
Received: by qyk38 with SMTP id 38so475245qyk.19
        for <git@vger.kernel.org>; Fri, 02 Jul 2010 14:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=pU9dhBd6Sv3p0cX7yLX9o2wrPVB6iNVSR2GGhmr8SAY=;
        b=YYw67+XyVZ0cGLyGYbCSMEm8vFepWYENucde6w6yGxQMD/y4XtaAdlAaHvEAfSZ2Js
         ByyYpHTrw/1aGwNwbLtlajr01f1iYcfgJ4mdM2NxKe1waPTWvcNT8GduyyikWrI3Masp
         sk2RwWWDgq0BD5SgB0rcPiSSficYnZ+57THbQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=HsYbevONNGtqimzanswuh6zdh2D3jQ0nDU8Qz3Ux0XfvApL99AuHZ381479IDSXpGB
         JUu/juzLC/xOced2aZmwEbeXkPPQkn0jYq7CSLsGC7FkRa21hwMCCaA06ZfNw6Bldd01
         U9fd4xrT+nn3gpuzsyn3yLxtcWrvXxleqELro=
Received: by 10.224.2.204 with SMTP id 12mr778479qak.326.1278104931565; Fri, 
	02 Jul 2010 14:08:51 -0700 (PDT)
Received: by 10.229.245.208 with HTTP; Fri, 2 Jul 2010 14:08:51 -0700 (PDT)
In-Reply-To: <AANLkTimYyHtjCfRtrTgVh3LJeJQeBpdXMRsf3khKatFx@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150167>

On Tue, Jun 29, 2010 at 5:37 AM, Alex Riesen <raa.lkml@gmail.com> wrote:
> The macro is suitable for all these cases

"all these cases" is too vague. Which cases?

> and will reduce code of
> need to just iterate over the items of a string list.
>
A minor comment. There is a typo in the subject:

string_list_for_each -> string_list_foreach.

Also, you didn't convert all the cases. There are usages of
for_each_string_list under builtin/ directory too (I assume it was
intentional).
