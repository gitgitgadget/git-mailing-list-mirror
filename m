From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: remove perl from git-commit.sh
Date: Wed, 12 Jul 2006 13:23:04 +0200
Message-ID: <81b0412b0607120423q8c75ecl7d42dfd67f99a549@mail.gmail.com>
References: <81b0412b0607120415g243f2160tf42c40e52b8bc9ac@mail.gmail.com>
	 <dbfc82860607120417m19c0ecefydb4b3f4cf60d646a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Jul 12 13:24:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0coB-00016J-CQ
	for gcvg-git@gmane.org; Wed, 12 Jul 2006 13:23:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbWGLLXH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Jul 2006 07:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbWGLLXH
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Jul 2006 07:23:07 -0400
Received: from wr-out-0506.google.com ([64.233.184.233]:32344 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751266AbWGLLXF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jul 2006 07:23:05 -0400
Received: by wr-out-0506.google.com with SMTP id 58so93199wri
        for <git@vger.kernel.org>; Wed, 12 Jul 2006 04:23:05 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=biOoArpeL3k3xMv9btvBxv/F1R31cYSATXt9ZmU6R6vXHtaPtMD9JPpLO8VBktUk2pbA2HuTrZsa31jgcUsDmBqfkkRuzQRvEyiH9AXYi2tKt+7uxdseIT69xnpB+yLKQybMJs+79dRM5AuP00NswE0iTdMCo/LlkMaGo5wzkI0=
Received: by 10.82.109.19 with SMTP id h19mr57029buc;
        Wed, 12 Jul 2006 04:23:04 -0700 (PDT)
Received: by 10.78.160.5 with HTTP; Wed, 12 Jul 2006 04:23:04 -0700 (PDT)
To: "Nikolai Weibull" <now@bitwi.se>
In-Reply-To: <dbfc82860607120417m19c0ecefydb4b3f4cf60d646a@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23775>

On 7/12/06, Nikolai Weibull <now@bitwi.se> wrote:
> > Otherwise I'd better suggest to add another
> > quoting style (replacing only \t, \n and backslash)
>
> One could always do the quoting with sed, or am I missing something?
>

No, but if look closely at this list you'll find a lot of incompatibilities
in sed too. So the less, the better
