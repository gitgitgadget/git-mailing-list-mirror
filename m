From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH/RFC 00/20] Refactor rebase
Date: Fri, 26 Nov 2010 15:10:56 +0100
Message-ID: <AANLkTikyQTA3b8+subR2FTL9zFBt_dGqNxjsjP+fwE-n@mail.gmail.com>
References: <1290715083-16919-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <alpine.DEB.1.10.1011252120450.17721@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 26 15:11:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLz1J-00019q-Ih
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 15:11:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752479Ab0KZOLT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Nov 2010 09:11:19 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:33679 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751278Ab0KZOLS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 09:11:18 -0500
Received: by yxt3 with SMTP id 3so451439yxt.19
        for <git@vger.kernel.org>; Fri, 26 Nov 2010 06:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=4XyfAS7Em3HNTVC5V9rVlq90CJylHesvi8Lkl2J3bJw=;
        b=urHkUhFCP2OH8VLd0KtKBJ8L4EJ+VbDUmpiQtEh30WGuvq03Lp8D69HoMa8BQ1kmiO
         qRDKFwwowHt/TCBcUWKBQXX8FpGL0NUv4Bwiv3iRBb/9FSxHwzwe0GQ0uvikloeFEH2Y
         hmX3hfHm2IoXBNYLNqhiJW58GvbVtkq+HUJLs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=vjaCQxy50XrOYEXdK6UZpULfr/opE4axj/V1ThPQWloOJHpHqSwf9AEpQPxYIRlA2p
         BoNMm5EblO7x0mUknNq9JABfDfKNX9wUBY53gTTSf5sKOeR0pnZYfo7XBArSzlkgJ9r9
         yHTzbFnSyp28DCLYGcv060i06djZ7BQgAixkE=
Received: by 10.150.190.14 with SMTP id n14mr2984855ybf.416.1290780678092;
 Fri, 26 Nov 2010 06:11:18 -0800 (PST)
Received: by 10.151.100.19 with HTTP; Fri, 26 Nov 2010 06:10:56 -0800 (PST)
In-Reply-To: <alpine.DEB.1.10.1011252120450.17721@debian>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162211>

Heya,

On Thu, Nov 25, 2010 at 21:23, Martin von Zweigbergk
<martin.von.zweigbergk@gmail.com> wrote:
> I forgot to say that the patches should be applied on pu.

This is undesirable. In general you should base your patches on
master, unless they depend on a multiple topics in next, in which case
it's acceptable to base them on next (or directly on that particular
topic, if there's only one).

-- 
Cheers,

Sverre Rabbelier
