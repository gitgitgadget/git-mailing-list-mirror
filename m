From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: CFT: merge-recursive in C
Date: Wed, 28 Jun 2006 09:32:57 +0200
Message-ID: <81b0412b0606280032j2cd6135bpdd48babddd4da98f@mail.gmail.com>
References: <20060626233838.GA3121@steel.home>
	 <20060628063747.GA983@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Jun 28 09:33:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvUXs-0002vE-MA
	for gcvg-git@gmane.org; Wed, 28 Jun 2006 09:33:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423201AbWF1HdA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Jun 2006 03:33:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423205AbWF1HdA
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jun 2006 03:33:00 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:51553 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1423201AbWF1Hc6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jun 2006 03:32:58 -0400
Received: by ug-out-1314.google.com with SMTP id a2so3014984ugf
        for <git@vger.kernel.org>; Wed, 28 Jun 2006 00:32:57 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HJqGC8IESmiBtzAjpSaDpfkZuAlejMZA4x03Fa4BIXtpgceUsUZ59985wJ47QmdBUb79WOiH9GP19cTuWyb45p8gMLW88z1Nmh/T2B9f0LcA1LNU5kcZSNGRMgcEyjligfIGeMup2EGOA0DpWoOijb8ZVbjjZa7yl18GV4vpzqo=
Received: by 10.78.165.16 with SMTP id n16mr55550hue;
        Wed, 28 Jun 2006 00:32:57 -0700 (PDT)
Received: by 10.78.37.7 with HTTP; Wed, 28 Jun 2006 00:32:57 -0700 (PDT)
To: "Uwe Zeisberger" <zeisberg@informatik.uni-freiburg.de>,
	"Alex Riesen" <raa.lkml@gmail.com>, git@vger.kernel.org
In-Reply-To: <20060628063747.GA983@informatik.uni-freiburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22776>

On 6/28/06, Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de> wrote:
> > +// does not belong here
> Some C compiler (e.g. Sun Forte) don't like C++-style comments.

Yep, I'll change them
