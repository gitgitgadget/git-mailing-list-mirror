From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: empty directories
Date: Mon, 23 Apr 2007 18:19:46 +0200
Message-ID: <81b0412b0704230919h3be7a67fqec431a6afb6e3760@mail.gmail.com>
References: <f36b08ee0704230840xa37e149qffa15c5c685524c4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Yakov Lerner" <iler.ml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 23 18:20:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hg1Gg-0006Vq-UI
	for gcvg-git@gmane.org; Mon, 23 Apr 2007 18:19:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965013AbXDWQTt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 12:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753979AbXDWQTt
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 12:19:49 -0400
Received: from an-out-0708.google.com ([209.85.132.244]:23035 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754032AbXDWQTs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 12:19:48 -0400
Received: by an-out-0708.google.com with SMTP id b33so1867250ana
        for <git@vger.kernel.org>; Mon, 23 Apr 2007 09:19:47 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ErWjwu1Hky5X2hbtzqGsMzNSYhp6jqSKe+e3l3XJhpxM9WBzj+QVg9CmUifmuaoP070TnG3WnbH7L/7rXjUOcpd5Vsni3ZK+QJYDzpvPxif4zH8g1+OwHbpJDwFw6spZE+FFx4YkyND8RX+c8rRN/RzFztIBi2d+/XfurQio8IA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KhzEE2ofiYqmF/oEmKCs2EQSDod6B3Wf4d3n/n11g9IPVTCAmTjbXCuODO0ejD9cQmJSFO6STMD5dLhB6OMJbGfb+ymPKAlJZADWp5HhqqU3oKN7b98uMUTrKLdzdE6chhl4+EUBdwE3ofXes4TRWlHz3x3P8+HQrIREYM00uSc=
Received: by 10.100.139.9 with SMTP id m9mr3808827and.1177345186357;
        Mon, 23 Apr 2007 09:19:46 -0700 (PDT)
Received: by 10.100.225.3 with HTTP; Mon, 23 Apr 2007 09:19:46 -0700 (PDT)
In-Reply-To: <f36b08ee0704230840xa37e149qffa15c5c685524c4@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45331>

On 4/23/07, Yakov Lerner <iler.ml@gmail.com> wrote:
> When I git-add empty directory (mkdir d1;git-add d1),
> git refuses to add it [1].
>
> I was told on #git chan that git cannot store empty dirs.

It can, just refuses to. Which considered good by most

> But when I do
>          git-add -f emptyDir # where emptyDir is empty dir
> , emptyDir is added and then cloned. What does it mean ?

$ git add -f emptyDir
fatal: unable to index file emptyDir

> Does it mean that if i git-add emptyDir with -f, it may break
> something in the repo ? That I shall not try it ? Or it is ok ?

It is not ok and it does not break anything. What git do you
have, as I apparently cannot reproduce it.
