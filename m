From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 07/13] Improve description in "How to merge"
Date: Sat, 24 Aug 2013 22:08:20 -0700
Message-ID: <20130825050820.GJ2882@elie.Belkin>
References: <282216171.1090748.1377328932833.JavaMail.ngmail@webmail08.arcor-online.net>
 <8609038.1091034.1377329428557.JavaMail.ngmail@webmail08.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, wking@tremily.us
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Sun Aug 25 07:08:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDSYv-00055q-La
	for gcvg-git-2@plane.gmane.org; Sun, 25 Aug 2013 07:08:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755923Ab3HYFIZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Aug 2013 01:08:25 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:47904 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755853Ab3HYFIY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Aug 2013 01:08:24 -0400
Received: by mail-pa0-f43.google.com with SMTP id hz10so2181205pad.16
        for <git@vger.kernel.org>; Sat, 24 Aug 2013 22:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=5YS1M1RPWcydM5g6dGbgQUKkk4ChrRHlfEDpzTfF1XA=;
        b=EE+vQKIDZy6qNmdAEkR/XxQWH1kgu36zTBvfw6DAauiNeC2jScMimXf9G2rESk6xZe
         gRZwf6EcA0X4NtefQwroS8DCkD2ckrGmqsOnmOD6avOhAFjXoqskkIr7oMlEIOW3utS6
         vfSaDPhBOfkq+68yoIdNxBjO60jcYTbRahyZAU2JmB45V+3indRbO8uFG8DzSYvZZq6r
         psiTV1mUIfjntSXNwkC9ts86fJXEor/9Aqij4dMNFLhAroeqBTtoBhM5M5Lf9UmoYzgY
         hSOKoMlFza7Bv+gm2Owp5aqKP91Qcr4wuejK0klmSC8rVh3O+JPpDgAEREj24xjFHotF
         zCqQ==
X-Received: by 10.67.21.130 with SMTP id hk2mr7678625pad.76.1377407304481;
        Sat, 24 Aug 2013 22:08:24 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id ot4sm11404086pac.17.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 24 Aug 2013 22:08:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <8609038.1091034.1377329428557.JavaMail.ngmail@webmail08.arcor-online.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232917>

Thomas Ackermann wrote:

> Describe the conflict resolution in terms of the
> commands the user is supposed to use.
[...]
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -1251,10 +1251,8 @@ Automatic merge failed; fix conflicts and then commit the result.
>  -------------------------------------------------
>  
>  Conflict markers are left in the problematic files, and after
> -you resolve the conflicts manually, you can update the index
> -with the contents and run Git commit, as you normally would when
> -creating a new file.

Hm.  It's been too long since I was a novice, since I find the above
clear already.

To make the text clearer, I think it would be best to *add* an example
instead of replacing it by one.

Thanks,
Jonathan
