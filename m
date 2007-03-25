From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] update-hook: remove all functionality that should be in hooks/post-receive
Date: Sun, 25 Mar 2007 09:11:51 +0000
Message-ID: <200703251011.53712.andyparkins@gmail.com>
References: <200703231022.00189.andyparkins@gmail.com> <200703241548.13775.andyparkins@gmail.com> <38b2ab8a0703241115q39dc298clb15357268288b49e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Francis Moreau" <francis.moro@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 25 11:14:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVOoQ-0006xh-6o
	for gcvg-git@gmane.org; Sun, 25 Mar 2007 11:14:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933278AbXCYJOv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Mar 2007 05:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933277AbXCYJOv
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Mar 2007 05:14:51 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:48662 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933278AbXCYJOt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2007 05:14:49 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1350585uga
        for <git@vger.kernel.org>; Sun, 25 Mar 2007 02:14:48 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=NB6jz+9Q4lO66XVSKH9/ulc+Sl7O/93YBIuIX8ZoGBdGyba7oYYXBmJkvKnjAsyRY4/GX5R7t2641shPTIox2a6yLwmv6EStPBE73e+kVgbA491ZIEpL+xUb81wWrD1W5X2XI+ann+Tc2cwwVPz3Zac9z5iyBoI5KSkrn7G/+i4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=oPSTkw+I/qhJ0hsL4NTfkoFyklEnFNg1saJ98qH7s4MDtwXItfGk88ayukWlG8n2f9N+5sXFAAEMv/++FUa9BAdQYjzoB7IZuwhask2kNcfT9IXmkxDvn/8X4EgDWBVusP57cepm7rw5GmTD1t878Oaq3jd1vEUeLQNp1qeCGx0=
Received: by 10.66.244.11 with SMTP id r11mr10083972ugh.1174814088083;
        Sun, 25 Mar 2007 02:14:48 -0700 (PDT)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164])
        by mx.google.com with ESMTP id b23sm6706568ugd.2007.03.25.02.14.45;
        Sun, 25 Mar 2007 02:14:47 -0700 (PDT)
User-Agent: KMail/1.9.6
In-Reply-To: <38b2ab8a0703241115q39dc298clb15357268288b49e@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43045>

On Saturday 2007, March 24, Francis Moreau wrote:

> yes that almost would do the thing. But instead of hacking the hook,
> it would be great to have a trivial setup at the begining of the
> script to choose this config.

I'd like Junio's permission before actually doing that; I know he is 
worried about out-of-control growth of hook scripts and it's already 
overly large just to do the one job it's got.

> Maybe a local config in the repo through the command `git config`
> could do the job ?
>
> $ git config hook.update.path "/var/www/"
>
> And if the config is to write the message to a file, skip the email
> stuffs generation (header, foorter...).

Again; it's not hard to do, and I don't mind adding it, but I don't want 
to set off Junio's bloat detector.  Bear in mind also that in the 
example you ask for every repo user would need write access 
to "/var/www"; because the hook script runs as the user performing the 
push.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
