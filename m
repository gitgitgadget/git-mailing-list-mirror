From: "Sverre Hvammen Johansen" <hvammen@gmail.com>
Subject: Re: [RFC/PATCH] Fast forward strategies allow, never, and only
Date: Tue, 11 Mar 2008 20:24:02 -0800
Message-ID: <402c10cd0803112124i2726c32m75b9353d902df320@mail.gmail.com>
References: <402c10cd0803101959q619efa86pbd501e5e2cc018c2@mail.gmail.com>
	 <m33aqxzknl.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 05:25:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZIWb-00038J-3R
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 05:25:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501AbYCLEYJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 00:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751468AbYCLEYI
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 00:24:08 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:28900 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751603AbYCLEYH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 00:24:07 -0400
Received: by fg-out-1718.google.com with SMTP id e21so2704434fga.17
        for <git@vger.kernel.org>; Tue, 11 Mar 2008 21:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=hSj4xns0fFKfVlvZBDc11JnvDH7beXD0YTLz4am/NeU=;
        b=kN2QOByVAYxflTjhi5gxt8ji2rkcmv7e15g/JR8ustzM/vacStOkBvA4RycnW2FfZkP2xtlmLsNDp2HdvD5sQ1vNqwbvoG2fB4YEmYvPAFU56MRkB98izD1hhCYIT+QwdLljoVFW1UTdCtHIJu1xZ9r/7o4rY2L25oP3CmyxpWs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qNJ+O0DfnrU7nRyOZhpb5Pa7/+1keRdj7cwGuGr54xV+76ejMawUw9u3/zaxD6c0xk16VjvpcvFHPJV5xWMpsDNe3siW4NWfsNJP6NlB1tYGxrDFKVZoYkNldvvJrAykDTMDJuYbEcX0ePnA6LSMR5TL8POCABh07yQDmCggxhE=
Received: by 10.82.153.5 with SMTP id a5mr18577346bue.5.1205295844201;
        Tue, 11 Mar 2008 21:24:04 -0700 (PDT)
Received: by 10.82.172.14 with HTTP; Tue, 11 Mar 2008 21:24:02 -0700 (PDT)
In-Reply-To: <m33aqxzknl.fsf@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76920>

On Tue, Mar 11, 2008 at 1:15 AM, Jakub Narebski <jnareb@gmail.com> wrote:
>  > +never::
>  > +     Generate a merge commit even if the merge resolved
>  > +     as a fast-forward.
>
>  This is equivalent of current '--no-ff'; nevertheless I think that it
>  would be better to name this strategy 'commit' or 'merge', as in
>  --ff=merge, or --ff=commit.

If there is consensus to change this I will.

>  > +only::
>  > +     Only allow a fast-forward.  The merge will fail
>  > +     unless HEAD is up to date or the merge resolved as
>  > +     a fast-forward.
>
>  This is equivalent of '--ff-only' or '--strategy=ff'... Errr...
>  I'm sorry, such option does not exist, and it would be I guess
>  useful addition to default non '+' fetch refspec allowing fast-forward
>  only, and to receive.denyNonFastForwards to control push behavior.

I agree, but it is over my head to implement this now.

-- 
Sverre Hvammen Johansen
