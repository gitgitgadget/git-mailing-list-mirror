From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] remove inline iteration variable
Date: Wed, 16 Aug 2006 09:27:49 +0200
Message-ID: <81b0412b0608160027l2ac53c10gd9a75525ca144f1d@mail.gmail.com>
References: <Pine.LNX.4.63.0608151022340.26891@chino.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 16 09:27:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDFog-0002m3-Bq
	for gcvg-git@gmane.org; Wed, 16 Aug 2006 09:27:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750976AbWHPH1v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Aug 2006 03:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750978AbWHPH1v
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Aug 2006 03:27:51 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:5683 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750976AbWHPH1u (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Aug 2006 03:27:50 -0400
Received: by nf-out-0910.google.com with SMTP id x30so602676nfb
        for <git@vger.kernel.org>; Wed, 16 Aug 2006 00:27:49 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Lx5S0EfO4yW8BM5NXlFKWI/4izfmBIdIlVZ3U5JcdjEI8YubH1m7vWyNvUJmglM7J35UQH/TekTUVqGzGX9IL8qo8ppLzJ6iUmQcTANyYyqDzJwuQkMCsmM2XTR06GHwAhRzuIzi8hbomQO6kPW4gE1wIAm3j0JqcKaCnUKgoRk=
Received: by 10.49.8.15 with SMTP id l15mr321825nfi;
        Wed, 16 Aug 2006 00:27:49 -0700 (PDT)
Received: by 10.78.160.12 with HTTP; Wed, 16 Aug 2006 00:27:48 -0700 (PDT)
To: "David Rientjes" <rientjes@google.com>
In-Reply-To: <Pine.LNX.4.63.0608151022340.26891@chino.corp.google.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25506>

On 8/15/06, David Rientjes <rientjes@google.com> wrote:
> Remove unnecessary iteration variable in inline.
> -       for (i = 0; i < in; i++) putchar(' ');
> +       for (; in > 0; in--)

while(in--) putchar(' ');
