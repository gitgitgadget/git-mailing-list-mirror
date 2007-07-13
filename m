From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: git fetch inside a bare repo does nothing
Date: Fri, 13 Jul 2007 14:48:19 +0200
Message-ID: <81b0412b0707130548s709709a2nf621b19d10e238a0@mail.gmail.com>
References: <20070713103303.GD18199@xp.machine.xx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 13 14:48:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9KZb-0007rf-1C
	for gcvg-git@gmane.org; Fri, 13 Jul 2007 14:48:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757275AbXGMMsV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jul 2007 08:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756947AbXGMMsV
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jul 2007 08:48:21 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:38800 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753820AbXGMMsU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2007 08:48:20 -0400
Received: by ug-out-1314.google.com with SMTP id j3so556520ugf
        for <git@vger.kernel.org>; Fri, 13 Jul 2007 05:48:19 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BG8bXH7ITyAJwSEJrZk6Q2kVXT5tDS4rcDlfdQB+/rAVXhJOYJSCqjZMx0be3LhXWphw9n+aXr++mOv+q4wmFqjaPudPdWQOd5qoVkdJW0CqpMKWAB8YSKFMN3mBGJxSLU46VezA0QPB462ZcSXJK+6dE2Ts/jgrapuVz5tzjZs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mO9tOpp754bnJtCTk4/tyHF/PAM8uP1RCvt/dxwc3eGUntBKWZbtzk9y9GHu5cAEIiV5gYD5iCRsGo2MHL0cBsksDb/vAPYqXMMqtOkJwx674oy7V/CRJfmaUiFLgqApvwj7PV0oBfDiRuMKMW3mMS/1rEs2KwzUvBMcTPvRxoA=
Received: by 10.78.140.16 with SMTP id n16mr466983hud.1184330899157;
        Fri, 13 Jul 2007 05:48:19 -0700 (PDT)
Received: by 10.78.118.19 with HTTP; Fri, 13 Jul 2007 05:48:19 -0700 (PDT)
In-Reply-To: <20070713103303.GD18199@xp.machine.xx>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52388>

On 7/13/07, Peter Baumann <waste.manager@gmx.de> wrote:
> I suggested to use "git fetch --bare" inside the bare repo, but this

"git --bare fetch".

You swapped "fetch" and "--bare".
