From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Remove bashism from t3210-pack-refs.sh
Date: Fri, 6 Oct 2006 15:35:21 +0200
Message-ID: <81b0412b0610060635n51482e71wab02f9a11be4e619@mail.gmail.com>
References: <20061006091054.15209.35068.stgit@leonov.stosberg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 06 15:35:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVprW-0005Lz-8u
	for gcvg-git@gmane.org; Fri, 06 Oct 2006 15:35:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422651AbWJFNfZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Oct 2006 09:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422650AbWJFNfZ
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Oct 2006 09:35:25 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:56448 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1422651AbWJFNfW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Oct 2006 09:35:22 -0400
Received: by ug-out-1314.google.com with SMTP id o38so316180ugd
        for <git@vger.kernel.org>; Fri, 06 Oct 2006 06:35:21 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OgYdX3lHhY0mMrhBlSaUauJYimzh1bspG7T24+kHHjqkq+Cc09TfvSRM2mgNT2+r84A3veVSExERGD7bkpdDbl8pUGaaB94veb6Nq/0ho8yvkBKqhbQLsbS+iZqmfG6l1qACEjsjojHNq1MWj/pyj/ZZxd0vai8rOy0W8N4bRzw=
Received: by 10.78.176.20 with SMTP id y20mr1716437hue;
        Fri, 06 Oct 2006 06:35:21 -0700 (PDT)
Received: by 10.78.115.8 with HTTP; Fri, 6 Oct 2006 06:35:21 -0700 (PDT)
To: "Dennis Stosberg" <dennis@stosberg.net>
In-Reply-To: <20061006091054.15209.35068.stgit@leonov.stosberg.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28401>

On 10/6/06, Dennis Stosberg <dennis@stosberg.net> wrote:
> -     SHA1=$(< .git/refs/heads/a) &&
> +     SHA1=`cat .git/refs/heads/a` &&

Only "<" (the redirection part) is bashism. The "$()" is POSIX.
