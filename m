From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] minor diff between gitweb docs and actual template for
 $GIT/description
Date: Thu, 10 Jan 2013 18:22:01 -0800
Message-ID: <20130111022200.GH30784@google.com>
References: <50EF5DC8.1000500@tim.thechases.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Tim Chase <git@tim.thechases.com>
X-From: git-owner@vger.kernel.org Fri Jan 11 03:22:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtUGK-0007mZ-5y
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jan 2013 03:22:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754449Ab3AKCWH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2013 21:22:07 -0500
Received: from mail-da0-f43.google.com ([209.85.210.43]:48036 "EHLO
	mail-da0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753427Ab3AKCWF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2013 21:22:05 -0500
Received: by mail-da0-f43.google.com with SMTP id u36so533969dak.30
        for <git@vger.kernel.org>; Thu, 10 Jan 2013 18:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=jZjXoR8jYsJfQfZ5/xgEBp0S9Q47Ki7FmmLPJtZiWJA=;
        b=fVVMOOcy9UYr0SNVxuX9BV4wECelaXK7DWnQEKGKO5sbW2OsflILSuic9h7RJqIdf/
         D4nkE+QRyWQSkooEYpEhZR1qhpuDp/a8/4V4evDes3jUUWxKmbaZ2zUWmXxlMLKvOXYj
         TkJlLe54064pbcq+wGqPTqv2hPj4vn/YWx2Zj/a8+W1k+x/IV4myW28rxK5beeo32jGB
         qnVOeVOyLLpVDNVFO3ZeD5zk1ujd5XzdEs9SX8sd3iy7zPp3NmMFV8ywkvjUXfZhSkpR
         uvGsJCUBYqTS0IjrT+/vrQPrY8IuYyPTPfseVj0QNkMnCRiPzLcA1jHAXtAAVs71ZbIq
         hftQ==
X-Received: by 10.68.222.232 with SMTP id qp8mr45222157pbc.99.1357870925225;
        Thu, 10 Jan 2013 18:22:05 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id x2sm2101058paw.8.2013.01.10.18.22.03
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 10 Jan 2013 18:22:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <50EF5DC8.1000500@tim.thechases.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213164>

(+cc: Jakub, who maintains gitweb)
Hi Tim,

Tim Chase wrote:

> The documentation for gitweb gives one description of the default
> content for the $GIT/description, the description template has other
> text.  One of these two patches should be applied to bring them into
> order (applying both would just reverse the problem).  Or, both
> could be changed to the same new text.

May we have your sign-off?  (See Documentation/SubmittingPatches for
what this means.)

> --- a/Documentation/gitweb.txt
> +++ b/Documentation/gitweb.txt
> @@ -227,7 +227,7 @@ description (or `gitweb.description`)::
>  	repository).  Plain text file; HTML will be escaped.  By default set to
>  +
>  -------------------------------------------------------------------------------
> -Unnamed repository; edit this file to name it for gitweb.
> +Unnamed repository; edit this file 'description' to name the repository.
>  -------------------------------------------------------------------------------
>  +
>  from the template during repository creation, usually installed in

Looks sane to me.  Thanks for noticing.

Regards,
Jonathan
