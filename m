From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 01/17] Avoid declaration after statement
Date: Mon, 14 Sep 2009 16:10:35 +0200
Message-ID: <81b0412b0909140710y586f0464vc7a3b08460f453d@mail.gmail.com>
References: <cover.1252925290.git.mstormo@gmail.com>
	 <1b36d8e041c9c1a6dc68f9cc3919fcf91b7a9ac6.1252925290.git.mstormo@gmail.com>
	 <81b0412b0909140659p2472c026gaece8b9388fb21d6@mail.gmail.com>
	 <1976ea660909140704r4b730002o5d3f42463b57828d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Marius Storm-Olsen <mstormo@gmail.com>, Johannes.Schindelin@gmx.de,
	msysgit@googlegroups.com, git@vger.kernel.org
To: Frank Li <lznuaa@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 14 16:10:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnCGQ-00072r-Vc
	for gcvg-git-2@lo.gmane.org; Mon, 14 Sep 2009 16:10:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755419AbZINOKd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2009 10:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755287AbZINOKd
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Sep 2009 10:10:33 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:61573 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755199AbZINOKd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2009 10:10:33 -0400
Received: by fxm17 with SMTP id 17so859633fxm.37
        for <git@vger.kernel.org>; Mon, 14 Sep 2009 07:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=uAuwAAhaej8jLYdYVfTljEN2SCuNt/6UpR3IkuVc7Qc=;
        b=FrGSZ9cn8jqGH8KJWItpcTiC80Le6Etls+5mHerb/XO6XMO5rbznmTbskDnGLuJ1JP
         QZKsWo1CT7KcpLOY7UwWLnPKGD/BkNEFr0YOZHYz4FAvncoylTtfrHXjhSf9sMqPaisL
         /FQL5NPUE+bq+DI+SXSQ5QeVIqjouGnRpyEQI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=mxFzq0iKqe3aOhK3SyT9zoBEfb2xLOzEoM2Up9D7GlaPGL6MNISIQdNPNH+AmhYCNu
         EDnvM0oLxIpjN9iP4czuNY7F7UzsUlRrBQ7UYqTeEKmlc1rQcf3Vej6XYW+jurC1kRpc
         Rp3pjsaDfuaqI5UyxqI6U/IsNTks39/53tUZU=
Received: by 10.204.153.27 with SMTP id i27mr5168911bkw.155.1252937435864; 
	Mon, 14 Sep 2009 07:10:35 -0700 (PDT)
In-Reply-To: <1976ea660909140704r4b730002o5d3f42463b57828d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128485>

On Mon, Sep 14, 2009 at 16:04, Frank Li <lznuaa@gmail.com> wrote:
>>>
>>> Microsoft Visual C++ does not understand this C99 style
>>>
>>
>> But you don't use the C++ compiler (which does understand that syntax).
>>
>
> Microsoft Visual C++ is product name. If you think it is confuse, it
> can change to "MSVC"
>

I do. OTOH, some people actually use a "product" to compile "software",
so maybe it is okay.
