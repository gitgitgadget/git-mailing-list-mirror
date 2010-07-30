From: Geoff Russell <geoffrey.russell@gmail.com>
Subject: Re: finding if a commit is needed
Date: Fri, 30 Jul 2010 19:46:54 +0930
Message-ID: <AANLkTinvLVJbnZ4ZnrszV1taDUS3B-0aWYoD1Q5UyFtA@mail.gmail.com>
References: <AANLkTin4o=uNBFELYMb8TDA=taGJyqpLvgxZcPFr+Pq+@mail.gmail.com>
	<20100729000647.GB29156@dert.cs.uchicago.edu>
Reply-To: geoffrey.russell@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 30 12:17:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OemeK-0005dg-PI
	for gcvg-git-2@lo.gmane.org; Fri, 30 Jul 2010 12:17:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756046Ab0G3KQ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jul 2010 06:16:56 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:42853 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753412Ab0G3KQz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jul 2010 06:16:55 -0400
Received: by gwb20 with SMTP id 20so571753gwb.19
        for <git@vger.kernel.org>; Fri, 30 Jul 2010 03:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:reply-to
         :in-reply-to:references:date:message-id:subject:from:to:cc
         :content-type;
        bh=wJORXdPm1M4eBSt+4sQ9PIXvmhgXT8LwGF1W5tiLDk0=;
        b=R1IjW+eVltFhMYST37Ggf4zmuH7RVEYk/GRxbhQ+4zPod3W5O1OV8d6G4j6yk4QIEr
         sqMkzddE0NKEOdNdwhBcCwCkWhpt8woq3U1QWM+Tr/we/T9ZlJmQl+NDH5h0gXXXG9GJ
         ZvNyRns0w7N9VEm1/1oMZxh2Ije29Kwo5siKA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        b=TT7QUZ82zCJPtZ9BVsnv0jJF1oV7ZmbwmyTXvltNsgGn753rS5ldqgle65G/jJwJYm
         mzKPzM+nurnWOyxlKLT/C8tN2yvlO9cK4684v78luCogF0XYTgHzJIYOYagZJBsu6JRY
         QuGcoDOGH2GmjjKTqj3cAuEaNwTR7ve4EYPlY=
Received: by 10.151.5.12 with SMTP id h12mr2871143ybi.73.1280485014780; Fri, 
	30 Jul 2010 03:16:54 -0700 (PDT)
Received: by 10.229.227.12 with HTTP; Fri, 30 Jul 2010 03:16:54 -0700 (PDT)
In-Reply-To: <20100729000647.GB29156@dert.cs.uchicago.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152236>

On Thu, Jul 29, 2010 at 9:36 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Geoff Russell wrote:
>
>> Is there something which can test whether a commit is needed?
>>
>> I define "needed" as meaning when git commit -a would make a non-identical
>> commit.
>
> Maybe "git diff --exit-code HEAD"?

Thanks ... "git diff --quiet || echo differences"

Cheers,
Geoff.

>
> Regards,
> Jonathan
>



-- 
6 Fifth Ave,
St Morris, S.A. 5068
Australia
Ph: 041 8805 184 / 08 8332 5069
http://perfidy.com.au
