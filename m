From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH 02/12] git-grep: support --no-external-grep
Date: Fri, 25 Jul 2008 06:16:59 +0700
Message-ID: <fcaeb9bf0807241616k787ea8cco75d1a93a3eb516@mail.gmail.com>
References: <20080723145549.GA29067@laptop> <20080724202634.GB3760@blimp.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 25 01:18:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMA4X-0006s6-Nt
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 01:18:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755124AbYGXXRF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 19:17:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755416AbYGXXRD
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 19:17:03 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:64221 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755197AbYGXXRB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 19:17:01 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1528872fgg.17
        for <git@vger.kernel.org>; Thu, 24 Jul 2008 16:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=VApyFL6GcFgUsrlH6lpiarnX8zLfcjZV1VZnhVmHa2o=;
        b=U+Fw7OUsaPnbTMZr3PtxoFH7HSbSCffg8tehRfts15kiyH7narc6O61I+lN7NLpqSX
         sWARFme+mb/rYilAycahwDuoV2eym4M9svr5NEjjZ7Rm81nDabHjLZgNj/8JHMsrrGm+
         EVTeFuGh/JPSIsVrk+5fJ5xs2gOL3vYBphOog=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=rBYw1lbH4sektJYE0NY+TA65eOByh12zUwBxPiUF0w/gh/eorFzV5SyF4eROoeCzUj
         4RAWQKmB73mnO9M/WPcxIxV8Jcz0bgUl/wY+JvyEsOdnPLJ8ROrOfZWEbSwfV37IJdBH
         3Z7vkMdJbeiw8KhypqZhpJg6x3jN9SL159SNE=
Received: by 10.86.87.5 with SMTP id k5mr1337822fgb.59.1216941420013;
        Thu, 24 Jul 2008 16:17:00 -0700 (PDT)
Received: by 10.86.91.2 with HTTP; Thu, 24 Jul 2008 16:16:59 -0700 (PDT)
In-Reply-To: <20080724202634.GB3760@blimp.local>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89969>

On 7/25/08, Alex Riesen <raa.lkml@gmail.com> wrote:
> Nguyen Thai Ngoc Duy, Wed, Jul 23, 2008 16:55:49 +0200:
>
> >
>  > +static int no_external_grep;
>  > +
>
>
> If you have used direct logic instead of negative, your patch would
>  have been simplier and the code would be easier to understand. I.e.:

Point taken.

>  +               if (!strcmp("--no-external-grep", arg)) {
>  +                       external_grep = 0;
>  +                       continue;
>  +               }
>
>  BTW, how about a config option for this? And maybe --external-grep={yes|no}

I don't need --external-grep=yes now, but that would be good for
testing external grep. About config option, is it really needed?
-- 
Duy
